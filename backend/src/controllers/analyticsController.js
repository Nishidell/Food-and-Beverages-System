import pool from "../config/mysql.js";

// Helper to run a query safely (The Safety Net)
const safeQuery = async (sql, params, fallbackValue) => {
  try {
    const [rows] = await pool.query(sql, params);
    return rows;
  } catch (error) {
    console.error(`Partial Analytics Error: ${error.message}`);
    return fallbackValue; // Return safe fallback (e.g., empty array)
  }
};

// @desc    Get all dashboard analytics data (Current Month Focus)
// @route   GET /api/analytics
// @access  Admin
export const getDashboardAnalytics = async (req, res) => {
  try {
    const { order_type } = req.query;

    let typeCondition = "";
    let queryParams = [];

    if (order_type && order_type !== 'All') {
      typeCondition = "AND order_type = ?";
      queryParams = [order_type];
    }

    // Date Filter for "Monthly Reset" logic
    const monthCondition = `AND YEAR(o.order_date) = YEAR(NOW()) AND MONTH(o.order_date) = MONTH(NOW())`;

    // Execute all queries in parallel with safety nets
    const [
      salesToday,
      salesYesterday,
      salesThisWeek,
      salesThisMonth,
      topSellingItems,
      paymentMethods,
      orderTypeDistribution,
      peakHours,
    ] = await Promise.all([
      // 1. Sales Today (Fallback: Empty Array)
      safeQuery(
        `SELECT COUNT(order_id) AS fb_orders, SUM(total_amount) AS sales, AVG(total_amount) AS avg_sale 
         FROM fb_orders WHERE DATE(order_date) = CURDATE() AND status != 'cancelled' ${typeCondition}`,
        queryParams,
        [{ fb_orders: 0, sales: 0, avg_sale: 0 }]
      ),
      // 2. Sales Yesterday
      safeQuery(
        `SELECT COUNT(order_id) AS fb_orders, SUM(total_amount) AS sales, AVG(total_amount) AS avg_sale 
         FROM fb_orders WHERE DATE(order_date) = CURDATE() - INTERVAL 1 DAY AND status != 'cancelled' ${typeCondition}`,
        queryParams,
        [{ fb_orders: 0, sales: 0, avg_sale: 0 }]
      ),
      // 3. This Week
      safeQuery(
        `SELECT COUNT(order_id) AS fb_orders, SUM(total_amount) AS sales, AVG(total_amount) AS avg_sale 
         FROM fb_orders WHERE YEARWEEK(order_date, 1) = YEARWEEK(NOW(), 1) AND status != 'cancelled' ${typeCondition}`,
        queryParams,
        [{ fb_orders: 0, sales: 0, avg_sale: 0 }]
      ),
      // 4. This Month
      safeQuery(
        `SELECT COUNT(order_id) AS fb_orders, SUM(total_amount) AS sales, AVG(total_amount) AS avg_sale 
         FROM fb_orders WHERE YEAR(order_date) = YEAR(NOW()) AND MONTH(order_date) = MONTH(NOW()) AND status != 'cancelled' ${typeCondition}`,
        queryParams,
        [{ fb_orders: 0, sales: 0, avg_sale: 0 }]
      ),

      // 5. Top Selling Items (Fallback: Empty Array)
      safeQuery(
        `SELECT mi.item_name, SUM(od.quantity) AS total_sold, SUM(od.subtotal) AS total_sales 
         FROM fb_order_details od
         JOIN fb_menu_items mi ON od.item_id = mi.item_id
         JOIN fb_orders o ON od.order_id = o.order_id
         WHERE o.status != 'cancelled' ${typeCondition} ${monthCondition}
         GROUP BY od.item_id, mi.item_name
         ORDER BY total_sales DESC LIMIT 7`,
        queryParams,
        []
      ),

      // 6. Payment Methods
      safeQuery(
        `SELECT p.payment_method, COUNT(p.payment_id) AS transactions, SUM(p.amount) AS total_value 
         FROM fb_payments p
         JOIN fb_orders o ON p.order_id = o.order_id
         WHERE p.payment_status = 'paid' AND o.status != 'cancelled' ${monthCondition}
         GROUP BY p.payment_method`,
        [],
        []
      ),

          // 7. Order Type Distribution (Smart Fix)
          safeQuery(
        `SELECT 
          CASE 
            -- 1. If it has a Room ID, it IS Room Dining (ignore the label)
            WHEN o.room_id IS NOT NULL AND o.room_id > 0 THEN 'Room Dining'
            -- 2. Fallback: If text says "Room", it IS Room Dining
            WHEN o.delivery_location LIKE 'Room%' THEN 'Room Dining'
            -- 3. Otherwise, trust the stored label
            ELSE o.order_type 
          END AS order_type, 
          
          COUNT(o.order_id) AS orders, 
          SUM(o.total_amount) AS total_value 
        FROM fb_orders o
        WHERE o.status != 'cancelled' ${typeCondition} ${monthCondition}
        GROUP BY 
          CASE 
            WHEN o.room_id IS NOT NULL AND o.room_id > 0 THEN 'Room Dining'
            WHEN o.delivery_location LIKE 'Room%' THEN 'Room Dining'
            ELSE o.order_type 
          END`,
        queryParams,
        []
      ),

      // 8. Peak Hours
      safeQuery(
        `SELECT HOUR(order_date) AS hour, COUNT(order_id) AS order_count 
         FROM fb_orders o
         WHERE status != 'cancelled' ${typeCondition} ${monthCondition}
         GROUP BY hour ORDER BY order_count DESC LIMIT 1`,
        queryParams,
        []
      ),
    ]);
    
    // Respond with data (using ?. checks to be extra safe)
    res.json({
      salesTrends: {
        today: salesToday[0] || {},
        yesterday: salesYesterday[0] || {},
        thisWeek: salesThisWeek[0] || {},
        thisMonth: salesThisMonth[0] || {},
      },
      topSellingItems: topSellingItems || [],
      paymentMethods: paymentMethods || [],
      orderTypeDistribution: orderTypeDistribution || [],
      peakHour: peakHours[0] ? `${peakHours[0].hour}:00 - ${peakHours[0].hour + 1}:00` : "N/A",
    });

  } catch (error) {
    console.error("Critical Analytics Error:", error);
    res.status(500).json({ message: "Server error fetching analytics", error: error.message });
  }
};
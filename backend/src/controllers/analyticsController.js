import pool from "../config/mysql.js";

const safeQuery = async (sql, params, fallbackValue) => {
  try {
    const [rows] = await pool.query(sql, params);
    return rows;
  } catch (error) {
    console.error(`Partial Analytics Error: ${error.message}`);
    return fallbackValue;
  }
};

export const getDashboardAnalytics = async (req, res) => {
  try {
    // 1. Get Dates from Query
    const { order_type, startDate, endDate } = req.query;

    let typeCondition = "";
    let queryParams = []; // Params for Type Filter
    let debugMessage = "No Filter Applied";

    // --- A. HANDLE ORDER TYPE FILTER ---
    const filter = order_type ? order_type.trim() : 'All';

    if (filter !== 'All') {
        // Smart Filter for Room Service
        if (['Room Dining', 'Room Service', 'room dining', 'room service'].includes(filter)) {
            debugMessage = "✅ MATCHED: Smart Room Filter";
            typeCondition = "AND (o.order_type IN ('Room Dining', 'Room Service') OR o.delivery_location LIKE 'Room%' OR o.room_id > 0)";
        } 
        else if (filter === 'Dine-in') {
            debugMessage = "✅ MATCHED: Smart Dine-in Filter";
            typeCondition = "AND o.order_type = 'Dine-in' AND (o.delivery_location NOT LIKE 'Room%' AND (o.room_id IS NULL OR o.room_id = 0))";
        } 
        else {
            debugMessage = "⚠️ FALLBACK: Standard Exact Match";
            typeCondition = "AND o.order_type = ?";
            queryParams = [filter];
        }
    }

    // --- B. HANDLE DATE FILTER (New Logic) ---
    let dateCondition = "";
    let dateParams = [];

    if (startDate && endDate) {
        // If frontend sends dates, use them (Covers Today, Yesterday, Week, Custom)
        dateCondition = "AND DATE(o.order_date) BETWEEN ? AND ?";
        dateParams = [startDate, endDate];
    } else {
        // Default Fallback: Show "This Month" if no date selected
        dateCondition = "AND YEAR(o.order_date) = YEAR(NOW()) AND MONTH(o.order_date) = MONTH(NOW())";
    }

    // Combine params for queries that use BOTH filters
    const allParams = [...queryParams, ...dateParams];

    // Execute queries
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
      // 1-4: SALES TRENDS CARDS (Keep these STATIC so they always show the summary)
      safeQuery(
        `SELECT COUNT(o.order_id) AS fb_orders, SUM(o.total_amount) AS sales 
         FROM fb_orders o 
         WHERE DATE(o.order_date) = CURDATE() AND o.status != 'cancelled' ${typeCondition}`,
        queryParams, [{ fb_orders: 0, sales: 0 }]
      ),
      safeQuery(
        `SELECT COUNT(o.order_id) AS fb_orders, SUM(o.total_amount) AS sales
         FROM fb_orders o 
         WHERE DATE(o.order_date) = CURDATE() - INTERVAL 1 DAY AND o.status != 'cancelled' ${typeCondition}`,
        queryParams, [{ fb_orders: 0, sales: 0 }]
      ),
      safeQuery(
        `SELECT COUNT(o.order_id) AS fb_orders, SUM(o.total_amount) AS sales
         FROM fb_orders o 
         WHERE YEARWEEK(o.order_date, 1) = YEARWEEK(NOW(), 1) AND o.status != 'cancelled' ${typeCondition}`,
        queryParams, [{ fb_orders: 0, sales: 0 }]
      ),
      safeQuery(
        `SELECT COUNT(o.order_id) AS fb_orders, SUM(o.total_amount) AS sales
         FROM fb_orders o 
         WHERE YEAR(o.order_date) = YEAR(NOW()) AND MONTH(o.order_date) = MONTH(NOW()) AND o.status != 'cancelled' ${typeCondition}`,
        queryParams, [{ fb_orders: 0, sales: 0 }]
      ),

      // 5. Top Items (✅ NOW DYNAMIC: Uses dateCondition instead of hardcoded month)
      safeQuery(
        `SELECT mi.item_name, SUM(od.quantity) AS total_sold, SUM(od.subtotal) AS total_sales 
         FROM fb_order_details od
         JOIN fb_menu_items mi ON od.item_id = mi.item_id
         JOIN fb_orders o ON od.order_id = o.order_id
         WHERE o.status != 'cancelled' ${typeCondition} ${dateCondition}
         GROUP BY od.item_id, mi.item_name
         ORDER BY total_sold DESC LIMIT 7`, 
        allParams, // Use combined params
        []
      ),

      // 6. Payment Methods (✅ NOW DYNAMIC)
      safeQuery(
        `SELECT p.payment_method, COUNT(p.payment_id) AS transactions, SUM(p.amount) AS total_value 
         FROM fb_payments p
         JOIN fb_orders o ON p.order_id = o.order_id
         WHERE p.payment_status = 'paid' AND o.status != 'cancelled' ${typeCondition} ${dateCondition}
         GROUP BY p.payment_method`,
        allParams,
        []
      ),
      
      // 7. Order Type Distribution (✅ NOW DYNAMIC)
      safeQuery(
        `SELECT 
           CASE 
             WHEN o.room_id IS NOT NULL AND o.room_id > 0 THEN 'Room Dining'
             WHEN o.delivery_location LIKE 'Room%' THEN 'Room Dining'
             ELSE o.order_type 
           END AS order_type, 
           COUNT(o.order_id) AS orders, 
           SUM(o.total_amount) AS total_value 
         FROM fb_orders o
         WHERE o.status != 'cancelled' ${typeCondition} ${dateCondition}
         GROUP BY 
           CASE 
             WHEN o.room_id IS NOT NULL AND o.room_id > 0 THEN 'Room Dining'
             WHEN o.delivery_location LIKE 'Room%' THEN 'Room Dining'
             ELSE o.order_type 
           END`,
        allParams, []
      ),

      // 8. Peak Hours (✅ NOW DYNAMIC)
      safeQuery(
        `SELECT HOUR(o.order_date) AS hour, COUNT(o.order_id) AS order_count 
         FROM fb_orders o
         WHERE o.status != 'cancelled' ${typeCondition} ${dateCondition}
         GROUP BY hour ORDER BY order_count DESC LIMIT 1`,
        allParams, []
      ),
    ]);
    
    res.json({
      debug: {
          received_filter: filter,
          dates: { startDate, endDate },
          generated_sql_condition: typeCondition + " " + dateCondition
      },
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
    res.status(500).json({ message: "Server error", error: error.message });
  }
};
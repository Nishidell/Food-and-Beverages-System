import pool from "../config/mysql.js";

// Helper function to run a query
const runQuery = async (sql, params = []) => {
  try {
    const [rows] = await pool.query(sql, params);
    return rows;
  } catch (error) {
    console.error("SQL Error in analyticsController:", error.message);
    throw error; 
  }
};

// @desc    Get all dashboard analytics data
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
      // --- Sales Trends (UPDATED: Read from VIEW) ---
      // We use 'calculated_total_amount' to ensure mathematical accuracy
      
      // Today
      runQuery(
        `SELECT 
          COUNT(order_id) AS fb_orders, 
          SUM(calculated_total_amount) AS sales, 
          AVG(calculated_total_amount) AS avg_sale 
        FROM fb_view_orders_live 
        WHERE DATE(order_date) = CURDATE() AND status != 'cancelled' ${typeCondition}`,
        queryParams
      ),
      // Yesterday
      runQuery(
        `SELECT 
          COUNT(order_id) AS fb_orders, 
          SUM(calculated_total_amount) AS sales, 
          AVG(calculated_total_amount) AS avg_sale 
        FROM fb_view_orders_live 
        WHERE DATE(order_date) = CURDATE() - INTERVAL 1 DAY AND status != 'cancelled' ${typeCondition}`,
        queryParams
      ),
      // This Week
      runQuery(
        `SELECT 
          COUNT(order_id) AS fb_orders, 
          SUM(calculated_total_amount) AS sales, 
          AVG(calculated_total_amount) AS avg_sale 
        FROM fb_view_orders_live 
        WHERE YEARWEEK(order_date, 1) = YEARWEEK(NOW(), 1) AND status != 'cancelled' ${typeCondition}`,
        queryParams
      ),
      // This Month
      runQuery(
        `SELECT 
          COUNT(order_id) AS fb_orders, 
          SUM(calculated_total_amount) AS sales, 
          AVG(calculated_total_amount) AS avg_sale 
        FROM fb_view_orders_live 
        WHERE YEAR(order_date) = YEAR(NOW()) AND MONTH(order_date) = MONTH(NOW()) AND status != 'cancelled' ${typeCondition}`,
        queryParams
      ),

      // --- Top Selling Items ---
      // This joins Order Details, so we can keep using the base tables for performance,
      // OR we can join the View if we want to be strict. 
      // Since we need 'quantity' which is in details, sticking to base tables here is safe 
      // as long as we trust the 'status' column.
      runQuery(
        `SELECT 
          mi.item_name, 
          SUM(od.quantity) AS total_sold, 
          SUM(od.subtotal) AS total_sales 
        FROM fb_order_details od
        JOIN fb_menu_items mi ON od.item_id = mi.item_id
        JOIN fb_orders o ON od.order_id = o.order_id
        WHERE o.status != 'cancelled' ${typeCondition}
        GROUP BY od.item_id, mi.item_name
        ORDER BY total_sales DESC
        LIMIT 7`,
        queryParams
      ),

      // --- Payment Methods ---
      runQuery(
        `SELECT 
          payment_method, 
          COUNT(payment_id) AS transactions, 
          SUM(amount) AS total_value 
        FROM fb_payments 
        WHERE payment_status = 'paid'
        GROUP BY payment_method`
      ),

      // --- Order Type Distribution (UPDATED: Read from VIEW) ---
      runQuery(
        `SELECT 
          order_type, 
          COUNT(order_id) AS orders, 
          SUM(calculated_total_amount) AS total_value 
        FROM fb_view_orders_live 
        WHERE status != 'cancelled' ${typeCondition}
        GROUP BY order_type`,
        queryParams
      ),

      // --- Peak Hours (UPDATED: Read from VIEW) ---
      runQuery(
        `SELECT 
          HOUR(order_date) AS hour, 
          COUNT(order_id) AS order_count 
        FROM fb_view_orders_live 
        WHERE status != 'cancelled' ${typeCondition}
        GROUP BY hour 
        ORDER BY order_count DESC 
        LIMIT 1`,
        queryParams
      ),
    ]);

    res.json({
      salesTrends: {
        today: salesToday[0],
        yesterday: salesYesterday[0],
        thisWeek: salesThisWeek[0],
        thisMonth: salesThisMonth[0],
      },
      topSellingItems: topSellingItems,
      paymentMethods: paymentMethods,
      orderTypeDistribution: orderTypeDistribution,
      peakHour: peakHours[0] ? `${peakHours[0].hour}:00 - ${peakHours[0].hour + 1}:00` : "N/A",
    });

  } catch (error) {
    console.error("Analytics Error:", error);
    res.status(500).json({ message: "Server error fetching analytics", error: error.message });
  }
};
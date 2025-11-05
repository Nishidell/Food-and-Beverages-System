import pool from "../config/mysql.js";

// Helper to calculate growth percentage
const calculateGrowth = (today, yesterday) => {
  if (yesterday > 0) {
    return parseFloat(((today - yesterday) / yesterday * 100).toFixed(2));
  }
  return today > 0 ? 100 : 0; // If yesterday = 0 and today > 0 => 100%
};

// --- GET Dashboard Summary ---
export const getDashboardSummary = async (req, res) => {
  try {
    // --- Total Sales ---
    const [salesTodayRows] = await pool.query(`
      SELECT SUM(amount) AS total
      FROM payments
      WHERE payment_status IN ('paid', 'pending')
      AND DATE(payment_date) = CURDATE()
    `);

    const [salesYesterdayRows] = await pool.query(`
      SELECT SUM(amount) AS total
      FROM payments
      WHERE payment_status = 'paid'
      AND DATE(payment_date) = CURDATE() - INTERVAL 1 DAY
    `);

    const totalSales = salesTodayRows[0].total || 0;
    const salesGrowth = calculateGrowth(totalSales, salesYesterdayRows[0].total || 0);

    // --- Active Orders ---
    const [ordersTodayRows] = await pool.query(`
      SELECT COUNT(*) AS total
      FROM orders
      WHERE DATE(order_date) = CURDATE() AND status != 'Completed'
    `);

    const [ordersYesterdayRows] = await pool.query(`
      SELECT COUNT(*) AS total
      FROM orders
      WHERE DATE(order_date) = CURDATE() - INTERVAL 1 DAY AND status != 'Completed'
    `);

    const activeOrders = ordersTodayRows[0].total || 0;
    const ordersGrowth = calculateGrowth(activeOrders, ordersYesterdayRows[0].total || 0);

    // --- Low Stock Items ---
    // --- MODIFICATION 1: Using 'reorder_point' ---
    const [lowStockRows] = await pool.query(`
      SELECT COUNT(*) AS total
      FROM ingredients
      WHERE stock_level <= reorder_point
    `);

    const lowStock = lowStockRows[0].total || 0;
    const lowStockGrowth = 0; // Could implement historical snapshot if needed

    // --- Total Customers ---
    const [customersTodayRows] = await pool.query(`
      SELECT COUNT(*) AS total
      FROM customers
      WHERE DATE(created_at) = CURDATE()
    `);

    const [customersYesterdayRows] = await pool.query(`
      SELECT COUNT(*) AS total
      FROM customers
      WHERE DATE(created_at) = CURDATE() - INTERVAL 1 DAY
    `);

    const totalCustomers = customersTodayRows[0].total || 0;
    const customerGrowth = calculateGrowth(totalCustomers, customersYesterdayRows[0].total || 0);

    // --- Recent Orders (last 5) ---
    const [recentOrders] = await pool.query(`
      SELECT order_id, customer_id, order_date, status, total_amount, order_type, delivery_location
      FROM orders
      ORDER BY order_date DESC
      LIMIT 5
    `);

    // --- Low Stock Alerts (full details) ---
    // --- MODIFICATION 2: Using 'reorder_point' and sorting for urgency ---
    const [stockAlerts] = await pool.query(`
      SELECT ingredient_id, name, stock_level AS stock, 'Default Supplier' AS supplier_name
      FROM ingredients
      WHERE stock_level <= reorder_point
      ORDER BY (reorder_point - stock_level) DESC
      LIMIT 5
    `);

    // --- Respond with full dashboard data ---
    res.json({
      summary: {
        totalSales,
        salesGrowth,
        activeOrders,
        ordersGrowth,
        lowStock,
        lowStockGrowth,
        totalCustomers,
        customerGrowth,
      },
      recentOrders,
      stockAlerts,
    });

  } catch (err) {
    console.error("Error fetching dashboard summary:", err);
    res.status(500).json({ message: "Server error fetching dashboard summary", error: err.message });
  }
};
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
    // 1. Total Sales (Keep this)
    const [salesTodayRows] = await pool.query(`
      SELECT SUM(amount) AS total
      FROM fb_payments
      WHERE payment_status IN ('paid', 'pending')
      AND DATE(payment_date) = CURDATE()
    `);

    const [salesYesterdayRows] = await pool.query(`
      SELECT SUM(amount) AS total
      FROM fb_payments
      WHERE payment_status = 'paid'
      AND DATE(payment_date) = CURDATE() - INTERVAL 1 DAY
    `);

    const totalSales = salesTodayRows[0].total || 0;
    const salesGrowth = calculateGrowth(totalSales, salesYesterdayRows[0].total || 0);

    // 2. Active Orders (Keep this)
    const [ordersTodayRows] = await pool.query(`
      SELECT COUNT(*) AS total
      FROM fb_orders
      WHERE DATE(order_date) = CURDATE() AND status != 'Completed'
    `);

    const [ordersYesterdayRows] = await pool.query(`
      SELECT COUNT(*) AS total
      FROM fb_orders
      WHERE DATE(order_date) = CURDATE() - INTERVAL 1 DAY AND status != 'Completed'
    `);

    const activeOrders = ordersTodayRows[0].total || 0;
    const ordersGrowth = calculateGrowth(activeOrders, ordersYesterdayRows[0].total || 0);

    // 3. Low Stock Items (Keep this)
    const [lowStockRows] = await pool.query(`
      SELECT COUNT(*) AS total
      FROM fb_ingredients
      WHERE stock_level <= reorder_point
    `);

    const lowStock = lowStockRows[0].total || 0;
    const lowStockGrowth = 0; 

    // 4. ✅ CHANGED: Available Tables (Debug version)
    const [tableRows] = await pool.query(`
      SELECT COUNT(*) AS total
      FROM fb_tables
      WHERE LOWER(status) = 'available'
    `);
    
    const [totalTableRows] = await pool.query(`SELECT COUNT(*) AS total FROM fb_tables`);

    const availableTables = tableRows[0].total || 0;
    const totalTables = totalTableRows[0].total || 0;

    // 🔍 DEBUG LOG: Look for this in your VS Code Terminal!
    console.log("------------------------------------------------");
    console.log("📊 DASHBOARD DEBUG:");
    console.log("Total Tables found in DB:", totalTables);
    console.log("Available Tables found:", availableTables);
    console.log("------------------------------------------------");

    // 5. Recent Orders (Keep this)
    const [recentOrders] = await pool.query(`
      SELECT order_id, client_id, order_date, status, total_amount, order_type, delivery_location
      FROM fb_orders
      ORDER BY order_date DESC
      LIMIT 5
    `);

    // 6. Stock Alerts (Keep this)
    const [stockAlerts] = await pool.query(`
      SELECT ingredient_id, name, stock_level AS stock, 'Default Supplier' AS supplier_name
      FROM fb_ingredients
      WHERE stock_level <= reorder_point
      ORDER BY (reorder_point - stock_level) DESC
      LIMIT 5
    `);

    // --- Respond with updated data ---
    res.json({
      summary: {
        totalSales,
        salesGrowth,
        activeOrders,
        ordersGrowth,
        lowStock,
        lowStockGrowth,
        availableTables, // ✅ Send this instead of totalStaff
        totalTables      // ✅ Useful for context
      },
      recentOrders,
      stockAlerts,
    });

  } catch (err) {
    console.error("Error fetching dashboard summary:", err);
    res.status(500).json({ message: "Server error fetching dashboard summary", error: err.message });
  }
};
import pool from "../config/mysql.js";

// Helper to calculate growth percentage
const calculateGrowth = (today, yesterday) => {
  if (yesterday > 0) {
    return parseFloat(((today - yesterday) / yesterday * 100).toFixed(2));
  }
  return today > 0 ? 100 : 0;
};

// --- GET Dashboard Summary ---
export const getDashboardSummary = async (req, res) => {
  try {
    // Helper to return a "safe" empty structure if a query fails
    // This prevents one bad query from crashing the whole dashboard
    const safeQuery = (promise, fallbackValue) => 
       promise.catch(error => {
          console.error(`Partial Dashboard Error: ${error.message}`);
          return [fallbackValue]; // Return safe fallback (like [{ total: 0 }])
       });

    // Execute parallel queries with Safety Nets
    const [
      [salesTodayRows],
      [salesYesterdayRows],
      [activeOrdersRows],
      [volumeTodayRows],
      [volumeYesterdayRows],
      [lowStockRows],
      [tableRows],
      [recentOrders],
      [stockAlerts]
    ] = await Promise.all([
      // 1. Total Sales Today (Fallback: total = 0)
      safeQuery(
        pool.query(`SELECT SUM(total_amount) AS total FROM fb_new_orders WHERE DATE(order_date) = CURDATE() AND status != 'cancelled'`),
        [{ total: 0 }] 
      ),
      // 2. Sales Yesterday
      safeQuery(
        pool.query(`SELECT SUM(total_amount) AS total FROM fb_new_orders WHERE DATE(order_date) = CURDATE() - INTERVAL 1 DAY AND status != 'cancelled'`),
        [{ total: 0 }]
      ),
      // 3. Active Orders (NOW SIMPLY LOOKS FOR 'Open' TABS)
      safeQuery(
        pool.query(`SELECT COUNT(*) AS total FROM fb_new_orders WHERE status = 'Open'`),
        [{ total: 0 }]
      ),
      // 4. Volume Today
      safeQuery(
        pool.query(`SELECT COUNT(*) AS total FROM fb_new_orders WHERE DATE(order_date) = CURDATE() AND status != 'cancelled'`),
        [{ total: 0 }]
      ),
      // 5. Volume Yesterday
      safeQuery(
        pool.query(`SELECT COUNT(*) AS total FROM fb_new_orders WHERE DATE(order_date) = CURDATE() - INTERVAL 1 DAY AND status != 'cancelled'`),
        [{ total: 0 }]
      ),
      // 6. Low Stock Count (Unchanged)
      safeQuery(
        pool.query(`SELECT COUNT(*) AS total FROM fb_ingredients WHERE stock_level <= COALESCE(reorder_point, 10)`),
        [{ total: 0 }]
      ),
      // 7. Table Stats (Unchanged)
      safeQuery(
        pool.query(`SELECT SUM(CASE WHEN status = 'Available' THEN 1 ELSE 0 END) as available, COUNT(*) as total, SUM(capacity) as totalCapacity FROM fb_tables`),
        [{ available: 0, total: 0, totalCapacity: 0 }]
      ),
      // 8. Recent Orders (NOW DYNAMICALLY BUILDS DELIVERY LOCATION)
      safeQuery(
        pool.query(`
          SELECT 
            o.order_id, o.client_id, o.order_date, o.status, o.total_amount, o.order_type,
            CASE 
              WHEN o.order_type = 'Room Dining' AND tr.room_num IS NOT NULL THEN CONCAT('Room ', tr.room_num)
              WHEN o.order_type = 'Dine-In' AND ft.table_number IS NOT NULL THEN CONCAT('Table ', ft.table_number)
              ELSE 'Unknown Location' 
            END AS delivery_location
          FROM fb_new_orders o
          LEFT JOIN tbl_rooms tr ON o.room_id = tr.room_id
          LEFT JOIN fb_tables ft ON o.table_id = ft.table_id
          ORDER BY o.order_date DESC LIMIT 5
        `),
        [] 
      ),
      // 9. Stock Alerts (Unchanged)
      safeQuery(
        pool.query(`SELECT ingredient_id, name, stock_level AS stock FROM fb_ingredients WHERE stock_level <= COALESCE(reorder_point, 10) ORDER BY stock_level ASC LIMIT 5`),
        [] 
      )
    ]);

    // --- Process Results (Safe handling with optional chaining ?.) ---
    const totalSales = Number(salesTodayRows[0]?.total || 0);
    const salesYesterday = Number(salesYesterdayRows[0]?.total || 0);
    const salesGrowth = calculateGrowth(totalSales, salesYesterday);

    const activeOrders = activeOrdersRows[0]?.total || 0;
    
    const volToday = volumeTodayRows[0]?.total || 0;
    const volYesterday = volumeYesterdayRows[0]?.total || 0;
    const ordersGrowth = calculateGrowth(volToday, volYesterday);

    const lowStock = lowStockRows[0]?.total || 0;

    const availableTables = Number(tableRows[0]?.available || 0);
    const totalTables = Number(tableRows[0]?.total || 0);
    const totalSeatingCapacity = Number(tableRows[0]?.totalCapacity || 0);

    res.json({
      summary: {
        totalSales,
        salesGrowth,
        activeOrders,
        ordersGrowth,
        lowStock,
        lowStockGrowth: 0, 
        availableTables,
        totalTables,
        totalSeatingCapacity
      },
      // If recentOrders failed, it sends [] (empty list) instead of crashing
      recentOrders: recentOrders || [], 
      stockAlerts: stockAlerts || [],
    });

  } catch (err) {
    // This catch block now only triggers if something VERY major breaks (like the DB connection itself)
    console.error("Critical Dashboard Error:", err);
    res.status(500).json({ message: "Server error fetching dashboard summary", error: err.message });
  }
};
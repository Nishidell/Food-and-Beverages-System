import pool from "../config/mysql.js";

// --- GET Total Sales ---
export const getSalesSummary = async (req, res) => {
  try {
    const [rows] = await pool.query(`
      SELECT SUM(amount) AS total 
      FROM payments 
      WHERE payment_status = 'paid'
    `);
    res.json({ totalSales: rows[0].total || 0 });
  } catch (err) {
    console.error("Error fetching sales summary:", err);
    res.status(500).json({ message: "Server error fetching sales summary" });
  }
};
  
// --- GET Active Orders ---
export const getOrders = async (req, res) => {
  try {
    const [rows] = await pool.query(`
      SELECT order_id, customer_id, order_date, status, total_amount, order_type, delivery_location 
      FROM orders
      ORDER BY order_date DESC
    `);
    res.json(rows);
  } catch (err) {
    console.error("Error fetching orders:", err);
    res.status(500).json({ message: "Server error fetching orders" });
  }
};

// --- GET Low Stock Items ---
export const getLowStock = async (req, res) => {
  try {
     const [rows] = await pool.query(`
      SELECT 
        i.ingredient_id, 
        i.name, 
        i.stock_level AS stock, 
        'Default Supplier' AS supplier_name
      FROM ingredients i
      WHERE i.stock_level < 10
    `);

    res.json(rows); 
  } catch (err) {
    console.error("Error fetching low-stock items:", err);
    res.status(500).json({ message: "Server error fetching low-stock items" });
  }
};

// --- GET Customers ---
export const getCustomers = async (req, res) => {
  try {
    const [rows] = await pool.query(`
      SELECT customer_id, first_name, last_name, email, created_at
      FROM customers
      ORDER BY created_at DESC
    `);
    res.json(rows);
  } catch (err) {
    console.error("Error fetching customers:", err);
    res.status(500).json({ message: "Server error fetching customers" });
  }
};

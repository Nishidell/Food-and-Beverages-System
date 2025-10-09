import asyncHandler from "express-async-handler";
import connection from "../config/mysql.js"; // note the path
// list menu items
export const getItems = asyncHandler(async (req, res) => {
  const [rows] = await connection.query("SELECT * FROM menu_items WHERE available = 1");
  res.json(rows);
});
// create menu item (admin)
export const createItem = asyncHandler(async (req, res) => {
  const { name, description, price, stock, category } = req.body;
  const [result] = await connection.query(
    "INSERT INTO menu_items (name, description, price, stock, category) VALUES (?, ?, ?, ?, ?)",
    [name, description, price, stock || 0, category]
  );
  res.status(201).json({ id: result.insertId });
});

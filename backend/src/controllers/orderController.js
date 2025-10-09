import asyncHandler from "express-async-handler";
import connection from "../config/mysql.js";
import ActivityLog from "../models/ActivityLog.js";

export const createOrder = asyncHandler(async (req, res) => {
  const { customer_id, items, total, email } = req.body;
  // items: [{ item_id, quantity, subtotal }, ...]

  // 1) Insert order
  const [orderResult] = await connection.query("INSERT INTO orders (customer_id, total, status) VALUES (?, ?, ?)", [customer_id, total, "Pending"]);
  const orderId = orderResult.insertId;

  // 2) Insert order_items
  const itemPromises = items.map(it => {
    return connection.query("INSERT INTO order_items (order_id, item_id, quantity, subtotal) VALUES (?, ?, ?, ?)", [orderId, it.item_id, it.quantity, it.subtotal]);
  });
  await Promise.all(itemPromises);

  // 3) Create log in MongoDB
  await ActivityLog.create({ action: "CREATE_ORDER", userEmail: email, details: { orderId, total, items } });

  res.status(201).json({ orderId });
});

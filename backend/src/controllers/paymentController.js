import asyncHandler from "express-async-handler";
import connection from "../config/mysql.js";

// @desc    Record a new payment
// @route   POST /api/payments
// @access  Private
export const addPayment = asyncHandler(async (req, res) => {
  const { order_id, amount, method, status } = req.body;

  if (!order_id || !amount) {
    res.status(400);
    throw new Error("Order ID and amount are required");
  }

  const [result] = await connection.query(
    "INSERT INTO payments (order_id, amount, method, status) VALUES (?, ?, ?, ?)",
    [order_id, amount, method || "cash", status || "completed"]
  );

  res.status(201).json({
    message: "Payment recorded successfully",
    paymentId: result.insertId,
  });
});

// @desc    Get all payments
// @route   GET /api/payments
// @access  Private/Admin
export const getPayments = asyncHandler(async (req, res) => {
  const [payments] = await connection.query(
    "SELECT p.*, o.total_amount FROM payments p JOIN orders o ON p.order_id = o.id"
  );
  res.json(payments);
});

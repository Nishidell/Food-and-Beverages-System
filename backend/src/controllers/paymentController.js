import pool from "../config/mysql.js";
// We no longer need PayMongo or finalizeOrderAfterPayment here
// import { createRequire } from 'module';
// import { finalizeOrderAfterPayment } from './orderController.js';

// --- ADD: New function to simulate payment confirmation ---
export const simulatePayment = async (req, res) => {
    const { order_id } = req.params; // Get order_id from URL parameter
    const { total_amount } = req.body; // Get total_amount from request body

    if (!order_id || !total_amount) {
        return res.status(400).json({ message: "Order ID and total amount are required." });
    }

    const connection = await pool.getConnection();
    try {
        await connection.beginTransaction();

        // 1. Check if payment already exists
        const [existingPayments] = await connection.query("SELECT * FROM payments WHERE order_id = ?", [order_id]);
        if (existingPayments.length > 0) {
            console.log(`Payment simulation for order ${order_id} skipped: Payment already recorded.`);
            await connection.commit(); // End transaction
            // It's okay if it was already paid, just confirm success
            return res.status(200).json({ message: "Payment already recorded for this order." });
        }

        // 2. Record a 'Simulated' payment in the payments table
        const payment_method = "Simulated";
        const paymentSql = "INSERT INTO payments (order_id, payment_method, amount, payment_status) VALUES (?, ?, ?, 'paid')";
        const [paymentResult] = await connection.query(paymentSql, [order_id, payment_method, total_amount]);

        // 3. (Optional) Update order status if needed.
        // Since createOrder already sets it to 'Pending', which shows in the kitchen,
        // we don't strictly need to update it here unless you have a specific 'Paid' operational status.
        // Example: await connection.query("UPDATE orders SET status = 'Paid' WHERE order_id = ?", [order_id]);

        await connection.commit();

        res.status(201).json({
            payment_id: paymentResult.insertId,
            message: "Payment simulated successfully for order " + order_id
        });

    } catch (error) {
        await connection.rollback();
        console.error(`Error simulating payment for order ${order_id}:`, error);
        res.status(500).json({ message: "Failed to simulate payment", error: error.message });
    } finally {
        connection.release();
    }
};


// --- Keep existing functions for Cashier/Admin use ---

// @desc    Record a new payment (Used by Cashier)
// @route   POST /api/payments
// @access  Cashier/Admin
export const recordPayment = async (req, res) => {
    // Keep this function as is - it's for manual cashier payments
    // Note: This version deducts stock, which is correct for cashier flow
    // because the order wasn't paid online first.
    const connection = await pool.getConnection();
    try {
        await connection.beginTransaction();
        const { order_id, payment_method, payment_amount, change_amount } = req.body;
        if (!order_id || !payment_amount) {
            return res.status(400).json({ message: "Order ID and payment_amount paid are required." });
        }
        const paymentSql = "INSERT INTO payments (order_id, payment_method, amount, change_amount, payment_status) VALUES (?, ?, ?, ?, 'paid')";
        await connection.query(paymentSql, [order_id, payment_method, payment_amount, change_amount || 0]);

        // Stock was already deducted by createOrder in the simulated flow,
        // BUT for a direct cashier payment, we might need to deduct stock here.
        // Let's assume stock WASN'T deducted if paid via cashier route directly
        // This needs careful thought based on actual usage flow.
        // For now, let's keep the stock deduction here for the cashier flow.
        const [details] = await connection.query("SELECT item_id, quantity FROM order_details WHERE order_id = ?", [order_id]);
        for (const item of details) {
            const stockSql = "UPDATE menu_items SET stock = stock - ? WHERE item_id = ?";
            await connection.query(stockSql, [item.quantity, item.item_id]);
        }
         // Optionally update order status (e.g., to 'Completed' or 'Paid')
        await connection.query("UPDATE orders SET status = 'Completed' WHERE order_id = ?", [order_id]);


        await connection.commit();
        res.status(201).json({ message: "Payment recorded successfully" });
    } catch (error) {
        await connection.rollback();
        res.status(500).json({ message: "Failed to record payment", error: error.message });
    } finally {
        connection.release();
    }
};

// @desc    Get payments for an order
// @route   GET /api/payments/:order_id
// @access  Staff/Admin
export const getPaymentsForOrder = async (req, res) => {
    // Keep this function as is
    try {
        const { order_id } = req.params;
        const [payments] = await pool.query("SELECT * FROM payments WHERE order_id = ?", [order_id]);
        res.json(payments);
    } catch (error) {
        res.status(500).json({ message: "Error fetching payments", error: error.message });
    }
};
import express from "express";
import {
    recordPayment,          // For cashier
    getPaymentsForOrder,    // For viewing
    simulatePayment         // --- ADD: Our new simulation function ---
} from "../controllers/paymentController.js";
import { protect, authorizeRoles } from "../middleware/authMiddleware.js";

const router = express.Router();

// --- ADD NEW ROUTE for simulating payment ---
// Takes order_id from the URL and total_amount from the body
router.put("/:order_id/simulate", simulatePayment);
// Note: We are not adding 'protect' middleware for simplicity in testing,
// but in a real app, you'd want to ensure only the correct user can simulate payment for their order.

// --- REMOVED PayMongo routes ---
// router.post("/create-checkout", createPaymentLink);
// router.post("/webhook", handlePaymentWebhook);

// --- Keep Existing Routes (for Cashier/Admin) ---
router.post("/", protect, authorizeRoles('cashier', 'admin'), recordPayment); // Manual payment recording
router.get("/:order_id", protect, authorizeRoles('cashier', 'admin'), getPaymentsForOrder); // View payments

export default router;
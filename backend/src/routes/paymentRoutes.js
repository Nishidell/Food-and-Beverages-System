import express from "express";
import bodyParser from "body-parser";
import {
  createPayMongoPayment,
  paymongoWebhook,
  recordPayment,
  getPaymentsForOrder,
} from "../controllers/paymentController.js";

import { protect, authorizeRoles } from "../middleware/authMiddleware.js";

const router = express.Router();

/* -------------------------
   🔒 Protected Routes
-------------------------- */

// 1️⃣ Customer create Payment (PayMongo)
// Allowed: 'customer' (Role)
router.post('/checkout', protect, authorizeRoles("customer"), createPayMongoPayment);

// 2️⃣ Manual Record (For Cash/POS)
// Allowed: 'Cashier', 'Operations Manager' (Positions)
router.post("/", protect, authorizeRoles("Cashier", "Operations Manager", "Waiter"), recordPayment);

// 3️⃣ Get Payments for an Order
// Allowed: 'Cashier', 'Operations Manager', 'Waiter' (Positions)
router.get("/:order_id", protect, authorizeRoles("Cashier", "Operations Manager", "Waiter"), getPaymentsForOrder);

/* -------------------------
   💳 PayMongo Routes
-------------------------- */

// 5️⃣ Webhook (Public)
// router.post("/webhook", paymongoWebhook);

export default router;
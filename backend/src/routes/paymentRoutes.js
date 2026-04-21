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


//  Customer create Payment (PayMongo)
// Allowed: 'customer' (Role)
router.post('/checkout', protect, authorizeRoles("customer"), createPayMongoPayment);

//  Manual Record (For Cash/POS)
// Allowed: 'Cashier', 'Operations Manager' (Positions)
router.post("/", protect, authorizeRoles("General Manager", "Operations Manager", "Financial Manager"), recordPayment);

//  Get Payments for an Order
// Allowed: 'Cashier', 'Operations Manager', 'Waiter' (Positions)
router.get("/:order_id", protect, authorizeRoles("General Manager", "Operations Manager", "Financial Manager"), getPaymentsForOrder);

/* -------------------------
   💳 PayMongo Routes
-------------------------- */

// 5️⃣ Webhook (Public)
// router.post("/webhook", paymongoWebhook);

export default router;
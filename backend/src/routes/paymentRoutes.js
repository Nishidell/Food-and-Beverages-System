import express from "express";
import { addPayment, getPayments } from "../controllers/paymentController.js";
import { protect } from "../middleware/authMiddleware.js";

const router = express.Router();

router.route("/record")
  .post(protect, addPayment)   // Add a payment
  .get(protect, getPayments);  // List all payments

export default router;

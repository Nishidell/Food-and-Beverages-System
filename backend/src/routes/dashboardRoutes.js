import express from "express";
import { protect, authorizeRoles } from "../middleware/authMiddleware.js";
import {
  getSalesSummary,
  getOrders,
  getLowStock,
  getCustomers
} from "../controllers/dashboardController.js";

const router = express.Router();

// Routes
router.get("/sales", protect, authorizeRoles("admin"), getSalesSummary);
router.get("/orders", protect, authorizeRoles("admin"), getOrders);
router.get("/low-stock", protect, authorizeRoles("admin"), getLowStock);
router.get("/customers", protect, authorizeRoles("admin"), getCustomers);

export default router;

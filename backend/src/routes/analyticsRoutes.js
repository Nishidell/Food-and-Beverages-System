import express from "express";
import { getDashboardAnalytics } from "../controllers/analyticsController.js";
import { protect, authorizeRoles } from "../middleware/authMiddleware.js";

const router = express.Router();

// UPDATED: Only Operations Manager can view analytics
router.get("/", protect, authorizeRoles("General Manager"), getDashboardAnalytics);

export default router;
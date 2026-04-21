import express from "express";
import { protect, authorizeRoles } from "../middleware/authMiddleware.js";
import { getDashboardSummary } from "../controllers/dashboardController.js";

const router = express.Router();

/**
 * @route   GET /api/dashboard/summary
 * @desc    Get dashboard summary data
 * @access  Private (F&B Admin, Employee, Admin)
 */
// ✅ FIX: Added 'employee' and 'admin' to the authorized roles list
router.get("/summary", protect, authorizeRoles("General Manager","Operations Manager"), getDashboardSummary);

export default router;
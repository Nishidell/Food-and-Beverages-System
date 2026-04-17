import express from "express";
// Make sure this path matches where your auth middleware actually lives!
import { protect, authorizeRoles } from "../middleware/authMiddleware.js"; 
import { getBudgetRequests, createBudgetRequest } from "../controllers/budgetController.js";

// Initialize the Express router
const router = express.Router();

// Allowed: F&B Admin / Operations Manager
router.route("/budget-requests")
    .get(protect, authorizeRoles("Operations Manager", "Stock Controller"), getBudgetRequests)
    .post(protect, authorizeRoles("Operations Manager", "Stock Controller"), createBudgetRequest);

// Export the router so server.js can use it
export default router;
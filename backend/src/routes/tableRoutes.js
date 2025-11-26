import express from "express";
import { getAllTables, updateTableStatus } from "../controllers/tableController.js";
import { protect, authorizeRoles } from "../middleware/authMiddleware.js";

const router = express.Router();

// Public (or protected if you prefer) - For Menu/POS dropdown
router.get("/", getAllTables);

// Protected - For Staff to update status manually
router.put(
    "/:id/status", 
    protect, 
    authorizeRoles("F&B Admin", "Kitchen Staffs", "Waiter", "Cashier"), 
    updateTableStatus
);

export default router;
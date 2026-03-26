import express from "express";
import { getAllCustomers } from "../controllers/adminController.js";
import { 
    createMenuItem, 
    updateMenuItem, 
    deleteMenuItem 
} from "../controllers/itemController.js"; 
import { protect, authorizeRoles } from "../middleware/authMiddleware.js";

const router = express.Router();
// --- Customer Management ---
// UPDATED: Allow 'F&B Admin' to view customers
router.get("/customers", protect, authorizeRoles("Operations Manager"), getAllCustomers);

// --- Menu Item Management (Admin Actions) --- 
// UPDATED: Allow 'F&B Admin' to manage menu
router.post("/items", protect, authorizeRoles("Operations Manager"), createMenuItem);
router.put("/items/:id", protect, authorizeRoles("Operations Manager"), updateMenuItem);
router.delete("/items/:id", protect, authorizeRoles("Operations Manager"), deleteMenuItem);

export default router;
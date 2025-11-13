import express from "express";
import { 
    getAllEmployees, 
    getAllCustomers,
    createEmployee,
    updateEmployee,
    deleteEmployee
} from "../controllers/adminController.js";
import { 
    createMenuItem, 
    updateMenuItem, 
    deleteMenuItem 
} from "../controllers/itemController.js"; // <-- Import item management functions
import { protect, authorizeRoles } from "../middleware/authMiddleware.js";

const router = express.Router();

// --- Staff Management ---
router.get("/staff", protect, authorizeRoles("admin"), getAllEmployees);
router.post("/staff", protect, authorizeRoles("admin"), createEmployee);
router.put("/staff/:id", protect, authorizeRoles("admin"), updateEmployee);
router.delete("/staff/:id", protect, authorizeRoles("admin"), deleteEmployee);

// --- Customer Management ---
router.get("/customers", protect, authorizeRoles("admin"), getAllCustomers);

// --- Menu Item Management --- (FIX: Added these routes)
router.post("/items", protect, authorizeRoles("admin"), createMenuItem);
router.put("/items/:id", protect, authorizeRoles("admin"), updateMenuItem);
router.delete("/items/:id", protect, authorizeRoles("admin"), deleteMenuItem);

export default router;
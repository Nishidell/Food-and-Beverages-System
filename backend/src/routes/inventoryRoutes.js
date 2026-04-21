import express from "express";
import { protect, authorizeRoles } from "../middleware/authMiddleware.js";
import {
    createIngredient,
    getAllIngredients,
    getIngredientById,
    updateIngredientDetails,
    adjustIngredientStock,
    deleteIngredient,
    getInventoryLogs,
    exportInventoryValue
} from "../controllers/inventoryController.js";

const router = express.Router();

// --- 1. Inventory Logs ---
// Allowed: F&B Admin and Stock Controller (Primary), Kitchen Staffs (Optional/View)
router.get(
    "/logs", 
    protect, 
    authorizeRoles("Operations Manager", "General Manager","Inventory Manager"), 
    getInventoryLogs
);

// --- 2. Ingredients Management ---
router.route("/")
    // View: All Staff need to see ingredients for Menu/POS to work
    .get(protect, authorizeRoles("Operations Manager", "General Manager","Inventory Manager"), getAllIngredients)
    // Create: Only Operations Manager and Stock Controller
    .post(protect, authorizeRoles("Operations Manager", "General Manager","Inventory Manager"), createIngredient);

router.get(
    "/export", 
    protect, 
    authorizeRoles("Operations Manager", "General Manager","Inventory Manager"), 
    exportInventoryValue
);

router.route("/:id")
    .get(protect, authorizeRoles("Operations Manager", "General Manager","Inventory Manager"), getIngredientById)
    .put(protect, authorizeRoles("Operations Manager", "General Manager","Inventory Manager"), updateIngredientDetails)
    .delete(protect, authorizeRoles("Operations Manager", "General Manager","Inventory Manager"), deleteIngredient);

// --- 3. Stock Adjustment ---
// Allowed: Operations Manager and Stock Controller (Kitchen Staffs added if they need to report waste)
router.put(
    "/:id/stock", 
    protect, 
    authorizeRoles("Operations Manager", "General Manager","Inventory Manager"), 
    adjustIngredientStock
);

export default router;
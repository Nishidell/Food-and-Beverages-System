import express from "express";
import {
    createOrder,
    getOrders,
    getOrderById,
    updateOrderStatus,
    getKitchenOrders,
    getServedOrders,
    createPosOrder,
    getMyOrders,
    toggleItemCheckbox
} from "../controllers/orderController.js";
import { protect, authorizeRoles } from "../middleware/authMiddleware.js";

const router = express.Router();

// --- 1. Kitchen Display Routes ---
// Allowed: Operations Manager, Kitchen Staffs, Waiter, Cashier
router.get(
    '/kitchen', 
    protect, 
    authorizeRoles("Operations Manager", "Kitchen Staffs", "Waiter", "Cashier"), 
    getKitchenOrders
); 

router.get(
    '/served', 
    protect, 
    authorizeRoles("Operations Manager", "Kitchen Staffs", "Waiter", "Cashier"), 
    getServedOrders
);

// --- 2. POS Order Creation ---
// Allowed: Operations Manager, Waiter, Cashier
router.post(
    "/pos", 
    protect, 
    authorizeRoles("Operations Manager", "Waiter", "Cashier"), 
    createPosOrder
);

// --- 3. Order Status Updates (Kitchen/POS) ---
// Allowed: Operations Manager, Kitchen Staffs, Waiter, Cashier
router.put(
    "/:id/status", 
    protect, 
    authorizeRoles("Operations Manager", "Kitchen Staffs", "Waiter", "Cashier"), 
    updateOrderStatus
);

// --- 3.5 Item-Level Status Update (Checkboxes) ---
// Allowed: Operations Manager, Kitchen Staffs, Waiter, Cashier
router.put(
    "/item/:detailId/toggle", 
    protect, 
    authorizeRoles("Operations Manager", "Kitchen Staffs", "Waiter", "Cashier"), 
    toggleItemCheckbox
);

// --- 4. Admin/Customer Routes ---
router.post("/", protect, createOrder); // Customer creates own order (checked by role=customer internally or logic)
router.get("/my-orders", protect, getMyOrders);
router.get("/", getOrders); // Usually Admin only, or filtering in controller
router.get("/:id", getOrderById); // Public/Protected mixed logic in controller

export default router;
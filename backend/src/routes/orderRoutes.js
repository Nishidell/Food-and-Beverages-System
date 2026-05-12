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
    toggleItemCheckbox,
    getUnpaidTabs,
    settleBill,
    addItemsToOrder,
    voidOrderItem,
    cancelEntireOrder,
    getRoomDeposit
} from "../controllers/orderController.js";
import { protect, authorizeRoles } from "../middleware/authMiddleware.js";

const router = express.Router();

// --- 1. Kitchen Display Routes ---
// Allowed: Operations Manager, Kitchen Staffs, Waiter, Cashier
router.get(
    '/kitchen', 
    protect, 
    authorizeRoles("Operations Manager", "General Manager", "Head Chef"), 
    getKitchenOrders
); 

router.get(
    '/served', 
    protect, 
    authorizeRoles("Operations Manager", "General Manager", "Head Chef"), 
    getServedOrders
);

// --- 2. POS Order Creation ---
// Allowed: Operations Manager, Waiter, Cashier
router.post(
    "/pos", 
    protect, 
    authorizeRoles("Operations Manager", "General Manager", "Service Supervisor", "Finance Manager"), 
    createPosOrder
);

// --- 2.5 Add Items to Existing Tab ---
// Allowed: Operations Manager, Waiter, Cashier
router.post(
    "/:id/items", 
    protect, 
    authorizeRoles("Operations Manager", "General Manager", "Service Supervisor", "Finance Manager"), 
    addItemsToOrder
);

// --- 3. Order Status Updates (Kitchen/POS) ---
// Allowed: Operations Manager, Kitchen Staffs, Waiter, Cashier
router.put(
    "/:id/status", 
    protect, 
    authorizeRoles("Operations Manager", "General Manager", " Head Chef"), 
    updateOrderStatus
);

// --- 3.5 Item-Level Status Update (Checkboxes) ---
// Allowed: Operations Manager, Kitchen Staffs, Waiter, Cashier
router.put(
    "/item/:detailId/toggle", 
    protect, 
    authorizeRoles("Operations Manager", "General Manager", "Head Chef"), 
    toggleItemCheckbox
);

router.put(
    "/item/:detailId/void", 
    protect, 
    authorizeRoles("Operations Manager", "General Manager", "Head Chef"), 
    voidOrderItem
);

router.put('/:id/cancel',
    protect, 
    authorizeRoles("Operations Manager", "General Manager", "Head Chef"),
    cancelEntireOrder);

// --- 4. Cashier & Billing Routes ---
// Allowed: Operations Manager, Cashier
router.get(
    "/unpaid", 
    protect, 
    authorizeRoles("Operations Manager", "General Manager", "Finance Manager"), 
    getUnpaidTabs
);

router.post(
    "/:id/settle", 
    protect, 
    authorizeRoles("Operations Manager", "General Manager", "Finance Manager"), 
    settleBill
);


router.get('/room/:roomId/deposit', protect, getRoomDeposit);
// --- 4.5 Admin/Customer Routes ---
router.post("/", protect, createOrder); // Customer creates own order (checked by role=customer internally or logic)
router.get("/my-orders", protect, getMyOrders);
router.get("/", getOrders); // Usually Admin only, or filtering in controller
router.get("/:id", getOrderById); // Public/Protected mixed logic in controller

export default router;
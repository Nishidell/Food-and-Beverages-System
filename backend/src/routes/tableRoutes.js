import express from "express";
import { 
    getAllTables, 
    updateTableStatus,
    createTable, 
    updateTable, 
    deleteTable,
    seatGuest
} from "../controllers/tableController.js";
import { protect, authorizeRoles } from "../middleware/authMiddleware.js";

const router = express.Router();

// Public: Get Tables
router.get("/", getAllTables);

// Protected (Staff): Update Status (Occupied/Available)
router.put("/:id/status", protect, authorizeRoles("Operations Manager", "Kitchen Staffs", "Waiter", "Cashier"), updateTableStatus);

// Protected (Admin): CRUD Operations
router.post("/", protect, authorizeRoles("Operations Manager"), createTable);
router.put("/:id", protect, authorizeRoles("Operations Manager"), updateTable);
router.delete("/:id", protect, authorizeRoles("Operations Manager"), deleteTable);

router.post("/:id/seat", protect, authorizeRoles("Operations Manager"), seatGuest);

export default router;
import express from "express";
import { getAllUsers } from "../controllers/adminController.js";
import { protect, authorizeRoles } from "../middleware/authMiddleware.js";
const router = express.Router();
router.get("/users", protect, authorizeRoles("Admin","Dev"), getAllUsers);
export default router;

import express from "express";
import { getItems, createItem } from "../controllers/itemController.js";
import { protect, authorizeRoles } from "../middleware/authMiddleware.js";
const router = express.Router();

router.get("/", getItems);
router.post("/", protect, authorizeRoles("Admin","Staff","Dev"), createItem);

export default router;

import express from "express";
import { getAllCategories, createCategory, updateCategory, deleteCategory } from "../controllers/categoryController.js"; // Import updateCategory
import { protect, authorizeRoles } from "../middleware/authMiddleware.js";

const router = express.Router();

router.get("/", getAllCategories);
router.post("/", protect, authorizeRoles("F&B Admin"), createCategory);
router.put("/:id", protect, authorizeRoles("F&B Admin"), updateCategory); 
router.delete("/:id", protect, authorizeRoles("F&B Admin"), deleteCategory);

export default router;
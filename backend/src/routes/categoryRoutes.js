import express from "express";
import { getAllCategories, createCategory, updateCategory, deleteCategory } from "../controllers/categoryController.js"; // Import updateCategory
import { protect, authorizeRoles } from "../middleware/authMiddleware.js";

const router = express.Router();

router.get("/", getAllCategories);
router.post("/", protect, authorizeRoles("General Manager"), createCategory);
router.put("/:id", protect, authorizeRoles("General Manager"), updateCategory); 
router.delete("/:id", protect, authorizeRoles("General Manager"), deleteCategory);

export default router;
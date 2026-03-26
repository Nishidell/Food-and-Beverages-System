import express from "express";
import { getAllCategories, createCategory, updateCategory, deleteCategory } from "../controllers/categoryController.js"; // Import updateCategory
import { protect, authorizeRoles } from "../middleware/authMiddleware.js";

const router = express.Router();

router.get("/", getAllCategories);
router.post("/", protect, authorizeRoles("Operations Manager"), createCategory);
router.put("/:id", protect, authorizeRoles("Operations Manager"), updateCategory); 
router.delete("/:id", protect, authorizeRoles("Operations Manager"), deleteCategory);

export default router;
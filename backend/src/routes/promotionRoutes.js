import express from "express";
import { 
    createPromotion, 
    getAllPromotions, 
    applyPromotionToItems,
    removePromotionFromItems,
    deletePromotion,
    togglePromotionStatus,
    updatePromotion
} from "../controllers/promotionController.js";
import { protect, authorizeRoles } from "../middleware/authMiddleware.js";

const router = express.Router();

// All routes require F&B Admin permission
router.use(protect, authorizeRoles("F&B Admin"));

router.post("/", createPromotion);           // Create "Christmas Special"
router.get("/", getAllPromotions);           // List all promos
router.post("/apply", applyPromotionToItems); // Link Items -> Promo
router.post("/remove", removePromotionFromItems); // Unlink Items
router.delete("/:id", deletePromotion);
router.put("/:id/status", togglePromotionStatus);
router.put("/:id", updatePromotion);
export default router;
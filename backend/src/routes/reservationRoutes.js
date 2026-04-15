import express from "express";
import { protect } from "../middleware/authMiddleware.js"; 
import { createReservation } from "../controllers/reservationController.js";

const router = express.Router();

// The user MUST be logged in (protect middleware) to hit this route
router.route("/book").post(protect, createReservation);

export default router;
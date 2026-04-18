import express from "express";
import { protect } from "../middleware/authMiddleware.js"; 
import { 
    createReservation, 
    getReservations, 
    updateReservationStatus,
    getAvailableTables
} from "../controllers/reservationController.js";

const router = express.Router();

// The public booking route (requires login)
router.route("/book").post(protect, createReservation);
router.post('/available-tables', getAvailableTables);

// The Host Dashboard routes (requires login)
router.route("/").get(protect, getReservations);
router.route("/:id/status").put(protect, updateReservationStatus);

export default router;
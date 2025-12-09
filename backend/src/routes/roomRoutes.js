import express from "express";
import { getAllRooms, getMyActiveRoom} from "../controllers/roomController.js";
import { protect, authorizeRoles } from "../middleware/authMiddleware.js";

const router = express.Router();

router.get("/", getAllRooms);
router.get('/my-active-room', protect, getMyActiveRoom);

export default router;
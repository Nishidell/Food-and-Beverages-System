import express from 'express';
import { getAnnouncement, updateAnnouncement } from '../controllers/announcementController.js';
import { protect, authorizeRoles } from '../middleware/authMiddleware.js';

const router = express.Router();

// Public: Get message
router.get('/', getAnnouncement);

// Admin only: Update message
router.put('/', protect, authorizeRoles("General Manager"), updateAnnouncement);

export default router;
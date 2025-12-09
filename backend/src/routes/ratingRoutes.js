import express from 'express';
import { addRating, getItemReviews, getUserItemRating, getAllReviews, deleteReview } from '../controllers/ratingController.js';
import { protect } from '../middleware/authMiddleware.js';

const router = express.Router();

// Public: View reviews
router.get('/:itemId', getItemReviews);
router.post('/', protect, addRating);
router.get('/user/:itemId', protect, getUserItemRating);
router.get('/', getAllReviews);
router.delete('/:id', deleteReview);

export default router;
import mongoose from "mongoose";
const feedbackSchema = new mongoose.Schema({
  userId: { type: mongoose.Schema.Types.ObjectId, ref: "User" },
  message: String,
  rating: Number,
  createdAt: { type: Date, default: Date.now }
});
export default mongoose.model("Feedback", feedbackSchema);

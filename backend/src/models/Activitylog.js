import mongoose from "mongoose";
const activityLogSchema = new mongoose.Schema({
  action: String,
  userEmail: String,
  details: mongoose.Schema.Types.Mixed,
  createdAt: { type: Date, default: Date.now }
});
export default mongoose.model("ActivityLog", activityLogSchema);

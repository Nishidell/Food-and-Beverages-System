import asyncHandler from "express-async-handler";
import User from "../models/User.js";

export const getAllUsers = asyncHandler(async (req, res) => {
  const users = await User.find().select("-passwordHash");
  res.json(users);
});

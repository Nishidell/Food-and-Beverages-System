import asyncHandler from "express-async-handler";
import User from "../models/User.js";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";

export const registerUser = asyncHandler(async (req,res) => {
  const { name, email, password, role } = req.body;
  const exists = await User.findOne({ email });
  if (exists) { res.status(400); throw new Error("User already exists"); }
  const passwordHash = await bcrypt.hash(password, 10);
  const user = await User.create({ name, email, passwordHash, role });
  res.status(201).json({ _id: user._id, name: user.name, email: user.email, role: user.role });
});

export const loginUser = asyncHandler(async (req,res) => {
  const { email, password } = req.body;
  const user = await User.findOne({ email });
  if (user && await user.matchPassword(password)) {
    const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, { expiresIn: "30d" });
    res.json({ token, user: { _id: user._id, name: user.name, email: user.email, role: user.role } });
  } else {
    res.status(401);
    throw new Error("Invalid credentials");
  }
});

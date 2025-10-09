import dotenv from "dotenv";
dotenv.config();
import connectDB from "../config/db.js";
import mongoose from "mongoose";
import bcrypt from "bcryptjs";
import User from "../models/User.js";

const run = async () => {
  await connectDB();
  const hashed = await bcrypt.hash("123456", 10);
  const existing = await User.findOne({ email: "admin@example.com" });
  if (existing) { console.log("Admin exists"); process.exit(0); }
  const admin = await User.create({ name: "Dev Admin", email: "admin@example.com", passwordHash: hashed, role: "Admin" });
  console.log("Created admin:", admin.email);
  process.exit(0);
};

run().catch(e => { console.error(e); process.exit(1); });

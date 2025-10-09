import jwt from "jsonwebtoken";
import asyncHandler from "express-async-handler";
import User from "../models/User.js";

export const protect = asyncHandler( async (req, res, next) => {
  // Dev bypass
  if (process.env.DEV_MODE === "true") {
    req.user = { id: "dev", role: "Dev", name: "Dev Admin", email: "admin@example.com" };
    return next();
  }

  let token;
  if (req.headers.authorization && req.headers.authorization.startsWith("Bearer")) {
    token = req.headers.authorization.split(" ")[1];
    try {
      const decoded = jwt.verify(token, process.env.JWT_SECRET);
      req.user = await User.findById(decoded.id).select("-passwordHash");
      next();
    } catch (err) {
      res.status(401);
      throw new Error("Not authorized, token failed");
    }
  } else {
    res.status(401);
    throw new Error("Not authorized, no token");
  }
});

export const authorizeRoles = (...roles) => (req, res, next) => {
  if (process.env.DEV_MODE === "true") return next();
  if (!req.user) return res.status(401).json({ message: 'Not authorized' });
  if (!roles.includes(req.user.role)) return res.status(403).json({ message: 'Forbidden' });
  next();
};

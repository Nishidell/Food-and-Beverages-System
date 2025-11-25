import jwt from "jsonwebtoken";
import dotenv from "dotenv";
dotenv.config();

export const protect = (req, res, next) => {
  try {
    const authHeader = req.headers.authorization;
    if (!authHeader || !authHeader.startsWith("Bearer ")) {
      return res.status(401).json({ message: "Access denied. No token provided." });
    }

    const token = authHeader.split(" ")[1];
    const decoded = jwt.verify(token, process.env.JWT_SECRET);

    req.user = decoded;
    next();
  } catch (err) {
    console.error("JWT verification failed:", err.message);
    res.status(401).json({ message: "Invalid or expired token" });
  }
};

// UPDATED: Now checks for POSITIONS, not Roles.
// UPDATED: Checks for BOTH Positions (Staff) and Roles (Customers)
export const authorizeRoles = (...allowedRolesOrPositions) => {
  return (req, res, next) => {
    if (!req.user) {
       return res.status(403).json({ message: "Access forbidden: not authenticated" });
    }

    // 1. Get user info
    const userPosition = req.user.position; // For Staff (e.g., "F&B Admin")
    const userRole = req.user.role;         // For Customers (e.g., "customer")

    // 2. Check strict Position match (For Staff)
    if (userPosition && allowedRolesOrPositions.includes(userPosition)) {
        return next();
    }

    // 3. Check strict Role match (For Customers or generic roles)
    if (userRole && allowedRolesOrPositions.includes(userRole)) {
        return next();
    }

    // 4. Special Case: 'F&B Admin' should access 'admin' routes (Backward compatibility)
    // If the route asks for 'admin', but the user is 'F&B Admin', allow it.
    if (userPosition === 'F&B Admin' && allowedRolesOrPositions.includes('admin')) {
        return next();
    }

    console.log(`Access Denied. User: ${userRole}/${userPosition}. Allowed: ${allowedRolesOrPositions}`);
    return res.status(403).json({ message: "Access forbidden: insufficient privileges" });
  };
};
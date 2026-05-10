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

    // 1. Try to verify using the standard F&B Staff Secret
    try {
      const decoded = jwt.verify(token, process.env.JWT_SECRET);
      req.user = decoded;
      return next(); // Exit early if successful

    } catch (fbErr) {
      // 2. F&B secret failed. Let's try the CRS Secret!
      if (process.env.CRS_JWT_SECRET) {
        const decodedCrs = jwt.verify(token, process.env.CRS_JWT_SECRET);
        req.user = decodedCrs;
        req.user.is_crs_guest = true; // Tag them as a guest for your controllers
        return next();
      } else {
        // If you haven't added the CRS secret to .env yet, throw the original error
        throw fbErr;
      }
    }
  } catch (err) {
    console.error("JWT verification failed:", err.message);
    res.status(401).json({ message: "Invalid or expired token" });
  }
};

// UPDATED: Checks for BOTH Positions (Staff) and Roles (Customers)
// Includes HRIS Translation Dictionary and General Manager Master Key
export const authorizeRoles = (...allowedRolesOrPositions) => {
  return (req, res, next) => {
    if (!req.user) {
      return res.status(403).json({ message: "Access forbidden: not authenticated" });
    }

    // 1. Get user info
    const userPosition = req.user.position; // For Staff 
    const userRole = req.user.role;         // For Customers

    // THE MASTER KEY: General Manager bypasses all checks
    if (userPosition === 'General Manager') {
      return next();
    }

    // THE TRANSLATION DICTIONARY: Map legacy backend roles to new HRIS titles
    const allowedWithMapping = [...allowedRolesOrPositions];

    if (allowedWithMapping.includes('Operations Manager')) allowedWithMapping.push('Operations Manager');
    if (allowedWithMapping.includes('Kitchen Staffs')) allowedWithMapping.push('Head Chef', 'Assistant Chef');
    if (allowedWithMapping.includes('Waiter')) allowedWithMapping.push('Service Supervisor');
    if (allowedWithMapping.includes('Cashier')) allowedWithMapping.push('Finance Manager');
    if (allowedWithMapping.includes('Stock Controller')) allowedWithMapping.push('Inventory Manager');

    // 2. Check strict Position match (For Staff) using our new translated list
    if (userPosition && allowedWithMapping.includes(userPosition)) {
      return next();
    }

    // 3. Check strict Role match (For Customers)
    if (userRole && allowedWithMapping.includes(userRole)) {
      return next();
    }

    // 4. Special Case: Backward compatibility for admin routes
    if ((userPosition === 'Operations Manager' || userPosition === 'Operation Manager') && allowedWithMapping.includes('admin')) {
      return next();
    }

    console.log(`Access Denied. User: ${userRole || 'None'}/${userPosition || 'None'}. Allowed: ${allowedWithMapping}`);
    return res.status(403).json({ message: "Access forbidden: insufficient privileges" });
  };
};
import jwt from 'jsonwebtoken';
import dotenv from 'dotenv';
dotenv.config();

// We are simulating a customer coming from CRS
const dummyCrsUser = {
  id: 999,
  role: 'customer',
  position: null,
  name: 'Test Guest'
};

// Make sure process.env.CRS_JWT_SECRET has a value in your .env file!
const token = jwt.sign(dummyCrsUser, process.env.CRS_JWT_SECRET, { expiresIn: '1h' });

console.log("=== YOUR DUMMY CRS TOKEN ===");
console.log(token);
console.log("==============================");
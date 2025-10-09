import mysql from "mysql2/promise";
import dotenv from "dotenv";

dotenv.config();

const connection = await mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});

try {
  await connection.connect();
  console.log("✅ MySQL Connected Successfully");
} catch (err) {
  console.error("❌ MySQL Connection Failed:", err);
}

export default connection;

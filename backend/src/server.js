import express from "express";
import dotenv from "dotenv";
dotenv.config();

import connectDB from "./config/db.js";
import connection from "./config/mysql.js"; // initialize connection
import cors from "cors";

import authRoutes from "./routes/authRoutes.js";
import itemRoutes from "./routes/itemRoutes.js";
import orderRoutes from "./routes/orderRoutes.js";
import adminRoutes from "./routes/adminRoutes.js";
import paymentRoutes from "./routes/paymentRoutes.js";  

import { notFound, errorHandler } from "./middleware/errorMiddleware.js";

const app = express();
app.use(cors());
app.use(express.json());


await connectDB();  // Connect MongoDB

app.get("/", (req, res) => res.send({ status: "OK", time: new Date() }));

app.use("/api/auth", authRoutes);
app.use("/api/items", itemRoutes);
app.use("/api/orders", orderRoutes);
app.use("/api/admin", adminRoutes);
app.use("/api/payments", paymentRoutes);


// error middleware
app.use(notFound);
app.use(errorHandler);

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`🚀 Server running on http://localhost:${PORT}`));
    
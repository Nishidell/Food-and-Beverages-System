import mongoose from 'mongoose';
import dotenv from 'dotenv';
import connectDB from '../config/db.js';
import Item from '../models/Item.js';
import User from '../models/User.js';
import bcrypt from 'bcryptjs';


dotenv.config();


const seed = async () => {
await connectDB();
await Item.deleteMany();
await User.deleteMany();


const items = [
{ name: 'Burger', category: 'Food', price: 150, quantity: 50 },
{ name: 'Coke 330ml', category: 'Beverage', price: 50, quantity: 120 }
];
await Item.insertMany(items);


const salt = await bcrypt.genSalt(10);
const hash = await bcrypt.hash('password', salt);
await User.create({ username: 'admin', passwordHash: hash, role: 'admin', name: 'Administrator' });


console.log('Seeded DB');
process.exit();
};


if (process.argv[2] === '--seed') seed();
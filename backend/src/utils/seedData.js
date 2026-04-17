import mysql from 'mysql2/promise';
import dotenv from 'dotenv';

// Load your Clever Cloud credentials from your .env file
dotenv.config();

const seedDatabase = async () => {
    try {
        console.log("⏳ Connecting to Clever Cloud database...");
        
        // 1. Establish the connection
        const db = await mysql.createConnection({
            host: process.env.DB_HOST,
            user: process.env.DB_USER,
            password: process.env.DB_PASSWORD,
            database: process.env.DB_NAME,
            port: process.env.DB_PORT || 3306
        });

        console.log("✅ Successfully connected to the database!");

        // 2. INJECTING THE MOCK RESERVATION & ROOM LINK
        console.log("Injecting mock reservation data...");

        // Step A: Create the reservation (Using client_id 1)
        const insertResQuery = `
            INSERT INTO tbl_reservations (client_id, num_adults, num_children, check_in, check_out, status)
            VALUES (?, ?, ?, ?, ?, ?)
        `;
        
        // Mock data: Client 23, 3 Adults, 0 Children, Check-in Today, Check-out Next Week, Approved
        const resValues = [23, 3, 0, '2026-04-15', '2026-04-20', 'Approved'];
        const [resResult] = await db.execute(insertResQuery, resValues);
        
        const newReservationId = resResult.insertId;
        console.log(`✅ Success! Inserted mock reservation with ID: ${newReservationId}`);

        // Step B: Link the new reservation to a physical room
        console.log("Linking reservation to a room...");
        const insertLinkQuery = `
            INSERT INTO tbl_reservation_rooms (reservation_id, room_id)
            VALUES (?, ?)
        `;
        
        // Let's use Room ID 101
        const linkValues = [newReservationId, 14];
        await db.execute(insertLinkQuery, linkValues);

        console.log(`✅ Success! Linked Reservation ${newReservationId} to Room 101.`);

        // 3. Close the connection so the script finishes running
        await db.end();
        console.log("👋 Database connection closed.");

    } catch (error) {
        console.error("❌ Seeding failed. Check your database credentials:", error);
    }
};

// Run the function
seedDatabase();
import pool from "../config/mysql.js";
import nodemailer from "nodemailer";

// @desc    Create a new dining reservation with auto-table assignment
export const createReservation = async (req, res) => {
    console.log("USER DATA FROM TOKEN:", req.user);
    
    // 1. Get the requested booking details from the frontend
    const { reservation_date, reservation_time, party_size, special_requests } = req.body;

    // 2. Extract the user details from the token! (These were missing)
    const userId = req.user.id;
    const firstName = req.user.firstName; 
    const lastName = req.user.lastName;

    if (!reservation_date || !reservation_time || !party_size) {
        return res.status(400).json({ message: "Date, time, and party size are required." });
    }

    const connection = await pool.getConnection();

    try {
        await connection.beginTransaction();

        // 4. NOW you can safely query the database for the email
        const [userRows] = await connection.query(
            "SELECT email FROM tbl_client_users WHERE client_id = ?",
            [userId]
        );

        if (userRows.length === 0 || !userRows[0].email) {
            await connection.rollback();
            return res.status(400).json({ message: "Could not locate your email address in the system." });
        }

        const email = userRows[0].email;

        // 3. THE OKADA AUTO-ASSIGNER QUERY
        // Find tables big enough for the party, that ARE NOT already booked for that exact date/time
        // We order by capacity ASC so a party of 2 gets a 2-top, not an 8-top!
        const findTableSql = `
            SELECT table_id 
            FROM fb_tables 
            WHERE capacity >= ? 
            AND table_id NOT IN (
                SELECT table_id 
                FROM fb_dining_reservation 
                WHERE reservation_date = ? 
                AND reservation_time = ? 
                AND status IN ('Confirmed', 'Seated')
                AND table_id IS NOT NULL
            )
            ORDER BY capacity ASC
            LIMIT 1;
        `;

        const [availableTables] = await connection.query(findTableSql, [
            party_size, 
            reservation_date, 
            reservation_time
        ]);

        // 4. Handle the "Fully Booked" scenario
        if (availableTables.length === 0) {
            await connection.rollback();
            return res.status(404).json({ 
                message: "We are sorry, but there are no tables available for that party size at that time." 
            });
        }

        const assignedTableId = availableTables[0].table_id;

        // 5. Save the Confirmed Reservation
        const insertSql = `
            INSERT INTO fb_dining_reservation 
            (user_id, first_name, last_name, email, reservation_date, reservation_time, party_size, table_id, status, special_requests) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'Confirmed', ?)
        `;
        
        const [result] = await connection.query(insertSql, [
            userId, firstName, lastName, email, 
            reservation_date, reservation_time, party_size, 
            assignedTableId, special_requests || null
        ]);

        await connection.commit();

       await connection.commit();

        // --- NODEMAILER: SEND CONFIRMATION EMAIL ---
        
        // 1. Create the transporter (The digital mail carrier)
        const transporter = nodemailer.createTransport({
            service: 'gmail', // Change this if you are using Outlook or Yahoo
            auth: {
                user: process.env.EMAIL_USER,
                pass: process.env.EMAIL_PASS
            }
        });

        // 2. Format the time to look nice (e.g., 19:00:00 to 7:00 PM)
        const formattedTime = new Date(`1970-01-01T${reservation_time}Z`).toLocaleTimeString('en-US', {
            hour: 'numeric',
            minute: 'numeric',
            hour12: true
        });

        // 3. Draft the email
        const mailOptions = {
            from: `"Celestia Hotel Dining" <${process.env.EMAIL_USER}>`,
            to: email, // Sending it to the guest's email we grabbed from req.user
            subject: 'Dining Reservation Confirmed - Celestia Hotel',
            html: `
                <div style="font-family: Arial, sans-serif; color: #3C2A21; max-width: 600px; margin: 0 auto; border: 1px solid #E5E7EB; border-radius: 8px; overflow: hidden;">
                    <div style="background-color: #480c1b; padding: 20px; text-align: center;">
                        <h1 style="color: #F9A825; margin: 0;">Celestia Hotel</h1>
                    </div>
                    <div style="padding: 30px; background-color: #FFF8E7;">
                        <h2 style="color: #480c1b;">Your Reservation is Confirmed!</h2>
                        <p>Dear ${firstName},</p>
                        <p>We are thrilled to confirm your dining reservation. Here are your details:</p>
                        <table style="width: 100%; margin-top: 20px; margin-bottom: 20px; border-collapse: collapse;">
                            <tr>
                                <td style="padding: 8px 0; border-bottom: 1px solid #F5E6D3;"><strong>Date:</strong></td>
                                <td style="padding: 8px 0; border-bottom: 1px solid #F5E6D3;">${reservation_date}</td>
                            </tr>
                            <tr>
                                <td style="padding: 8px 0; border-bottom: 1px solid #F5E6D3;"><strong>Time:</strong></td>
                                <td style="padding: 8px 0; border-bottom: 1px solid #F5E6D3;">${formattedTime}</td>
                            </tr>
                            <tr>
                                <td style="padding: 8px 0; border-bottom: 1px solid #F5E6D3;"><strong>Party Size:</strong></td>
                                <td style="padding: 8px 0; border-bottom: 1px solid #F5E6D3;">${party_size} People</td>
                            </tr>
                        </table>
                        <p style="font-size: 14px; color: #666;"><em>Note: We hold reservations for a 15-minute grace period. If your plans change, please let us know!</em></p>
                    </div>
                </div>
            `
        };

        // 4. Send the email (We don't 'await' this so the user's browser doesn't hang while waiting for Gmail)
        transporter.sendMail(mailOptions, (err, info) => {
            if (err) {
                console.error("Email sending failed:", err);
                // We don't crash the server here, because the table is still successfully booked!
            } else {
                console.log("Confirmation email sent:", info.response);
            }
        });

        // -------------------------------------------

        res.status(201).json({ 
            message: "Reservation confirmed!", 
            reservation_id: result.insertId,
            table_id: assignedTableId
        });

    } catch (error) {
        await connection.rollback();
        console.error("Create Reservation Error:", error);
        res.status(500).json({ message: "Error processing reservation", error: error.message });
    } finally {
        connection.release();
    }
};

// @desc    Get all reservations for the host view
export const getReservations = async (req, res) => {
    try {
        const sql = `
            SELECT 
                r.reservation_id, r.first_name, r.last_name, r.email, 
                r.reservation_date, r.reservation_time, r.party_size, 
                r.status, r.special_requests,
                t.table_number 
            FROM fb_dining_reservation r
            LEFT JOIN fb_tables t ON r.table_id = t.table_id
            WHERE DATE(r.reservation_date) = CURDATE() 
            ORDER BY r.reservation_time ASC
        `;
        const [reservations] = await pool.query(sql);
        res.json(reservations);
    } catch (error) {
        console.error("Get Reservations Error:", error);
        res.status(500).json({ message: "Error fetching reservations", error: error.message });
    }
};

// @desc    Update a reservation's status (e.g., to 'Seated' or 'No-Show')
export const updateReservationStatus = async (req, res) => {
    const { id } = req.params; // Grabbing the ID from the URL
    const { status } = req.body; // Grabbing the new status from the frontend payload

    // Validation: Prevent trolls from sending fake statuses
    const validStatuses = ['Pending', 'Confirmed', 'Seated', 'No-Show', 'Cancelled'];
    if (!validStatuses.includes(status)) {
        return res.status(400).json({ message: "Invalid status update requested." });
    }

    try {
        const sql = `
            UPDATE fb_dining_reservation 
            SET status = ? 
            WHERE reservation_id = ?
        `;
        const [result] = await pool.query(sql, [status, id]);

        if (result.affectedRows === 0) {
            return res.status(404).json({ message: "Reservation not found." });
        }

        res.json({ message: `Reservation status updated to ${status}` });
    } catch (error) {
        console.error("Update Reservation Status Error:", error);
        res.status(500).json({ message: "Error updating reservation", error: error.message });
    }
};

// @desc    Get available tables for a specific date, time, and pax
// @route   POST /api/reservations/available-tables
// @access  Public (or Private depending on your auth setup)
export const getAvailableTables = async (req, res) => {
    const { date, time, party_size } = req.body;

    if (!date || !time || !party_size) {
        return res.status(400).json({ message: "Please provide date, time, and party size." });
    }

    const connection = await pool.getConnection();

    try {
        // The 2-Hour Overlap SQL Query
        const sql = `
            SELECT table_id, table_number, capacity AS seating_capacity 
            FROM fb_tables
            WHERE capacity >= ? 
            AND status = 'Available' 
            AND table_id NOT IN (
                SELECT table_id 
                FROM fb_dining_reservation
                WHERE reservation_date = ?
                AND status IN ('Pending', 'Confirmed', 'Seated') 
                AND table_id IS NOT NULL
                AND reservation_time < ADDTIME(?, '02:00:00') 
                AND ADDTIME(reservation_time, '02:00:00') > ?
            )
            ORDER BY capacity ASC; 
        `;

        const [availableTables] = await connection.query(sql, [
            party_size, 
            date, 
            time, 
            time
        ]);

        res.status(200).json(availableTables);

    } catch (error) {
        console.error("Error fetching available tables:", error);
        res.status(500).json({ message: "Failed to fetch tables", error: error.message });
    } finally {
        connection.release();
    }
};
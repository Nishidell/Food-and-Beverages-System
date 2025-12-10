import pool from "../config/mysql.js";

// @desc    Get all rooms (for Room Service selection)
// @route   GET /api/rooms
// @access  Public (Used in Menu/POS)
export const getAllRooms = async (req, res) => {
    try {
        // We fetch Room ID, Number, and Status
        // Ordering by Room Number makes it easier to find
        const [rooms] = await pool.query("SELECT room_id, room_num, status, room_type FROM tbl_rooms ORDER BY room_num ASC");
        res.json(rooms);
    } catch (error) {
        res.status(500).json({ message: "Error fetching rooms", error: error.message });
    }
};

// @desc    Get the active room for the logged-in client
// @route   GET /api/rooms/my-active-room
// @access  Client (Protected)
export const getMyActiveRoom = async (req, res) => {
  try {
    const client_id = req.user.userId; // From Auth Token

    // 1. Logic: Find Active Reservation for Today
    // We check if CURDATE() is between check_in and check_out
    // AND the status implies they are currently a guest (Approved/Checked In)
    const sql = `
      SELECT 
        r.room_id, 
        r.room_num, 
        r.room_name,
        res.reservation_id
      FROM tbl_reservations res
      JOIN tbl_reservation_rooms rr ON res.reservation_id = rr.reservation_id
      JOIN tbl_rooms r ON rr.room_id = r.room_id
      WHERE res.client_id = ?
      AND res.status IN ('Approved', 'Checked In') 
      AND CURDATE() >= res.check_in 
      AND CURDATE() < res.check_out -- Usually checkout day implies they leave by noon, but let's keep it inclusive for now if needed
      LIMIT 1; 
    `;

    // Note: The LIMIT 1 assumes 1 active room per user. 
    // If a user can book 2 rooms, remove LIMIT 1 and handle array in frontend.

    const [rows] = await pool.query(sql, [client_id]);

    if (rows.length === 0) {
      return res.status(404).json({ message: "No active room reservation found for today." });
    }

    // Return the room details
    res.json({
      success: true,
      room: rows[0]
    });

  } catch (error) {
    console.error("Get Active Room Error:", error);
    res.status(500).json({ message: "Server error fetching active room" });
  }
};
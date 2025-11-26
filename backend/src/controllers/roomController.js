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
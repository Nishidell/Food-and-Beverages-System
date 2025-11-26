import pool from "../config/mysql.js";

// @desc    Get all tables
// @route   GET /api/tables
// @access  Public (for Menu/POS)
export const getAllTables = async (req, res) => {
    try {
        const [tables] = await pool.query("SELECT * FROM fb_tables ORDER BY CAST(table_number AS UNSIGNED) ASC");
        res.json(tables);
    } catch (error) {
        res.status(500).json({ message: "Error fetching tables", error: error.message });
    }
};

// @desc    Update Table Status
// @route   PUT /api/tables/:id/status
// @access  Staff
export const updateTableStatus = async (req, res) => {
    const { id } = req.params;
    const { status } = req.body; // 'Available', 'Occupied', 'Reserved'

    if (!['Available', 'Occupied', 'Reserved'].includes(status)) {
        return res.status(400).json({ message: "Invalid status value." });
    }

    try {
        await pool.query("UPDATE fb_tables SET status = ? WHERE table_id = ?", [status, id]);
        res.json({ message: `Table ${id} is now ${status}` });
    } catch (error) {
        res.status(500).json({ message: "Error updating table status", error: error.message });
    }
};
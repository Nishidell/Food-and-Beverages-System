import pool from "../config/mysql.js";

// @desc    Create a Master Promotion (e.g., "Christmas Special")
// @route   POST /api/promotions
// @access  F&B Admin
export const createPromotion = async (req, res) => {
    const { name, description, discount_percentage, start_date, end_date } = req.body;

    if (!name || !discount_percentage || !start_date || !end_date) {
        return res.status(400).json({ message: "Please provide all promotion details." });
    }

    try {
        const sql = `
            INSERT INTO fb_promotions (name, description, discount_percentage, start_date, end_date, is_active)
            VALUES (?, ?, ?, ?, ?, 1)
        `;
        const [result] = await pool.query(sql, [name, description, discount_percentage, start_date, end_date]);

        res.status(201).json({ 
            message: "Promotion created successfully", 
            promotion_id: result.insertId 
        });
    } catch (error) {
        res.status(500).json({ message: "Error creating promotion", error: error.message });
    }
};

// @desc    Get All Promotions (with item count)
// @route   GET /api/promotions
// @access  F&B Admin
export const getAllPromotions = async (req, res) => {
    try {
        // UPDATED QUERY: Joins with menu_items and counts them
        const sql = `
            SELECT 
                p.*, 
                COUNT(mi.item_id) AS item_count 
            FROM fb_promotions p
            LEFT JOIN fb_menu_items mi ON p.promotion_id = mi.promotion_id
            GROUP BY p.promotion_id
            ORDER BY p.start_date DESC
        `;
        const [promos] = await pool.query(sql);
        res.json(promos);
    } catch (error) {
        res.status(500).json({ message: "Error fetching promotions", error: error.message });
    }
};

// @desc    Bulk Apply Promotion to Multiple Items
// @route   POST /api/promotions/apply
// @access  F&B Admin
export const applyPromotionToItems = async (req, res) => {
    const { promotion_id, item_ids } = req.body; // item_ids should be an array: [1, 5, 12]

    if (!promotion_id || !item_ids || item_ids.length === 0) {
        return res.status(400).json({ message: "Please provide a promotion ID and a list of items." });
    }

    try {
        // This single query updates ALL selected items at once!
        const sql = `
            UPDATE fb_menu_items 
            SET promotion_id = ? 
            WHERE item_id IN (?)
        `;
        
        // The mysql2 library handles the array conversion for 'IN (?)' automatically
        await pool.query(sql, [promotion_id, item_ids]);

        res.json({ message: `Successfully applied promotion to ${item_ids.length} items.` });

    } catch (error) {
        console.error("Bulk Apply Error:", error);
        res.status(500).json({ message: "Error applying promotion", error: error.message });
    }
};

// @desc    Remove Promotion from Items (Bulk)
// @route   POST /api/promotions/remove
// @access  F&B Admin
export const removePromotionFromItems = async (req, res) => {
    const { item_ids } = req.body;

    if (!item_ids || item_ids.length === 0) {
        return res.status(400).json({ message: "Please provide a list of items." });
    }

    try {
        const sql = `UPDATE fb_menu_items SET promotion_id = NULL WHERE item_id IN (?)`;
        await pool.query(sql, [item_ids]);

        res.json({ message: `Successfully removed promotion from ${item_ids.length} items.` });
    } catch (error) {
        res.status(500).json({ message: "Error removing promotion", error: error.message });
    }
};

// @desc    Delete a Promotion
// @route   DELETE /api/promotions/:id
// @access  F&B Admin
export const deletePromotion = async (req, res) => {
    const { id } = req.params;
    try {
        // Because we set "ON DELETE SET NULL" in the database schema,
        // deleting this row will automatically remove the promo from all linked items.
        const [result] = await pool.query("DELETE FROM fb_promotions WHERE promotion_id = ?", [id]);

        if (result.affectedRows === 0) {
            return res.status(404).json({ message: "Promotion not found" });
        }

        res.json({ message: "Promotion deleted successfully. All linked items have been reverted to normal price." });
    } catch (error) {
        res.status(500).json({ message: "Error deleting promotion", error: error.message });
    }
};

// @desc    Toggle Promotion Status (Active/Inactive)
// @route   PUT /api/promotions/:id/status
// @access  F&B Admin
export const togglePromotionStatus = async (req, res) => {
    const { id } = req.params;
    
    try {
        // 1. Get current status
        const [rows] = await pool.query("SELECT is_active FROM fb_promotions WHERE promotion_id = ?", [id]);
        if (rows.length === 0) {
            return res.status(404).json({ message: "Promotion not found" });
        }

        const currentStatus = rows[0].is_active;
        const newStatus = currentStatus === 1 ? 0 : 1; // Toggle between 1 and 0

        // 2. Update status
        await pool.query("UPDATE fb_promotions SET is_active = ? WHERE promotion_id = ?", [newStatus, id]);

        res.json({ 
            message: `Promotion ${newStatus === 1 ? 'activated' : 'deactivated'} successfully.`, 
            is_active: newStatus 
        });

    } catch (error) {
        res.status(500).json({ message: "Error toggling promotion status", error: error.message });
    }
};
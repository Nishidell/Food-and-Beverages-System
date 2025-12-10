import pool from "../config/mysql.js";

// @desc    Get all categories
// @route   GET /api/categories
export const getAllCategories = async (req, res) => {
    try {
        // ✅ FIX: Changed 'categories' to 'fb_categories'
        const [categories] = await pool.query("SELECT * FROM fb_categories ORDER BY category_id ASC");
        res.json(categories);
    } catch (error) {
        res.status(500).json({ message: "Error fetching categories", error: error.message });
    }
};

// @desc    Create a new category
// @route   POST /api/categories
// @access  Admin
export const createCategory = async (req, res) => {
    const { name } = req.body;
    if (!name) {
        return res.status(400).json({ message: "Category name is required" });
    }

    try {
        // ✅ FIX: Changed 'categories' to 'fb_categories'
        const [existing] = await pool.query("SELECT * FROM fb_categories WHERE name = ?", [name]);
        if (existing.length > 0) {
            return res.status(400).json({ message: "Category already exists" });
        }

        const [result] = await pool.query("INSERT INTO fb_categories (name) VALUES (?)", [name]);
        res.status(201).json({ category_id: result.insertId, name });
    } catch (error) {
        res.status(500).json({ message: "Error creating category", error: error.message });
    }
};

// @desc    Update category name
// @route   PUT /api/categories/:id
// @access  Admin
export const updateCategory = async (req, res) => {
    const { id } = req.params;
    const { name } = req.body;

    if (!name) return res.status(400).json({ message: "Category name is required" });

    try {
        // ✅ FIX: Changed 'categories' to 'fb_categories'
        const [result] = await pool.query("UPDATE fb_categories SET name = ? WHERE category_id = ?", [name, id]);
        
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: "Category not found" });
        }

        res.json({ message: "Category updated successfully", category_id: id, name });
    } catch (error) {
        res.status(500).json({ message: "Error updating category", error: error.message });
    }
};

// @desc    Delete category
// @route   DELETE /api/categories/:id
export const deleteCategory = async (req, res) => {
    try {
        // ✅ FIX: Changed 'categories' to 'fb_categories'
        const [result] = await pool.query("DELETE FROM fb_categories WHERE category_id = ?", [req.params.id]);
        if (result.affectedRows === 0) return res.status(404).json({ message: "Category not found" });
        res.json({ message: "Category deleted" });
    } catch (error) {
        res.status(500).json({ message: "Cannot delete category (it might contain items)", error: error.message });
    }
};
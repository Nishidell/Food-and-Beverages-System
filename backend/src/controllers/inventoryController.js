import pool from "../config/mysql.js";

// Helper function to create a log entry
const createLog = async (ingredient_id, staff_id, action_type, quantity_change, new_stock_level, reason, connection) => {
    const logSql = "INSERT INTO fb_inventory_logs (ingredient_id, staff_id, action_type, quantity_change, new_stock_level, reason) VALUES (?, ?, ?, ?, ?, ?)";
    await (connection || pool).query(logSql, [ingredient_id, staff_id, action_type, quantity_change, new_stock_level, reason || null]);
};

// @desc    Get all ingredients
// @route   GET /api/inventory
// @access  Staff
export const getAllIngredients = async (req, res) => {
    try {
        const [ingredients] = await pool.query("SELECT * FROM fb_ingredients ORDER BY name ASC");
        res.json(ingredients);
    } catch (error) {
        res.status(500).json({ message: "Error fetching ingredients", error: error.message });
    }
};

// @desc    Get single ingredient by ID
// @route   GET /api/inventory/:id
// @access  Staff
export const getIngredientById = async (req, res) => {
    try {
        const [ingredients] = await pool.query("SELECT * FROM fb_ingredients WHERE ingredient_id = ?", [req.params.id]);
        if (ingredients.length === 0) {
            return res.status(404).json({ message: "Ingredient not found" });
        }
        res.json(ingredients[0]);
    } catch (error) {
        res.status(500).json({ message: "Error fetching ingredient", error: error.message });
    }
};

// @desc    Create a new ingredient
// @route   POST /api/inventory
// @access  Staff
export const createIngredient = async (req, res) => {
    const { name, stock_level = 0, unit_of_measurement } = req.body;
    // FIX: We need to resolve the employee_id (staff_id) first
    // const staff_id = req.user.id; <--- OLD LINE REMOVED

    if (!name || !unit_of_measurement) {
        return res.status(400).json({ message: "Name and unit of measurement are required." });
    }

    const connection = await pool.getConnection();
    try {
        await connection.beginTransaction();

        // 1. LOOKUP: Get employee_id using the logged-in user_id
        const [empRows] = await connection.query(
            "SELECT employee_id FROM employees WHERE user_id = ?", 
            [req.user.id]
        );
        
        if (empRows.length === 0) {
            throw new Error("Staff profile not found for this user.");
        }
        const staff_id = empRows[0].employee_id;

        // 2. Insert Ingredient
        const sql = "INSERT INTO fb_ingredients (name, stock_level, unit_of_measurement) VALUES (?, ?, ?)";
        const [result] = await connection.query(sql, [name, stock_level, unit_of_measurement]);
        const newIngredientId = result.insertId;

        // 3. Log the initial stock using the resolved staff_id
        await createLog(newIngredientId, staff_id, 'INITIAL', stock_level, stock_level, 'Ingredient created', connection);
        
        await connection.commit();
        res.status(201).json({
            ingredient_id: newIngredientId,
            name,
            stock_level,
            unit_of_measurement
        });
    } catch (error) {
        await connection.rollback();
        res.status(500).json({ message: "Error creating ingredient", error: error.message });
    } finally {
        connection.release();
    }
};

// @desc    Update ingredient details (name, unit)
// @route   PUT /api/inventory/:id
// @access  Staff
export const updateIngredientDetails = async (req, res) => {
    const { name, unit_of_measurement } = req.body;
    const { id } = req.params;

    if (!name || !unit_of_measurement) {
        return res.status(400).json({ message: "Name and unit of measurement are required." });
    }

    try {
        const sql = "UPDATE fb_ingredients SET name = ?, unit_of_measurement = ? WHERE ingredient_id = ?";
        const [result] = await pool.query(sql, [name, unit_of_measurement, id]);

        if (result.affectedRows === 0) {
            return res.status(404).json({ message: "Ingredient not found" });
        }
        res.json({ message: "Ingredient details updated" });
    } catch (error) {
        res.status(500).json({ message: "Error updating ingredient", error: error.message });
    }
};

// @desc    Adjust ingredient stock (Restock, Waste, etc.)
// @route   PUT /api/inventory/:id/stock
// @access  Staff
export const adjustIngredientStock = async (req, res) => {
    const { id } = req.params;
    const { quantity_change, action_type, reason } = req.body; 
    
    // FIX: Remove direct assignment
    // const staff_id = req.user.id; <--- OLD LINE REMOVED

    if (!quantity_change || !action_type) {
        return res.status(400).json({ message: "Quantity change and action type are required." });
    }

    const parsedQty = parseFloat(quantity_change);
    if (isNaN(parsedQty)) {
        return res.status(400).json({ message: "Invalid quantity change." });
    }

    const connection = await pool.getConnection();
    try {
        await connection.beginTransaction();

        // 1. LOOKUP: Get employee_id
        const [empRows] = await connection.query(
            "SELECT employee_id FROM employees WHERE user_id = ?", 
            [req.user.id]
        );
        if (empRows.length === 0) {
            throw new Error("Staff profile not found.");
        }
        const staff_id = empRows[0].employee_id;

        // 2. Lock the row for update
        const [rows] = await connection.query("SELECT stock_level FROM fb_ingredients WHERE ingredient_id = ? FOR UPDATE", [id]);
        if (rows.length === 0) {
            await connection.rollback();
            return res.status(404).json({ message: "Ingredient not found" });
        }
        
        const currentStock = parseFloat(rows[0].stock_level);
        let newStockLevel;

        if (action_type === 'RESTOCK' || action_type === 'ADJUST_ADD') {
            newStockLevel = currentStock + parsedQty;
        } else if (action_type === 'WASTE' || action_type === 'ADJUST_SUBTRACT') {
            newStockLevel = currentStock - parsedQty;
            if (newStockLevel < 0) {
                console.warn(`Ingredient ${id} stock is now negative.`);
            }
        } else {
            await connection.rollback();
            return res.status(400).json({ message: "Invalid action type." });
        }

        // 3. Update the stock
        await connection.query("UPDATE fb_ingredients SET stock_level = ? WHERE ingredient_id = ?", [newStockLevel, id]);

        // 4. Create the log entry using correct staff_id
        await createLog(id, staff_id, action_type, parsedQty, newStockLevel, reason, connection);

        await connection.commit();
        res.json({ message: "Stock updated successfully", new_stock_level: newStockLevel });

    } catch (error) {
        await connection.rollback();
        res.status(500).json({ message: "Error updating stock", error: error.message });
    } finally {
        connection.release();
    }
};

// @desc    Delete an ingredient
// @route   DELETE /api/inventory/:id
// @access  Staff
export const deleteIngredient = async (req, res) => {
    // Note: Deleting an ingredient will fail if it's used in a recipe
    // due to the foreign key constraint, which is good!
    try {
        const [result] = await pool.query("DELETE FROM fb_ingredients WHERE ingredient_id = ?", [req.params.id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: "Ingredient not found" });
        }
        res.json({ message: "Ingredient deleted successfully" });
    } catch (error) {
        if (error.code === 'ER_ROW_IS_REFERENCED_2') {
             return res.status(400).json({ message: "Cannot delete ingredient. It is currently used in a menu item recipe." });
        }
        res.status(500).json({ message: "Error deleting ingredient", error: error.message });
    }
};

// @desc    Get all inventory logs
// @route   GET /api/inventory/logs
// @access  Admin
export const getInventoryLogs = async (req, res) => {
    try {
        // UPDATED: Join 'employees' table using 'user_id'
        // We assume l.staff_id stores the user_id from the token
        const sql = `
        SELECT 
            l.*, 
            i.name as ingredient_name, 
            COALESCE(CONCAT(e.first_name, ' ', e.last_name), 'System (Order)') as staff_name
        FROM fb_inventory_logs l
        JOIN fb_ingredients i ON l.ingredient_id = i.ingredient_id
        LEFT JOIN employees e ON l.staff_id = e.user_id
        ORDER BY l.timestamp DESC
        LIMIT 100
    `;
        const [logs] = await pool.query(sql);
        res.json(logs);
    } catch (error) {
        res.status(500).json({ message: "Error fetching inventory logs", error: error.message });
    }
};
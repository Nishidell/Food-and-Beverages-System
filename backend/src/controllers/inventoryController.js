import pool from "../config/mysql.js";
import xlsx from 'xlsx';

// Helper function to create a log entry
const createLog = async (ingredient_id, employee_id, action_type, quantity_change, new_stock_level, reason, connection) => {
    const logSql = "INSERT INTO fb_inventory_logs (ingredient_id, employee_id, action_type, quantity_change, new_stock_level, reason) VALUES (?, ?, ?, ?, ?, ?)";
    await (connection || pool).query(logSql, [ingredient_id, employee_id, action_type, quantity_change, new_stock_level, reason || null]);
};

// @desc    Get all ingredients
export const getAllIngredients = async (req, res) => {
    try {
        const [ingredients] = await pool.query("SELECT * FROM fb_ingredients ORDER BY name ASC");
        res.json(ingredients);
    } catch (error) {
        res.status(500).json({ message: "Error fetching ingredients", error: error.message });
    }
};

// @desc    Get single ingredient by ID
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
export const createIngredient = async (req, res) => {
    // Extract reorder_point and unit_cost from request
    const { name, stock_level = 0, unit_of_measurement, reorder_point = 10, unit_cost = 0.00 } = req.body;

    if (!name || !unit_of_measurement) {
        return res.status(400).json({ message: "Name and unit of measurement are required." });
    }

    const connection = await pool.getConnection();
    try {
        await connection.beginTransaction();

        // 1. HRIS INTEGRATION: Get employee_id using the logged-in user_id
        const [empRows] = await connection.query(
            "SELECT employee_id FROM employees WHERE user_id = ?", 
            [req.user.id]
        );
        
        if (empRows.length === 0) {
            throw new Error("HRIS Staff profile not found for this user.");
        }
        const employee_id = empRows[0].employee_id;

        // 2. Insert Ingredient (Added reorder_point and unit_cost)
        const sql = "INSERT INTO fb_ingredients (name, stock_level, unit_of_measurement, reorder_point, unit_cost) VALUES (?, ?, ?, ?, ?)";
        const [result] = await connection.query(sql, [name, stock_level, unit_of_measurement, reorder_point, unit_cost]);
        const newIngredientId = result.insertId;

        // 3. Log using employee_id
        await createLog(newIngredientId, employee_id, 'INITIAL', stock_level, stock_level, 'Ingredient created', connection);
        
        await connection.commit();
        res.status(201).json({
            ingredient_id: newIngredientId,
            name,
            stock_level,
            unit_of_measurement,
            reorder_point // Return new value
        });
    } catch (error) {
        await connection.rollback();
        console.error("Create Ingredient Error:", error);
        res.status(500).json({ message: "Error creating ingredient", error: error.message });
    } finally {
        connection.release();
    }
};

// @desc    Update ingredient details
export const updateIngredientDetails = async (req, res) => {
    // Extract reorder_point and unit_cost to allow editing
    const { name, unit_of_measurement, reorder_point, unit_cost } = req.body;
    const { id } = req.params;

    if (!name || !unit_of_measurement) {
        return res.status(400).json({ message: "Name and unit of measurement are required." });
    }

   try {
        // Update SQL query to include reorder_point and unit_cost
        const sql = "UPDATE fb_ingredients SET name = ?, unit_of_measurement = ?, reorder_point = ?, unit_cost = ? WHERE ingredient_id = ?";
        
        const safeReorderPoint = reorder_point !== undefined ? reorder_point : 10;
        const safeUnitCost = unit_cost !== undefined ? unit_cost : 0.00;
        
        const [result] = await pool.query(sql, [name, unit_of_measurement, safeReorderPoint, safeUnitCost, id]);

        if (result.affectedRows === 0) {
            return res.status(404).json({ message: "Ingredient not found" });
        }
        res.json({ message: "Ingredient details updated" });
    } catch (error) {
        res.status(500).json({ message: "Error updating ingredient", error: error.message });
    }
};

// @desc    Adjust ingredient stock
export const adjustIngredientStock = async (req, res) => {
    const { id } = req.params;
    const { quantity_change, action_type, reason } = req.body; 

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

        // 1. HRIS INTEGRATION: Get employee_id
        const [empRows] = await connection.query(
            "SELECT employee_id FROM employees WHERE user_id = ?", 
            [req.user.id]
        );
        if (empRows.length === 0) {
            throw new Error("HRIS Staff profile not found.");
        }
        const employee_id = empRows[0].employee_id;

        // 2. Lock row
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
                await connection.rollback(); // Cancel the transaction
                return res.status(400).json({ message: "Invalid action: Stock cannot drop below zero." });
            }
        } else {
            await connection.rollback();
            return res.status(400).json({ message: "Invalid action type." });
        }

        // 3. Update stock
        await connection.query("UPDATE fb_ingredients SET stock_level = ? WHERE ingredient_id = ?", [newStockLevel, id]);

        // 4. Create log using employee_id
        await createLog(id, employee_id, action_type, parsedQty, newStockLevel, reason, connection);

        await connection.commit();
        res.json({ message: "Stock updated successfully", new_stock_level: newStockLevel });

    } catch (error) {
        await connection.rollback();
        console.error("Adjust Stock Error:", error);
        res.status(500).json({ message: "Error updating stock", error: error.message });
    } finally {
        connection.release();
    }
};

// @desc    Delete an ingredient
export const deleteIngredient = async (req, res) => {
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
export const getInventoryLogs = async (req, res) => {
    try {
        const sql = `
        SELECT 
            l.*, 
            i.name as ingredient_name, 
            COALESCE(CONCAT(e.first_name, ' ', e.last_name), 'System (Order)') as staff_name
        FROM fb_inventory_logs l
        JOIN fb_ingredients i ON l.ingredient_id = i.ingredient_id
        LEFT JOIN employees e ON l.employee_id = e.employee_id 
        ORDER BY l.timestamp DESC
        LIMIT 100
    `;
        const [logs] = await pool.query(sql);
        res.json(logs);
    } catch (error) {
        console.error("Get Logs Error:", error);
        res.status(500).json({ message: "Error fetching inventory logs", error: error.message });
    }
};

// @desc    Export inventory valuation to Excel
export const exportInventoryValue = async (req, res) => {
    try {
        // 1. Get the freshest data right from the database
        const [ingredients] = await pool.query("SELECT * FROM fb_ingredients ORDER BY name ASC");
        
        let grandTotal = 0;

        // 2. Format the data exactly how Accounting wants it
        const excelData = ingredients.map(item => {
            const stock = parseFloat(item.stock_level) || 0;
            const cost = parseFloat(item.unit_cost) || 0;
            const totalValue = stock * cost;
            
            grandTotal += totalValue;

            return {
                "Ingredient ID": item.ingredient_id,
                "Ingredient Name": item.name,
                "Current Stock": stock,
                "Unit": item.unit_of_measurement,
                "Unit Cost (PHP)": cost,
                "Total Value (PHP)": totalValue
            };
        });

        // 3. Add a blank row, then the Grand Total row at the bottom
        excelData.push({}); 
        excelData.push({
            "Ingredient Name": "GRAND TOTAL",
            "Total Value (PHP)": grandTotal
        });

        // 4. Create the Excel Workbook and Sheet
        const worksheet = xlsx.utils.json_to_sheet(excelData);
        const workbook = xlsx.utils.book_new();
        xlsx.utils.book_append_sheet(workbook, worksheet, "Inventory Valuation");

        // 5. Convert to a Buffer so we can send it over the internet
        const excelBuffer = xlsx.write(workbook, { type: 'buffer', bookType: 'xlsx' });

        // 6. Set headers to trigger a file download in the browser
        const dateStr = new Date().toISOString().split('T')[0]; // Gets YYYY-MM-DD
        res.setHeader('Content-Disposition', `attachment; filename="Inventory_Valuation_${dateStr}.xlsx"`);
        res.setHeader('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        
        // 7. Send the file!
        res.send(excelBuffer);

    } catch (error) {
        console.error("Export Error:", error);
        res.status(500).json({ message: "Error exporting inventory", error: error.message });
    }
};
import pool from "../config/mysql.js";

// Change this number to whatever F&B's actual Department ID is!
const FB_DEPARTMENT_ID = 4; 

// @desc    Get all budget requests (expense notifications)
export const getBudgetRequests = async (req, res) => {
    try {
        // ✅ Added WHERE department_id = ?
        const sql = `
            SELECT 
                notification_id as id,
                title,
                requested_amount,
                priority,
                purpose,
                status,
                rejection_reason,
                created_at as date
            FROM expense_notifications 
            WHERE department_id = ? 
            ORDER BY created_at DESC
        `;
        const [requests] = await pool.query(sql, [FB_DEPARTMENT_ID]);
        res.json(requests);
    } catch (error) {
        console.error("Get Budget Requests Error:", error);
        res.status(500).json({ message: "Error fetching budget requests", error: error.message });
    }
};

// @desc    Create a new budget request
export const createBudgetRequest = async (req, res) => {
    const { title, requested_amount, priority, purpose } = req.body;

    if (!title || !requested_amount || !purpose) {
        return res.status(400).json({ message: "Title, amount, and purpose are required." });
    }

    const connection = await pool.getConnection();
    try {
        await connection.beginTransaction();

        const [empRows] = await connection.query(
            "SELECT first_name, last_name FROM employees WHERE user_id = ?", 
            [req.user.id]
        );
        
        let requested_by = "F&B Manager";
        if (empRows.length > 0) {
            requested_by = `${empRows[0].first_name} ${empRows[0].last_name}`;
        }

        // ✅ Now inserting the department_id so Accounting knows who asked for it!
        const sql = `
            INSERT INTO expense_notifications 
            (department_id, title, requested_amount, priority, purpose, requested_by, status) 
            VALUES (?, ?, ?, ?, ?, ?, 'pending')
        `;
        
        const [result] = await connection.query(sql, [
            FB_DEPARTMENT_ID, // Inserts the F&B ID
            title, 
            requested_amount, 
            priority, 
            purpose, 
            requested_by
        ]);

        await connection.commit();
        res.status(201).json({ message: "Budget request submitted successfully!", id: result.insertId });

    } catch (error) {
        await connection.rollback();
        console.error("Create Budget Request Error:", error);
        res.status(500).json({ message: "Error submitting request", error: error.message });
    } finally {
        connection.release();
    }
};
import pool from "../config/mysql.js";
import bcrypt from "bcryptjs";

// @desc    Get all employees
// @route   GET /api/admin/employees
// @access  Admin
export const getAllEmployees = async (req, res) => {
    try {
        // [REFACTOR] 
        // Changed from `staff` to join `employees`, `users`, and `employee_emails`
        const sql = `
            SELECT 
                e.employee_id,
                e.first_name,   
                e.last_name,
                e.status,
                u.username,
                u.role,
                u.is_active,
                ee.email
            FROM employees e
            JOIN users u ON e.user_id = u.user_id
            LEFT JOIN employee_emails ee ON e.employee_id = ee.employee_id
        `;
        const [employees] = await pool.query(sql);
        res.json(employees);
    } catch (error) {
        res.status(500).json({ message: "Error fetching employee list", error: error.message });
    }
};

// @desc    Get all customers
// @route   GET /api/admin/customers
// @access  Admin
export const getAllCustomers = async (req, res) => {
    try {
        // --- THIS IS THE FIX ---
        // Changed "full_name" to "first_name, last_name"
        // This function was already correct and did not need refactoring.
        const [customers] = await pool.query("SELECT customer_id, first_name, last_name, email, phone, created_at FROM customers");
        res.json(customers);
    } catch (error) {
        res.status(500).json({ message: "Error fetching customer list", error: error.message });
    }
};

// @desc    Create a new employee
// @route   POST /api/admin/employees
// @access  Admin
export const createEmployee = async (req, res) => {
    // [REFACTOR]
    // This function mimics the staff registration logic from authController.
    // It creates a user, an employee profile, and an email entry in a transaction.
    
    const { 
        first_name, 
        middle_name, 
        last_name, 
        email, 
        password, 
        username, 
        role = "employee" 
    } = req.body;
    
    // Admin ID who is performing this action
    const created_by_user_id = req.user.userId; // from auth middleware

    if (!first_name || !last_name || !email || !password || !username || !role) {
        return res.status(400).json({ message: "First name, last name, email, password, username, and role are required." });
    }

    const connection = await pool.getConnection();
    try {
        await connection.beginTransaction();

        // Check for existing username
        const [existingUsername] = await connection.query(
            "SELECT * FROM users WHERE username = ?", [username]
        );
        if (existingUsername.length > 0) {
            throw new Error("Employee with this username already exists");
        }

        // Check for existing email
        const [existingEmail] = await connection.query(
            "SELECT * FROM employee_emails WHERE email = ?", [email]
        );
        if (existingEmail.length > 0) {
            throw new Error("Employee with this email already exists");
        }

        // Hash password
        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password, salt);

        // 1. Insert into users (authentication)
        const [userResult] = await connection.query(
          "INSERT INTO users (username, password, role, created_by) VALUES (?, ?, ?, ?)",
          [username, hashedPassword, role, created_by_user_id]
        );
        const userId = userResult.insertId;

        // 2. Insert into employees (profile)
        const [employeeResult] = await connection.query(
          `INSERT INTO employees 
          (user_id, first_name, middle_name, last_name, created_by) 
          VALUES (?, ?, ?, ?, ?)`,
          [userId, first_name, middle_name || null, last_name, created_by_user_id]
        );
        const employeeId = employeeResult.insertId;

        // 3. Insert into employee_emails
        await connection.query(
          "INSERT INTO employee_emails (employee_id, email, created_by) VALUES (?, ?, ?)",
          [employeeId, email, created_by_user_id]
        );

        await connection.commit();
        
        res.status(201).json({
            employee_id: employeeId,
            user_id: userId,
            message: "Employee member created successfully."
        });

    } catch (error) {
        await connection.rollback();
        console.error("Create Employee Error:", error);
        res.status(500).json({ message: error.message || "Error creating employee" });
    } finally {
        connection.release();
    }
};

// @desc    Update an employee's details
// @route   PUT /api/admin/employees/:id
// @access  Admin
export const updateEmployee = async (req, res) => {
    // [REFACTOR]
    // This is more complex than the last one, as data is in 3 tables.
    // This example updates profile info (employees) and auth info (users).
    
    const { id } = req.params; // This is employee_id
    const { 
        first_name, 
        middle_name, 
        last_name, 
        email, 
        username, 
        role, 
        status, // 'active', 'resigned', etc.
        is_active // true/false for login
    } = req.body;
    const updated_by_user_id = req.user.userId;

    const connection = await pool.getConnection();
    try {
        await connection.beginTransaction();

        // 1. Get the employee's user_id and email_id
        const [employee] = await connection.query(
            `SELECT e.user_id, ee.email_id 
             FROM employees e
             LEFT JOIN employee_emails ee ON e.employee_id = ee.employee_id
             WHERE e.employee_id = ?`, [id]
        );

        if (employee.length === 0) {
            throw new Error("Employee not found.");
        }
        const { user_id, email_id } = employee[0];

        // 2. Update employees table
        if (first_name || last_name || middle_name || status) {
            await connection.query(
                `UPDATE employees SET 
                    first_name = COALESCE(?, first_name),
                    last_name = COALESCE(?, last_name),
                    middle_name = COALESCE(?, middle_name),
                    status = COALESCE(?, status),
                    updated_by = ?
                 WHERE employee_id = ?`,
                 [first_name, last_name, middle_name, status, updated_by_user_id, id]
            );
        }

        // 3. Update users table
        if (username || role || is_active !== undefined) {
            await connection.query(
                `UPDATE users SET
                    username = COALESCE(?, username),
                    role = COALESCE(?, role),
                    is_active = COALESCE(?, is_active),
                    updated_by = ?
                 WHERE user_id = ?`,
                 [username, role, is_active, updated_by_user_id, user_id]
            );
        }

        // 4. Update employee_emails table
        if (email && email_id) {
            await connection.query(
                `UPDATE employee_emails SET
                    email = ?,
                    updated_by = ?
                 WHERE email_id = ?`,
                 [email, updated_by_user_id, email_id]
            );
        } else if (email && !email_id) {
            // If no email exists, create one
            await connection.query(
                "INSERT INTO employee_emails (employee_id, email, created_by) VALUES (?, ?, ?)",
                [id, email, updated_by_user_id]
            );
        }

        await connection.commit();
        res.json({ message: "Employee member updated successfully." });

    } catch (error) {
        await connection.rollback();
        console.error("Update Employee Error:", error);
        res.status(500).json({ message: error.message || "Error updating employee" });
    } finally {
        connection.release();
    }
};

// @desc    Delete an employee (soft delete)
// @route   DELETE /api/admin/employees/:id
// @access  Admin
export const deleteEmployee = async (req, res) => {
    // [REFACTOR]
    // Changed from hard DELETE to a "soft delete" for safety.
    // This sets their employee status to 'terminated' and delete their login.
    
    const { id } = req.params; // employee_id
    const updated_by_user_id = req.user.userId;

    const connection = await pool.getConnection();
    try {
        await connection.beginTransaction();

        // 1. Get user_id
        const [employee] = await connection.query(
            "SELECT user_id FROM employees WHERE employee_id = ?", [id]
        );
        if (employee.length === 0) {
            throw new Error("Employee not found.");
        }
        const { user_id } = employee[0];

        // 2. Set employee status to 'terminated'
        await connection.query(
            "UPDATE employees SET status = 'terminated', updated_by = ? WHERE employee_id = ?",
            [updated_by_user_id, id]
        );

        // 3. Set user `is_active` to 0 (false)
        await connection.query(
            "UPDATE users SET is_active = 0, updated_by = ? WHERE user_id = ?",
            [updated_by_user_id, user_id]
        );

        await connection.commit();
        res.json({ message: "Employee delete successfully." });

    } catch (error) {
        await connection.rollback();
        console.error("Delete Employee Error:", error);
        res.status(500).json({ message: error.message || "Error delete employee" });
    } finally {
        connection.release();
    }
};
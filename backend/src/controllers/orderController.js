import pool from "../config/mysql.js";
import { validateStock, adjustStock, logOrderStockChange } from "./itemController.js";

const SERVICE_RATE = 0.10; // 10%
const VAT_RATE = 0.12;     // 12%

// Helper function to emit socket events
const emitOrderUpdate = (req, eventName, data) => {
    try {
        const io = req.app.get('io');
        if (io) {
            io.emit(eventName, data);
            console.log(`📡 Socket event emitted: ${eventName}`, data);
        }
    } catch (error) {
        console.error('Failed to emit socket event:', error.message);
    }
};

// @desc    Create a new POS order (cash/staff)
// @route   POST /api/orders/pos
// @access  Private (Staff)
export const createPosOrder = async (req, res) => {
    const connection = await pool.getConnection();
    let order_id; 

    try {
        await connection.beginTransaction();

        // 1. Destructure the new 'customer_name' field
        const { 
          items, order_type, instructions, delivery_location, 
          payment_method, change_amount,
          client_id, table_id, 
          customer_name // <--- NEW FIELD FROM FRONTEND
        } = req.body;

        const [empRows] = await connection.query("SELECT employee_id FROM employees WHERE user_id = ?", [req.user.id]);
        
        if (empRows.length === 0) {
            throw new Error("Staff profile not found for this user.");
        }
        const employee_id = empRows[0].employee_id;
        
        // Step 1: Validate stock
        await validateStock(items, connection);

        // Step 2: Create the order
        // UPDATED SQL: Added 'guest_name' column
        // Step 2: Create the order in the NEW table
        const orderSql = `
            INSERT INTO fb_new_orders 
            (client_id, guest_name, employee_id, order_type, table_id, status, payment_status, total_amount) 
            VALUES (?, ?, ?, ?, ?, 'Open', 'unpaid', 0)
        `;

        const finalClientId = client_id || null;
        const finalGuestName = !client_id && customer_name ? customer_name : null;
        
        const [orderResult] = await connection.query(orderSql, [
            finalClientId,
            finalGuestName,
            employee_id, 
            order_type, 
            table_id || null
        ]); 
        order_id = orderResult.insertId;

        // --- Set Table to Occupied (if applicable) ---
        if (table_id) {
            await connection.query(
                "UPDATE fb_tables SET status = 'Occupied' WHERE table_id = ?", 
                [table_id]
            );
        }
        
        // Step 3: Calculate totals (Logic remains the same)
        let calculatedItemsTotal = 0; 

        for (const item of items) {
            // ... (Price fetching & Promo logic remains same) ...
            const [rows] = await connection.query(
                `SELECT mi.price, p.discount_percentage, p.start_date, p.end_date, p.is_active 
                 FROM fb_menu_items mi
                 LEFT JOIN fb_promotions p ON mi.promotion_id = p.promotion_id
                 WHERE mi.item_id = ?`, 
                [item.item_id]
            );

            if (rows.length === 0) continue;

            const dbItem = rows[0];
            let actualPrice = parseFloat(dbItem.price);

            if (dbItem.discount_percentage && dbItem.is_active) {
                const today = new Date();
                today.setHours(0, 0, 0, 0);
                const startDate = new Date(dbItem.start_date);
                const endDate = new Date(dbItem.end_date);
                
                if (today >= startDate && today <= endDate) { 
                    const discount = parseFloat(dbItem.discount_percentage) / 100;
                    actualPrice = actualPrice * (1 - discount); 
                }
            }
            
            const subtotal = actualPrice * item.quantity;
            calculatedItemsTotal += subtotal; // We still calculate this for the final math!
            
            const itemInstructions = item.instructions || instructions || '';
            
            // Insert into NEW details table
            const detailSql = "INSERT INTO fb_new_order_details (order_id, item_id, quantity, price_on_purchase, instructions, item_status) VALUES (?, ?, ?, ?, ?, 'pending')";
            await connection.query(detailSql, [order_id, item.item_id, item.quantity, actualPrice, itemInstructions]);
        }

        const calculatedServiceCharge = calculatedItemsTotal * SERVICE_RATE;
        const calculatedVatAmount = (calculatedItemsTotal + calculatedServiceCharge) * VAT_RATE; 
        const calculatedTotalAmount = calculatedItemsTotal + calculatedServiceCharge + calculatedVatAmount;

        await connection.query(
            `UPDATE fb_new_orders SET total_amount = ? WHERE order_id = ?`,
            [calculatedTotalAmount, order_id]
        );
        
        await adjustStock(items, 'deduct', connection);
        await logOrderStockChange(order_id, items, 'ORDER_DEDUCT', connection);

        if (payment_method !== 'Pay Later') {
            const paymentSql = "INSERT INTO fb_new_payments (order_id, payment_method, amount, change_amount, payment_status) VALUES (?, ?, ?, ?, 'paid')";
            await connection.query(paymentSql, [order_id, payment_method || "Cash", calculatedTotalAmount, change_amount || 0]);
        }

        await connection.commit();

        // Emit Socket Event with Correct Name
        // If it's a guest, send guest_name. If client, fetch their name.
        let firstName = finalGuestName;
        let lastName = '';
        if (finalClientId) {
             const [clientInfo] = await connection.query("SELECT first_name, last_name FROM tbl_client_users WHERE client_id = ?", [finalClientId]);
             if (clientInfo.length > 0) {
                 firstName = clientInfo[0].first_name;
                 lastName = clientInfo[0].last_name;
             }
        }

        emitOrderUpdate(req, 'new-order', {
            order_id,
            order_type,
            table_id,
            delivery_location,
            total_amount: calculatedTotalAmount,
            status: 'pending',
            first_name: firstName,
            last_name: lastName,
            timestamp: new Date()
        });

        // ✅ UPDATE RESPONSE: Return full financial details for the Receipt
        res.status(201).json({
            success: true,
            message: "POS order created successfully",
            order: {
                order_id,
                order_date: new Date(),
                order_type,
                customer_name: finalGuestName || (firstName + ' ' + lastName).trim() || 'Guest',
                delivery_location,
                // Financials
                items_total: calculatedItemsTotal,      // Subtotal
                service_charge: calculatedServiceCharge,
                vat_amount: calculatedVatAmount,
                total_amount: calculatedTotalAmount,
                // Payment Info
                payment_method: payment_method || "Cash",
                amount_tendered: req.body.amount_tendered || 0,
                change_amount: change_amount || 0,
                // Items List (Passed back for convenience)
                items: items // We assume frontend still has the full item details, but sending back is safe
            }
        });

    } catch (error) {
        if (connection) await connection.rollback();
        console.error("CREATE POS ORDER ERROR:", error);
        if (error.message.startsWith("Not enough stock")) {
            return res.status(400).json({ message: error.message });
        }
        res.status(500).json({ message: "Failed to create order", error: error.message });
    } finally {
        if (connection) connection.release();
    }
};

// @desc    Create a new order (customer)
// @route   POST /api/orders
// @access  Private (Customer)
export const createOrder = async (req, res) => {
    const connection = await pool.getConnection();
    try {
        await connection.beginTransaction();

        const client_id = req.user.id; 
        const { items, order_type, delivery_location, table_id, room_id, instructions } = req.body;

        if (!items || items.length === 0) {
            throw new Error("Missing required order information.");
        }

        // --- Location Logic ---
        let finalLocation = "";
        let finalTableId = null;
        let finalRoomId = null;

        if (order_type === 'Dine-in' && table_id) {
            finalTableId = table_id;
            const [tables] = await connection.query("SELECT table_number FROM fb_tables WHERE table_id = ?", [table_id]);
            if (tables.length > 0) {
                finalLocation = `Table ${tables[0].table_number}`;
            } else {
                finalLocation = `Table (ID: ${table_id})`;
            }
        }
        else if (order_type === 'Room Dining' && room_id) {
             finalRoomId = room_id;
             const [rooms] = await connection.query("SELECT room_num FROM tbl_rooms WHERE room_id = ?", [finalRoomId]);
             if (rooms.length > 0) {
                 finalLocation = `Room ${rooms[0].room_num}`;
             }
             else {
                finalLocation = "Room (Unknown)";
             }
        }
        else if (delivery_location) {
            finalLocation = delivery_location;
        }

        // --- 1. Check for Active Order OR Create New ---
        let order_id;
        let previousTotalAmount = 0; // We only need to track the grand total now!

        // Check if the user already has an unpaid tab
        const [existingOrders] = await connection.query(
            "SELECT * FROM fb_new_orders WHERE client_id = ? AND payment_status = 'unpaid' LIMIT 1",
            [client_id]
        );

        if (existingOrders.length > 0) {
            order_id = existingOrders[0].order_id;
            previousTotalAmount = parseFloat(existingOrders[0].total_amount || 0);
        } else {
            // No active order. Create a brand new one in the NEW table.
            const orderSql = "INSERT INTO fb_new_orders (client_id, order_type, table_id, room_id, status, payment_status, total_amount) VALUES (?, ?, ?, ?, 'Open', 'unpaid', 0)";
            const [orderResult] = await connection.query(orderSql, [client_id, order_type, finalTableId, finalRoomId]);
            order_id = orderResult.insertId;

            if (finalTableId) {
                await connection.query("UPDATE fb_tables SET status = 'Occupied' WHERE table_id = ?", [finalTableId]);
            }
        }
        
        // --- 2. Insert Items & Calculate Totals ---
        let calculatedItemsTotal = 0;

        for (const item of items) {
            const [rows] = await connection.query(
                `SELECT 
                    mi.price, 
                    p.discount_percentage, 
                    p.start_date, 
                    p.end_date, 
                    p.is_active 
                 FROM fb_menu_items mi
                 LEFT JOIN fb_promotions p ON mi.promotion_id = p.promotion_id
                 WHERE mi.item_id = ?`, 
                [item.item_id]
            );
            const dbItem = rows[0];
            let actualPrice = parseFloat(dbItem.price); 

            if (dbItem.discount_percentage && dbItem.is_active) {
                const today = new Date();
                today.setHours(0, 0, 0, 0);
                
                const startDate = new Date(dbItem.start_date);
                const endDate = new Date(dbItem.end_date);
                
                if (today >= startDate && today <= endDate) { 
                    const discount = parseFloat(dbItem.discount_percentage) / 100;
                    actualPrice = actualPrice * (1 - discount); 
                }
            }
            
            const subtotal = actualPrice * item.quantity;
            calculatedItemsTotal += subtotal; // Keep the math for later
            
            const itemInstructions = item.instructions || instructions || '';
            
            // Insert into the NEW details table
            const detailSql = "INSERT INTO fb_new_order_details (order_id, item_id, quantity, price_on_purchase, instructions, item_status) VALUES (?, ?, ?, ?, ?, 'pending')";
            await connection.query(detailSql, [order_id, item.item_id, item.quantity, actualPrice, itemInstructions]);
        }

        // Calculate the math for the new items
        const calculatedServiceCharge = calculatedItemsTotal * SERVICE_RATE;
        const calculatedVatAmount = (calculatedItemsTotal + calculatedServiceCharge) * VAT_RATE; 
        const calculatedTotalAmount = calculatedItemsTotal + calculatedServiceCharge + calculatedVatAmount;

        // Add the cost of these new items to their running tab
        const finalTotalAmount = previousTotalAmount + calculatedTotalAmount;

        // Update the NEW table with just the final total
        const updateSql = `UPDATE fb_new_orders SET total_amount = ? WHERE order_id = ?`;
        await connection.query(updateSql, [finalTotalAmount, order_id]);

        // Create Notification
        await createOrUpdateNotification(order_id, client_id, 'pending', connection, req);

        await connection.commit();

        // ================================================================
        // ✅ FAST PATH OPTIMIZATION (Fetch & Emit Full Data)
        // ================================================================
        
        // 1. Fetch the complete order with item names using the existing connection
        // We join 'fb_menu_items' here to get 'item_name' which the Frontend needs
        const [rows] = await connection.query(`
            SELECT 
                o.order_id, 
                o.order_date, 
                o.order_type, 
                o.status, 
                o.total_amount,
                COALESCE(c.first_name, o.guest_name) AS first_name,
                COALESCE(c.last_name, '') AS last_name,
                d.order_detail_id, 
                m.item_name, 
                d.quantity, 
                d.instructions
            FROM fb_new_orders o
            LEFT JOIN tbl_client_users c ON o.client_id = c.client_id
            LEFT JOIN fb_new_order_details d ON o.order_id = d.order_id
            LEFT JOIN fb_menu_items m ON d.item_id = m.item_id
            WHERE o.order_id = ?
        `, [order_id]);

        if (rows.length > 0) {
            // 2. Group the data (Order + Array of Items)
            const fullOrder = {
                order_id: rows[0].order_id,
                order_date: rows[0].order_date,
                order_type: rows[0].order_type,
                status: rows[0].status,
                total_amount: rows[0].total_amount,
                first_name: rows[0].first_name,
                last_name: rows[0].last_name,
                items: rows.map(r => ({
                    order_detail_id: r.order_detail_id,
                    item_name: r.item_name || 'Unknown Item',
                    quantity: r.quantity,
                    instructions: r.instructions
                }))
            };

            // 3. Emit the FULL object (Frontend won't need to fetch anything extra!)
            emitOrderUpdate(req, 'new-order', fullOrder);
        }

        // --- Table Status Update (Optional) ---
        if (finalTableId) {
            const io = req.app.get('io');
            if (io) {
                io.emit('table-update', {
                    table_id: parseInt(finalTableId),
                    status: 'Occupied'
                });
            }
        }

        res.status(201).json({
            order_id,
            total_amount: calculatedTotalAmount,
            message: "Order created successfully"
        });

    } catch (error) {
        await connection.rollback();
        console.error("CREATE ORDER ERROR:", error);
        res.status(500).json({ message: "Failed to create order", error: error.message });
    } finally {
        connection.release();
    }
};

// @desc    Get all orders
// @route   GET /api/orders
// @access  Private
export const getOrders = async (req, res) => {
    try {
        const sql = `
            SELECT 
                o.order_id, 
                o.order_date, 
                o.order_type, 
                CASE 
                    WHEN o.order_type = 'Room Dining' AND tr.room_num IS NOT NULL THEN CONCAT('Room ', tr.room_num)
                    WHEN o.order_type = 'Dine-In' AND ft.table_number IS NOT NULL THEN CONCAT('Table ', ft.table_number)
                    ELSE 'Unknown Location' 
                END AS delivery_location,
                o.status,
                o.payment_status,
                o.total_amount,
                COALESCE(c.first_name, o.guest_name) AS first_name,
                COALESCE(c.last_name, '') AS last_name
            FROM fb_new_orders o
            LEFT JOIN tbl_client_users c ON o.client_id = c.client_id
            LEFT JOIN tbl_rooms tr ON o.room_id = tr.room_id
            LEFT JOIN fb_tables ft ON o.table_id = ft.table_id
            ORDER BY o.order_date DESC
        `;

        const [orders] = await pool.query(sql);
        res.json(orders);
    } catch (error) {
        console.error("Error fetching orders:", error);
        res.status(500).json({ message: "Error fetching orders", error: error.message });
    }
};

// @desc    Get single order by ID
// @route   GET /api/orders/:id
// @access  Private
export const getOrderById = async (req, res) => {
    try {
        const { id } = req.params;

        // 1. Fetch Main Order
        const [orders] = await pool.query(
            `SELECT 
                o.*, 
                CASE 
                    WHEN o.order_type = 'Room Dining' AND tr.room_num IS NOT NULL THEN CONCAT('Room ', tr.room_num)
                    WHEN o.order_type = 'Dine-In' AND ft.table_number IS NOT NULL THEN CONCAT('Table ', ft.table_number)
                    ELSE 'Unknown Location' 
                END AS delivery_location,
                COALESCE(c.first_name, o.guest_name) AS first_name,
                COALESCE(c.last_name, '') AS last_name
            FROM fb_new_orders o
            LEFT JOIN tbl_client_users c ON o.client_id = c.client_id
            LEFT JOIN tbl_rooms tr ON o.room_id = tr.room_id
            LEFT JOIN fb_tables ft ON o.table_id = ft.table_id
            WHERE o.order_id = ?`,
            [id]
        );

        if (orders.length === 0) {
            return res.status(404).json({ message: "Order not found" });
        }
        
        const order = orders[0];

        // 2. Fetch Items & Calculate Subtotals on the fly!
        const [items] = await pool.query(
            `SELECT 
                mi.item_name, 
                od.quantity, 
                od.price_on_purchase AS price,
                mi.price AS original_price, 
                (od.quantity * od.price_on_purchase) AS subtotal, 
                (od.quantity * mi.price) AS original_subtotal,
                od.instructions,
                od.order_detail_id,
                od.item_status
            FROM fb_new_order_details od 
            JOIN fb_menu_items mi ON od.item_id = mi.item_id 
            WHERE od.order_id = ? AND od.item_status != 'cancelled'`, // Ignore voided items on the receipt
            [id]
        );

        // 3. Reconstruct the Math for the Receipt
        // calculatedItemsTotal is what they actually bought (Promo price)
        const calculatedItemsTotal = items.reduce((sum, item) => sum + parseFloat(item.subtotal), 0);
        // originalItemsTotal is the raw menu price (Needed for Senior Discount Law)
        const originalItemsTotal = items.reduce((sum, item) => sum + parseFloat(item.original_subtotal), 0);

        const calculatedServiceCharge = calculatedItemsTotal * SERVICE_RATE;
        const calculatedVatAmount = (calculatedItemsTotal + calculatedServiceCharge) * VAT_RATE;
        
        // 4. Fetch Payment Info
        const [payments] = await pool.query("SELECT * FROM fb_new_payments WHERE order_id = ?", [id]);
        const payment = payments[0] || {};

        res.json({
            order_id: order.order_id,
            order_date: order.order_date,
            order_type: order.order_type,
            delivery_location: order.delivery_location,
            first_name: order.first_name, 
            last_name: order.last_name,
            items_total: calculatedItemsTotal,             // Dynamic
            original_items_total: originalItemsTotal, 
            service_charge_amount: calculatedServiceCharge, // Dynamic
            vat_amount: calculatedVatAmount,               // Dynamic
            total_price: order.total_amount,
            status: order.status,
            items,
            payment_method: payment.payment_method || "Pending",
            payment_status: order.payment_status,
        });

    } catch (error) {
        console.error("Error fetching order details:", error);
        res.status(500).json({ message: "Error fetching order details", error: error.message });
    }
};

// @desc    Update any order status
// @route   PUT /api/orders/:id/status
// @access  Private (Staff)
export const updateOrderStatus = async (req, res) => {
    const { id } = req.params;
    const { status } = req.body; 
    const connection = await pool.getConnection();
    
    const [empRows] = await pool.query("SELECT employee_id FROM employees WHERE user_id = ?", [req.user.id]);
    if (empRows.length === 0) {
         connection.release();
         return res.status(403).json({ message: "Staff profile not found." });
    }
    const employee_id = empRows[0].employee_id;
    const newStatus = status.toLowerCase();

    const validStatuses = ['pending', 'preparing', 'ready', 'served', 'cancelled'];
    if (!validStatuses.includes(newStatus)) {
        // BUG FIX #6: Release connection before returning
        // WHY: Prevents connection leak when validation fails
        // HOW: Release connection in all early return paths
        connection.release();
        return res.status(400).json({ message: `Invalid status: ${status}` });
    }

    try {
        await connection.beginTransaction();

        const [orders] = await connection.query("SELECT status, client_id FROM fb_new_orders WHERE order_id = ? FOR UPDATE", [id]);
        if (orders.length === 0) {
            await connection.rollback();
            return res.status(404).json({ message: "Order not found" });
        }
        
        const currentStatus = orders[0].status;
        const client_id = orders[0].client_id;

        if (currentStatus === newStatus) {
            await connection.rollback();
            return res.status(400).json({ message: `Order is already ${newStatus}` });
        }

        // BUSINESS LOGIC: Stock management based on status transitions
        if (newStatus === 'preparing' && currentStatus === 'pending') {
            console.log(`Deducting stock for order ${id}...`);
            const [details] = await connection.query("SELECT item_id, quantity FROM fb_new_order_details WHERE order_id = ?", [id]);
            
            await validateStock(details, connection);
            await adjustStock(details, 'deduct', connection);
            await logOrderStockChange(id, details, 'ORDER_DEDUCT', connection);
            console.log(`Ingredient stock deducted and logged for order ${id}`);

        } else if (newStatus === 'cancelled') {
            // BUG FIX #7: Only restore stock if order was preparing/ready AND not paid
            // WHY: Prevents incorrect stock restoration for already-paid orders
            // HOW: Check both status and payment status before restoring stock
            if (currentStatus === 'preparing' || currentStatus === 'ready') {
                const [payments] = await connection.query(
                    "SELECT * FROM fb_new_payments WHERE order_id = ? AND payment_status = 'paid'", 
                    [id]
                );

                if (payments.length > 0) {
                    console.warn(`Order ${id} was already paid. Stock NOT restored (requires manual inventory adjustment).`);
                } else {
                    console.log(`Restoring ingredient stock for cancelled unpaid order: ${id}`);
                    const [details] = await connection.query("SELECT item_id, quantity FROM fb_new_order_details WHERE order_id = ?", [id]);
                    
                    await adjustStock(details, 'restore', connection);
                    await logOrderStockChange(id, details, 'ORDER_RESTORE', connection);
                }
            }
        }

        // 1. Fetch the items we are about to cancel (we need their price!)
        const [cancelDetails] = await connection.query(
            "SELECT quantity, price_on_purchase FROM fb_new_order_details WHERE order_id = ? AND item_status != 'served' AND item_status != 'cancelled'", 
            [id]
        );

        // 2. Calculate the exact grand total of these cancelled items
        let voidedSubtotal = 0;
        for (const item of cancelDetails) {
            voidedSubtotal += (item.quantity * item.price_on_purchase);
        }
        const voidedServiceCharge = voidedSubtotal * SERVICE_RATE;
        const voidedVatAmount = (voidedSubtotal + voidedServiceCharge) * VAT_RATE;
        const voidedGrandTotal = voidedSubtotal + voidedServiceCharge + voidedVatAmount;

        // 3. Deduct this amount from the main order's total_amount
        await connection.query(
            "UPDATE fb_new_orders SET total_amount = GREATEST(0, total_amount - ?) WHERE order_id = ?",
            [voidedGrandTotal, id]
        );

        // Update the order status
       await connection.query(
        "UPDATE fb_new_orders SET status = ? WHERE order_id = ?",
        [newStatus, id]
        );

        if (result.affectedRows === 0) {
            throw new Error("No active items found to update");
        }

        if (result.affectedRows === 0) {
            throw new Error("Order not found or status unchanged");
        }

        // Create/Update the notification
        await createOrUpdateNotification(id, client_id, newStatus, connection, req);

        await connection.commit();

        // ✅ NEW: Emit status update to all clients
        emitOrderUpdate(req, 'order-status-updated', {
            order_id: parseInt(id),
            status: newStatus,
            client_id,
            timestamp: new Date()
        });

        res.json({ message: `Order status updated to ${newStatus}` });

    } catch (error) {
        await connection.rollback();
        if (error.message.startsWith("Not enough stock")) {
            return res.status(400).json({ message: error.message });
        }
        console.error("Error updating order status:", error);
        res.status(500).json({ message: "Failed to update order status", error: error.message });
    } finally {
        connection.release();
    }
};

// @desc    Get active kitchen orders (pending/preparing/ready)
// @route   GET /api/orders/kitchen
// @access  Private (Staff)
export const getKitchenOrders = async (req, res) => {
    try {
        const sql = `
            SELECT 
                o.order_id, 
                o.order_date, 
                o.order_type, 
                CASE 
                    WHEN o.order_type = 'Room Dining' AND tr.room_num IS NOT NULL THEN CONCAT('Room ', tr.room_num)
                    WHEN o.order_type = 'Dine-In' AND ft.table_number IS NOT NULL THEN CONCAT('Table ', ft.table_number)
                    ELSE 'Unknown Location' 
                END AS delivery_location,
                o.status, 
                o.total_amount,
                COALESCE(c.first_name, o.guest_name) AS first_name,
                COALESCE(c.last_name, '') AS last_name,
                d.order_detail_id,       
                m.item_name,             
                d.quantity, 
                d.instructions,
                d.item_status
            FROM fb_new_orders o
            LEFT JOIN tbl_client_users c ON o.client_id = c.client_id
            JOIN fb_new_order_details d ON o.order_id = d.order_id 
            LEFT JOIN fb_menu_items m ON d.item_id = m.item_id
            LEFT JOIN tbl_rooms tr ON o.room_id = tr.room_id
            LEFT JOIN fb_tables ft ON o.table_id = ft.table_id
            WHERE d.item_status IN ('pending', 'preparing', 'ready')
            ORDER BY o.order_date ASC
        `;
        
        const [rows] = await pool.query(sql);

        // (Keep the rest of your mapping logic exactly the same...)
        const ordersMap = new Map();
        
        rows.forEach(row => {
            if (!ordersMap.has(row.order_id)) {
                ordersMap.set(row.order_id, {
                    order_id: row.order_id,
                    order_date: row.order_date,
                    order_type: row.order_type,
                    delivery_location: row.delivery_location, 
                    status: row.status,
                    total_amount: row.total_amount,
                    first_name: row.first_name,
                    last_name: row.last_name,
                    items: [] 
                });
            }
            
            if (row.order_detail_id) {
                ordersMap.get(row.order_id).items.push({
                    order_detail_id: row.order_detail_id,
                    item_name: row.item_name || 'Unknown Item',
                    quantity: row.quantity,
                    instructions: row.instructions,
                    item_status: row.item_status 
                });
            }
        });

        res.json(Array.from(ordersMap.values()));

    } catch (error) {
        console.error("Error fetching kitchen orders:", error);
        res.status(500).json({ message: "Error fetching kitchen orders", error: error.message });
    }
};

// @desc    Get served AND cancelled orders (Archived)
// @route   GET /api/orders/served
// @access  Private (Staff)
export const getServedOrders = async (req, res) => {
    try {
        const { startDate, endDate } = req.query;

        // 1. Updated Query: Corrected 'order_detail_id' and added 'fb_menu_items' join
        let sql = `
            SELECT 
                o.order_id, 
                o.order_date, 
                o.status,
                o.order_type, 
                CASE 
                    WHEN o.order_type = 'Room Dining' AND tr.room_num IS NOT NULL THEN CONCAT('Room ', tr.room_num)
                    WHEN o.order_type = 'Dine-In' AND ft.table_number IS NOT NULL THEN CONCAT('Table ', ft.table_number)
                    ELSE 'Unknown Location' 
                END AS delivery_location,
                o.total_amount,
                COALESCE(c.first_name, o.guest_name) AS first_name,
                COALESCE(c.last_name, '') AS last_name,
                d.order_detail_id,       
                m.item_name,             
                d.quantity, 
                d.instructions,
                d.item_status
            FROM fb_new_orders o
            LEFT JOIN tbl_client_users c ON o.client_id = c.client_id
            JOIN fb_new_order_details d ON o.order_id = d.order_id 
            LEFT JOIN fb_menu_items m ON d.item_id = m.item_id  
            LEFT JOIN tbl_rooms tr ON o.room_id = tr.room_id
            LEFT JOIN fb_tables ft ON o.table_id = ft.table_id
            WHERE d.item_status IN ('served', 'cancelled') 
               OR o.status IN ('Settled', 'cancelled')
        `;

        const params = [];

        // 2. Apply Date Filter
        if (startDate && endDate) {
            sql += ` AND DATE(o.order_date) BETWEEN ? AND ?`;
            params.push(startDate, endDate);
        }

        sql += ` ORDER BY o.order_date DESC`;

        const [rows] = await pool.query(sql, params);

        // 3. Grouping Logic (Preserves your original Data Flow)
        const ordersMap = new Map();

        rows.forEach(row => {
            if (!ordersMap.has(row.order_id)) {
                ordersMap.set(row.order_id, {
                    // Copy all main order fields
                    order_id: row.order_id,
                    order_date: row.order_date,
                    status: row.status,
                    order_type: row.order_type,
                    delivery_location: row.delivery_location,
                    total_amount: row.total_amount, 
                    first_name: row.first_name,
                    last_name: row.last_name,
                    // Initialize empty items array
                    items: [] 
                });
            }

            // Only push if there is actually an item (handle empty orders)
            if (row.order_detail_id) {
                ordersMap.get(row.order_id).items.push({
                    detail_id: row.order_detail_id, 
                    item_name: row.item_name || 'Unknown Item', // Fallback if name missing
                    quantity: row.quantity,
                    instructions: row.instructions,
                    item_status: row.item_status
                });
            }
        });

        // Convert Map back to Array
        const orders = Array.from(ordersMap.values());

        res.json(orders);
    } catch (error) {
        console.error("Error fetching served orders:", error);
        res.status(500).json({ message: "Error fetching served orders", error: error.message });
    }
};

const createOrUpdateNotification = async (order_id, client_id, status, connection, req) => {
    if (!client_id) {
        return;
    }

    try {
        const deleteSql = `
            DELETE n
            FROM fb_notifications n
            JOIN fb_new_orders o ON n.order_id = o.order_id
            WHERE n.order_id = ? AND (o.status = 'served' OR n.order_id = ?) 
        `;

        await (connection || pool).query(deleteSql, [order_id, order_id]);

        let title = `Order #${order_id} Updated!`;
        let message = `Your order #${order_id} is now ${status}.`;

        switch (status) {
            case 'pending':
                title = 'Order Placed!';
                message = `Your order #${order_id} is now pending.`;
                break;
            case 'preparing':
                title = 'Order Preparing!';
                message = `Your order #${order_id} is now being prepared.`;
                break;
            case 'ready':
                title = 'Order Ready!';
                message = `Your order #${order_id} is ready for pickup/delivery!`;
                break;
            case 'served':
                title = 'Order On Its Way!';
                message = `Your order #${order_id} is on its way for delivery!`;
                break;
            case 'cancelled':
                title = 'Order Cancelled';
                message = `Your order #${order_id} has been cancelled.`;
                break;
        }

        const insertSql = `
            INSERT INTO fb_notifications (client_id, order_id, title, message, is_read)
            VALUES (?, ?, ?, ?, 0)
        `;
        await (connection || pool).query(insertSql, [client_id, order_id, title, message]);

        // ✅ NEW: Emit notification via socket (if req is passed)
        if (req) {
            emitOrderUpdate(req, 'new-notification', {
                client_id,
                order_id,
                title,
                message,
                status,
                is_read: false,
                timestamp: new Date()
            });
        }

    } catch (error) {
        console.error(`Failed to create notification for order ${order_id}:`, error.message);
    }
};

// @desc    Get logged-in user's orders with Rating Status
// @route   GET /api/orders/my-orders
// @access  Private
export const getMyOrders = async (req, res) => {
    try {
        // Validate User
        if (!req.user || !req.user.id) {
            return res.status(401).json({ message: "User not authenticated" });
        }

        const client_id = req.user.id; 

        // 1. Fetch Orders
        const [orders] = await pool.query(
            `SELECT * FROM fb_new_orders 
             WHERE client_id = ? 
             ORDER BY order_date DESC`, 
            [client_id]
        );

        if (orders.length === 0) {
            return res.json([]);
        }

        // 2. Fetch Items & Check Ratings
        const ordersWithItems = await Promise.all(orders.map(async (order) => {
            // Get order details
            const [items] = await pool.query(`
                SELECT * FROM fb_new_order_details WHERE order_id = ?
            `, [order.order_id]);

            // Get Item Name AND Rating Status
            const itemsWithDetails = await Promise.all(items.map(async (item) => {
                 // ✅ MODIFIED QUERY: Fetch Name + Rating in one go
                 // We LEFT JOIN with the ratings table using client_id and item_id
                 const [info] = await pool.query(`
                    SELECT mi.item_name, r.rating_value 
                    FROM fb_menu_items mi
                    LEFT JOIN fb_food_ratings r 
                        ON mi.item_id = r.item_id AND r.client_id = ?
                    WHERE mi.item_id = ?
                 `, [client_id, item.item_id]);

                 return {
                    ...item,
                    item_name: info.length > 0 ? info[0].item_name : 'Unknown Item',
                    // ✅ ADDED: If rating_value exists, send it. Otherwise null.
                    my_rating: (info.length > 0 && info[0].rating_value) ? info[0].rating_value : null
                 };
            }));

            return { ...order, items: itemsWithDetails };
        }));

        res.json(ordersWithItems);

    } catch (error) {
        console.error("Backend Error:", error);
        res.status(500).json({ message: "Server Error" });
    }
};

// @desc    Toggle individual item status (Checkbox memory)
// @route   PUT /api/orders/item/:detailId/toggle
// @access  Private (Staff)
export const toggleItemCheckbox = async (req, res) => {
    const { detailId } = req.params;
    const { isChecked } = req.body; 
    const connection = await pool.getConnection();

    try {
        // If the box is checked, mark the item as 'ready'. If unchecked, revert to 'pending'
        const newStatus = isChecked ? 'ready' : 'pending';
        await connection.query(
            "UPDATE fb_new_order_details SET item_status = ? WHERE order_detail_id = ?",
            [newStatus, detailId]
        );

        res.json({ success: true, message: `Item ${detailId} marked as ${newStatus}` });
    } catch (error) {
        console.error("Error toggling item checkbox:", error);
        res.status(500).json({ message: "Failed to update item status", error: error.message });
    } finally {
        connection.release();
    }
};

// @desc    Get active unpaid tabs for the Cashier/POS
// @route   GET /api/orders/unpaid
// @access  Private (Staff/Cashier)
export const getUnpaidTabs = async (req, res) => {
    try {
        const sql = `
            SELECT 
                o.order_id, 
                o.room_id,
                o.order_date, 
                o.order_type, 
                o.total_amount,
                COALESCE(c.first_name, o.guest_name) AS first_name,
                COALESCE(c.last_name, '') AS last_name,
                tr.room_num,
                ft.table_number
            FROM fb_new_orders o
            LEFT JOIN tbl_client_users c ON o.client_id = c.client_id
            LEFT JOIN tbl_rooms tr ON o.room_id = tr.room_id
            LEFT JOIN fb_tables ft ON o.table_id = ft.table_id
            WHERE o.payment_status = 'unpaid' 
            AND o.status != 'cancelled'
            ORDER BY o.order_date ASC
        `;
        
        const [rows] = await pool.query(sql);

        // Format the location so the frontend doesn't have to do the math
        const formattedTabs = rows.map(tab => {
            let location = tab.order_type; // Fallback (e.g., "Take-out")
            if (tab.room_num) location = `Room ${tab.room_num}`;
            if (tab.table_number) location = `Table ${tab.table_number}`;

            return {
                ...tab,
                formatted_location: location
            };
        });

        res.json(formattedTabs);
    } catch (error) {
        console.error("Error fetching unpaid tabs:", error);
        res.status(500).json({ message: "Error fetching unpaid tabs", error: error.message });
    }
};

// @desc    Settle a bill and close the tab
// @route   POST /api/orders/:id/settle
// @access  Private (Staff/Cashier)
export const settleBill = async (req, res) => {
    const { id } = req.params;
    console.log("DEBUG: Backend received body:", req.body);
    
    // 1.Accept the new 'appliedDiscounts' array from React
    const { payment_method, amount, change_amount, appliedDiscounts, room_id } = req.body;
    const connection = await pool.getConnection();

    try {
        await connection.beginTransaction();

if (payment_method === 'Charge to Deposit') {
    const { room_id } = req.body; 
    if (!room_id) {
        throw new Error("This order is not linked to a Room. Only Room Dining or checked-in guests can use Deposit Charge.");
    }

    // 2. Secret Translation: Find the ACTIVE reservation for this room
    const [resRows] = await connection.query(`
        SELECT r.reservation_id 
        FROM tbl_reservations r
        JOIN tbl_reservation_rooms br ON r.reservation_id = br.reservation_id
        WHERE br.room_id = ? 
        AND CURDATE() BETWEEN r.check_in AND r.check_out
        AND r.status = 'approved' 
        LIMIT 1
    `, [room_id]);

    if (resRows.length === 0) {
        throw new Error("No active reservation found for this room today.");
    }

const finalReservationId = resRows[0].reservation_id;

   // 1. Fetch their current deposit balance. (If the row exists, the money is there!)
    const [depositRows] = await connection.query(
        "SELECT remaining_deposit, amount_deducted FROM tbl_deposit WHERE reservation_id = ? LIMIT 1",
        [finalReservationId]
    );

    if (depositRows.length === 0) {
        throw new Error("No deposit record found for this guest's reservation.");
    }

    const remainingDeposit = parseFloat(depositRows[0].remaining_deposit);

    // 2. The Overdraft Check
    if (remainingDeposit < amount) {
        throw new Error(`Insufficient funds. The bill is ₱${amount.toFixed(2)}, but their remaining deposit is only ₱${remainingDeposit.toFixed(2)}.`);
    }

    // --- EXISTING: BUILD THE PAYLOAD STRING ---
    const [items] = await connection.query(`
        SELECT od.quantity, mi.item_name
        FROM fb_new_order_details od
        JOIN fb_menu_items mi ON od.item_id = mi.item_id
        WHERE od.order_id = ?
    `, [id]);

    const itemStrings = items.map(item => `${item.quantity}x ${item.item_name}`).join(', ');
    const referenceNote = `F&B Order #${id}: ${itemStrings}`;

    // --- NEW: UPDATE THE DEPOSIT MATH ---
    // 3. Deduct from remaining_deposit, and add to amount_deducted
    await connection.query(`
        UPDATE tbl_deposit 
        SET remaining_deposit = remaining_deposit - ?, 
            amount_deducted = amount_deducted + ? 
        WHERE reservation_id = ?
    `, [amount, amount, finalReservationId]);

    // --- EXISTING: LOG THE RECEIPT ---
    // 4. Insert into the CRS Ledger history
    await connection.query(`
        INSERT INTO tbl_deposit_logs 
        (reservation_id, transaction_type, amount, reference_note, created_by) 
        VALUES (?, 'DEDUCTION', ?, ?, 'F&B System')
    `, [finalReservationId, amount, referenceNote]);
}

        const finalPaymentStatus = payment_method === 'Room Charge' ? 'charged_to_room' : 'paid';

       // 2. Clean UPDATE query (Old discount columns are completely gone!)
        const [updateResult] = await connection.query(
            "UPDATE fb_new_orders SET payment_status = ?, status = 'Settled' WHERE order_id = ?",
            [finalPaymentStatus, id]
        );

        if (updateResult.affectedRows === 0) {
            throw new Error("Order not found or already paid.");
        }

        // 3. Loop through the array and insert each ID into the new table
        if (appliedDiscounts && appliedDiscounts.length > 0) {
            for (const discount of appliedDiscounts) {
                await connection.query(
                    "INSERT INTO fb_order_discounts (order_id, discount_type, discount_id) VALUES (?, ?, ?)",
                    [id, discount.type, discount.id_number] 
                );
            }
        }

        // 4. Record the payment in our clean V2 payments table
        await connection.query(
            "INSERT INTO fb_new_payments (order_id, payment_method, amount, change_amount) VALUES (?, ?, ?, ?)",
            [id, payment_method, amount, change_amount || 0] 
        );

        // 5. Free up the dine-in table!
        await connection.query(
            `UPDATE fb_tables SET status = 'Available' WHERE table_id = (SELECT table_id FROM fb_new_orders WHERE order_id = ?)`,
            [id]
        );

        await connection.commit();
        res.json({ success: true, message: "Bill settled successfully." });

    } catch (error) {
        await connection.rollback();
        console.error("Error settling bill:", error);
        res.status(500).json({ message: "Failed to settle bill", error: error.message });
    } finally {
        connection.release();
    }
};

// @desc    Add items to an existing order (Tab)
// @route   POST /api/orders/:id/items
// @access  Private (Staff)
export const addItemsToOrder = async (req, res) => {
    const { id } = req.params;
    const { items } = req.body;
    const connection = await pool.getConnection();

    try {
        await connection.beginTransaction();

        // 1. Validate and deduct stock for the NEW items
        await validateStock(items, connection);
        await adjustStock(items, 'deduct', connection);
        await logOrderStockChange(id, items, 'ORDER_DEDUCT', connection);

        // 2. Fetch the current total of the existing tab
        const [existingOrders] = await connection.query(
            "SELECT total_amount FROM fb_new_orders WHERE order_id = ?",
            [id]
        );
        if (existingOrders.length === 0) {
            throw new Error("Order not found");
        }

        const currentTotalAmount = parseFloat(existingOrders[0].total_amount || 0);
        let calculatedItemsTotal = 0;

        // 3. Loop through new items, calculate promos/prices, and insert them
        for (const item of items) {
            const [rows] = await connection.query(
                `SELECT mi.price, p.discount_percentage, p.start_date, p.end_date, p.is_active 
                 FROM fb_menu_items mi
                 LEFT JOIN fb_promotions p ON mi.promotion_id = p.promotion_id
                 WHERE mi.item_id = ?`,
                [item.item_id]
            );

            if (rows.length === 0) continue;

            const dbItem = rows[0];
            let actualPrice = parseFloat(dbItem.price);

            // Apply promo logic if active
            if (dbItem.discount_percentage && dbItem.is_active) {
                const today = new Date();
                today.setHours(0, 0, 0, 0);
                const startDate = new Date(dbItem.start_date);
                const endDate = new Date(dbItem.end_date);
                if (today >= startDate && today <= endDate) {
                    const discount = parseFloat(dbItem.discount_percentage) / 100;
                    actualPrice = actualPrice * (1 - discount);
                }
            }

            const subtotal = actualPrice * item.quantity;
            calculatedItemsTotal += subtotal;

            const itemInstructions = item.instructions || '';

            // Insert new details. Notice we set item_status to 'pending' so the kitchen sees it!
            const detailSql = "INSERT INTO fb_new_order_details (order_id, item_id, quantity, price_on_purchase, instructions, item_status) VALUES (?, ?, ?, ?, ?, 'pending')";
            await connection.query(detailSql, [id, item.item_id, item.quantity, actualPrice, itemInstructions]);
        }

        // 4. Calculate the additional taxes/fees for ONLY the new items
        const newServiceCharge = calculatedItemsTotal * SERVICE_RATE;
        const newVatAmount = (calculatedItemsTotal + newServiceCharge) * VAT_RATE;
        const newTotalAmount = calculatedItemsTotal + newServiceCharge + newVatAmount;

        // 5. Add the new final cost to the old total
        const finalTotalAmount = currentTotalAmount + newTotalAmount;

        // 6. Update the main order receipt
        await connection.query(
            `UPDATE fb_new_orders SET total_amount = ? WHERE order_id = ?`,
            [finalTotalAmount, id]
        );

        await connection.commit();

        // 7. Ping the Kitchen Display System so they know new food was added!
        emitOrderUpdate(req, 'new-order', { order_id: id });

        res.status(200).json({ success: true, message: "Items successfully sent to kitchen!" });

    } catch (error) {
        await connection.rollback();
        console.error("ADD ITEMS ERROR:", error);
        if (error.message.startsWith("Not enough stock")) {
            return res.status(400).json({ message: error.message });
        }
        res.status(500).json({ message: "Failed to add items", error: error.message });
    } finally {
        connection.release();
    }
};

// @desc    Void a specific item from an active order
// @route   PUT /api/orders/item/:detailId/void
// @access  Private (Staff)
export const voidOrderItem = async (req, res) => {
    const { detailId } = req.params;
    const connection = await pool.getConnection();

    try {
        await connection.beginTransaction();

        // 1. Get the item details and the main order ID
        const [itemRows] = await connection.query(
            "SELECT order_id, item_id, quantity, price_on_purchase, item_status FROM fb_new_order_details WHERE order_detail_id = ?",
            [detailId]
        );
        if (itemRows.length === 0) {
            throw new Error("Item not found in this order.");
        }

        const item = itemRows[0];
        const order_id = item.order_id;

        // Prevent voiding items that are already served or cancelled
        if (item.item_status === 'served' || item.item_status === 'cancelled') {
            throw new Error(`Cannot void item because it is already ${item.item_status}.`);
        }

        // 2. Mark the specific item as cancelled
        await connection.query(
            "UPDATE fb_new_order_details SET item_status = 'cancelled' WHERE order_detail_id = ?",
            [detailId]
        );

        // 3. Restore the stock to inventory!
        await adjustStock([item], 'restore', connection);
        await logOrderStockChange(order_id, [item], 'VOID_RESTORE', connection);

        // 4. Fetch the current main order total
        const [orderRows] = await connection.query(
            "SELECT total_amount FROM fb_new_orders WHERE order_id = ?", 
            [order_id]
        );
        const currentTotalAmount = parseFloat(orderRows[0].total_amount || 0);

        // 5. Calculate exactly how much money to subtract
        const voidedSubtotal = item.quantity * item.price_on_purchase;
        const voidedServiceCharge = voidedSubtotal * SERVICE_RATE;
        const voidedVatAmount = (voidedSubtotal + voidedServiceCharge) * VAT_RATE;
        const voidedGrandTotal = voidedSubtotal + voidedServiceCharge + voidedVatAmount;

        // Ensure it doesn't drop below 0
        const newTotalAmount = Math.max(0, currentTotalAmount - voidedGrandTotal);

        // 6. Update the main order receipt
        await connection.query(
            `UPDATE fb_new_orders SET total_amount = ? WHERE order_id = ?`,
            [newTotalAmount, order_id]
        );

        await connection.commit();

        // 7. Tell the Kitchen Display System to remove it from their screen!
        emitOrderUpdate(req, 'order-status-updated', { order_id });

        res.json({ success: true, message: "Item voided and totals updated successfully." });

    } catch (error) {
        await connection.rollback();
        console.error("VOID ITEM ERROR:", error);
        res.status(500).json({ message: "Failed to void item", error: error.message });
    } finally {
        connection.release();
    }
};

// @desc    Cancel an entire order (Walkout/Full Void)
// @route   PUT /api/orders/:id/cancel
// @access  Private (Staff)
export const cancelEntireOrder = async (req, res) => {
    const { id } = req.params;
    const connection = await pool.getConnection();

    try {
        await connection.beginTransaction();

        // 1. Fetch the order to ensure it exists and get table/client info
        const [orders] = await connection.query(
            "SELECT status, table_id, client_id, payment_status FROM fb_new_orders WHERE order_id = ? FOR UPDATE", 
            [id]
        );
        
        if (orders.length === 0) throw new Error("Order not found");
        if (orders[0].payment_status === 'paid') throw new Error("Cannot cancel an order that is already paid.");
        if (orders[0].status === 'cancelled') throw new Error("Order is already cancelled.");

        const { table_id, client_id } = orders[0];

        // 2. The Item Sweep: Find all active items that need stock restored
        const [activeItems] = await connection.query(
            "SELECT item_id, quantity FROM fb_new_order_details WHERE order_id = ? AND item_status NOT IN ('served', 'cancelled')",
            [id]
        );

        // 3. The Inventory Rollback: Restore Stock
        if (activeItems.length > 0) {
            await adjustStock(activeItems, 'restore', connection);
            await logOrderStockChange(id, activeItems, 'FULL_ORDER_CANCEL_RESTORE', connection);
        }

        // 4. Mark every single item as cancelled
        await connection.query(
            "UPDATE fb_new_order_details SET item_status = 'cancelled' WHERE order_id = ?",
            [id]
        );

        // 5. The Financial Wipe & Parent Status Update
        await connection.query(
            "UPDATE fb_new_orders SET total_amount = 0, status = 'cancelled' WHERE order_id = ?",
            [id]
        );

        // 6. The Table Release: Free up the table for the next guest
        if (table_id) {
            await connection.query(
                "UPDATE fb_tables SET status = 'Available' WHERE table_id = ?",
                [table_id]
            );
            
            // Ping sockets to update the table map instantly
            const io = req.app.get('io');
            if (io) {
                io.emit('table-update', { table_id: parseInt(table_id), status: 'Available' });
            }
        }

        // 7. Notification for the customer (if applicable)
        await createOrUpdateNotification(id, client_id, 'cancelled', connection, req);

        await connection.commit();

        // 8. Tell all screens (Kitchen & Cashier) to wipe this order away
        emitOrderUpdate(req, 'order-status-updated', {
            order_id: parseInt(id),
            status: 'cancelled',
            client_id,
            timestamp: new Date()
        });

        res.json({ success: true, message: "Entire order successfully cancelled and stock restored." });

    } catch (error) {
        await connection.rollback();
        console.error("CANCEL ENTIRE ORDER ERROR:", error);
        res.status(500).json({ message: "Failed to cancel entire order", error: error.message });
    } finally {
        connection.release();
    }
};
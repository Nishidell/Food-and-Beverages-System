import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom'; // ✅ For redirecting after order
import { X, Trash2, Minus, Plus, MessageSquare } from 'lucide-react';
import apiClient from '../../../utils/apiClient';
import '../CustomerTheme.css';
import { useSocket } from '../../../context/SocketContext';
import { useCart } from '../../../context/CartContext'; // ✅ Use the Context
import { useAuth } from '../../../context/AuthContext'; // ✅ Use Auth
import toast from 'react-hot-toast';

const CartPanel = ({ isOpen, onClose }) => {
  // ✅ Global Cart Data
  const { cart, updateQuantity, removeFromCart, updateInstruction, clearCart } = useCart();
  const { user } = useAuth();
  const navigate = useNavigate();

  // Local State for Order Settings
  const [orderType, setOrderType] = useState('Dine-in');
  const [deliveryLocation, setDeliveryLocation] = useState('');
  const [isPlacingOrder, setIsPlacingOrder] = useState(false);

  // Location Data
  const [tables, setTables] = useState([]);
  const [rooms, setRooms] = useState([]);
  const [selectedTableId, setSelectedTableId] = useState('');
  const [selectedRoomId, setSelectedRoomId] = useState('');

  const { socket } = useSocket();

  // 1. Fetch Location Data
  useEffect(() => {
    const fetchData = async () => {
      try {
        const [tableRes, roomRes] = await Promise.all([
            apiClient('/tables'),
            apiClient('/rooms')
        ]);
        if (tableRes.ok) setTables(await tableRes.json());
        if (roomRes.ok) setRooms(await roomRes.json());
      } catch (error) {
        console.error("Failed to load location data", error);
      }
    };
    fetchData();
  }, []);

  // 2. Real-time Table Updates
  useEffect(() => {
    if (socket) {
        socket.on('table-update', (data) => {
            setTables(prevTables => prevTables.map(table => {
                if (table.table_id === parseInt(data.table_id)) {
                    return { ...table, status: data.status };
                }
                return table;
            }));

            if (data.status === 'Occupied' && parseInt(selectedTableId) === parseInt(data.table_id)) {
                 setSelectedTableId(''); 
                 setDeliveryLocation('');
            }
        });
    }
    return () => socket && socket.off('table-update');
  }, [socket, selectedTableId]);

  // 3. Reset location when switching Order Type
  useEffect(() => {
    setSelectedTableId('');
    setSelectedRoomId('');
    setDeliveryLocation('');
  }, [orderType]);

  const handleTableChange = (e) => {
    const tId = e.target.value;
    setSelectedTableId(tId);
    const table = tables.find(t => t.table_id.toString() === tId);
    setDeliveryLocation(table ? `Table ${table.table_number}` : ''); 
  };

  const handleRoomChange = (e) => {
    const rId = e.target.value;
    setSelectedRoomId(rId);
    const room = rooms.find(r => r.room_id.toString() === rId);
    setDeliveryLocation(room ? `Room ${room.room_num}` : '');
  };

  // ✅ 4. SELF-CONTAINED ORDER SUBMISSION
  const handlePlaceOrder = async () => {
    if (!user) {
        toast.error("Please login to place an order.");
        return;
    }
    
    setIsPlacingOrder(true);
    try {
        // Calculate Totals
        const subtotal = cart.reduce((total, item) => total + parseFloat(item.price) * item.quantity, 0);
        const serviceFee = subtotal * 0.10;
        const vat = (subtotal + serviceFee) * 0.12;
        const totalAmount = subtotal + serviceFee + vat;

        const payload = {
            order_type: orderType,
            delivery_location: deliveryLocation, // "Table 5" or "Room 101"
            payment_method: 'Cash', // Default for now
            total_amount: totalAmount,
            items: cart.map(item => ({
                item_id: item.item_id,
                quantity: item.quantity,
                price: item.price,
                instructions: item.instructions || ''
            }))
        };

        const response = await apiClient('/orders', {
            method: 'POST',
            body: JSON.stringify(payload)
        });

        if (!response.ok) throw new Error('Failed to place order');
        
        const data = await response.json();
        
        // Success Actions
        clearCart();
        onClose();
        toast.success('Order placed successfully!');
        navigate('/my-orders'); // Redirect to history
        
    } catch (error) {
        toast.error(error.message);
    } finally {
        setIsPlacingOrder(false);
    }
  };

  // Calculations
  const subtotal = cart.reduce((total, item) => total + parseFloat(item.price) * item.quantity, 0);
  const serviceAmount = subtotal * 0.10;
  const vatAmount = (subtotal + serviceAmount) * 0.12;
  const grandTotal = subtotal + serviceAmount + vatAmount;

  return (
    <>
      <div className={`cart-overlay ${isOpen ? '' : 'hidden'}`} onClick={onClose} />
      <div className={`cart-panel ${isOpen ? 'open' : ''}`}>
        
        {/* Header */}
        <div className="cart-header">
          <h2 className="cart-title">My Order</h2>
          <button onClick={onClose} className="cart-close-btn"><X size={24} /></button>
        </div>

        {/* Content */}
        <div className="cart-content">
          
          {/* Order Type */}
          <div className="order-type-container">
            {['Dine-in', 'Room Dining'].map(type => (
                <button
                    key={type}
                    onClick={() => setOrderType(type)}
                    className={`order-type-btn ${orderType === type ? 'active' : 'inactive'}`}
                >
                    {type}
                </button>
            ))}
          </div>

          {/* Location Select */}
          <div className="location-container">
            <label className="location-label">
              {orderType === 'Dine-in' ? 'Select Table' : 'Select Room'}
            </label>
            <div className="location-select-wrapper">
                {orderType === 'Dine-in' ? (
                    <select value={selectedTableId} onChange={handleTableChange} className="location-select">
                        <option value="">-- Choose a Table --</option>
                        {tables.map(table => (
                            <option 
                                key={table.table_id} 
                                value={table.table_id} 
                                disabled={table.status !== 'Available'}
                                className={table.status !== 'Available' ? 'text-gray-400 bg-gray-100' : ''}
                            >
                                Table {table.table_number} ({table.capacity} pax) {table.status !== 'Available' ? '- Occupied' : ''}
                            </option>
                        ))}
                    </select>
                ) : (
                    <select value={selectedRoomId} onChange={handleRoomChange} className="location-select">
                        <option value="">-- Choose a Room --</option>
                        {rooms.map(room => (
                            <option key={room.room_id} value={room.room_id}>
                                Room {room.room_num} ({room.status})
                            </option>
                        ))}
                    </select>
                )}
                <div className="location-arrow">
                    <svg className="w-4 h-4 fill-current" viewBox="0 0 20 20"><path d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"/></svg>
                </div>
            </div>
          </div>

          {/* Cart Items */}
          <div className="space-y-4">
            {cart.length === 0 ? (
              <div className="cart-empty-state"><p>Your cart is empty</p></div>
            ) : (
              cart.map((item) => {
                const itemTotal = parseFloat(item.price) * item.quantity;
                return (
                  <div key={item.item_id} className="cart-item">
                      <div className="cart-item-top">
                          <div className="cart-item-details w-full"> 
                              <div className="cart-item-header">
                                  <div>
                                      <h3 className="cart-item-name">{item.item_name}</h3>
                                      <p className="cart-item-price">₱{parseFloat(item.price).toFixed(2)} <span>/ea</span></p>
                                  </div>
                                  <div className="cart-item-total">₱{itemTotal.toFixed(2)}</div>
                              </div>
                              
                              <div className="cart-item-controls">
                                  <div className="qty-control">
                                      <button onClick={() => updateQuantity(item.item_id, item.quantity - 1)} className="qty-btn"><Minus size={14} strokeWidth={3} /></button>
                                      <span className="qty-display">{item.quantity}</span>
                                      <button onClick={() => updateQuantity(item.item_id, item.quantity + 1)} className="qty-btn"><Plus size={14} strokeWidth={3} /></button>
                                  </div>
                                  <button onClick={() => removeFromCart(item.item_id)} className="remove-btn"><Trash2 size={18} /></button>
                              </div>
                          </div>
                      </div>

                      <div className="instruction-wrapper">
                          <div className="instruction-icon"><MessageSquare size={14} /></div>
                          <input
                              type="text"
                              placeholder="Add notes (e.g. No onions)"
                              value={item.instructions || ''}
                              // ✅ Updates via Context
                              onChange={(e) => updateInstruction(item.item_id, e.target.value)}
                              className="instruction-input"
                          />
                      </div>
                  </div>
                );
              })
            )}
          </div>
        </div>

        {/* Footer */}
        <div className="cart-footer">
             <div className="space-y-2 mb-4">
                <div className="summary-row"><span>Subtotal</span><span className="font-medium">₱{subtotal.toFixed(2)}</span></div>
                <div className="summary-row"><span>Service Charge (10%)</span><span className="font-medium">₱{serviceAmount.toFixed(2)}</span></div>
                <div className="summary-row"><span>VAT (12%)</span><span className="font-medium">₱{vatAmount.toFixed(2)}</span></div>
                <div className="summary-row total"><span>Total</span><span>₱{grandTotal.toFixed(2)}</span></div>
             </div>
             
             <button
                onClick={handlePlaceOrder}
                disabled={
                    cart.length === 0 || 
                    (orderType === 'Dine-in' && !selectedTableId) || 
                    (orderType === 'Room Dining' && !selectedRoomId) ||
                    isPlacingOrder
                }
                className="place-order-btn"
              >
                {isPlacingOrder ? 'Processing...' : 'Place Order'}
              </button>
        </div>
      </div>
    </>
  );
};

export default CartPanel;
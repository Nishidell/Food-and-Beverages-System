import React, { useState, useEffect } from 'react';
import { X, Trash2, Minus, Plus, MessageSquare } from 'lucide-react';
import apiClient from '../../../utils/apiClient';

const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:21907/api';

const SERVER_URL = API_URL.split('/api')[0];

const CartPanel = ({
  cartItems = [],
  onUpdateQuantity,
  onPlaceOrder,
  isOpen,
  onClose,
  orderType,
  setOrderType,
  onUpdateItemInstruction, 
  onRemoveItem,
  deliveryLocation,
  setDeliveryLocation,
  isPlacingOrder
}) => {
  const [tables, setTables] = useState([]);
  const [rooms, setRooms] = useState([]);
  
  const [selectedTableId, setSelectedTableId] = useState('');
  const [selectedRoomId, setSelectedRoomId] = useState('');

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

  useEffect(() => {
    if (orderType === 'Dine-in') {
        setSelectedRoomId('');
        setDeliveryLocation('');
    } else if (orderType === 'Room Dining') {
        setSelectedTableId('');
        setDeliveryLocation('');
    }
  }, [orderType, setDeliveryLocation]);

  const handleTableChange = (e) => {
    const tId = e.target.value;
    setSelectedTableId(tId);
    setDeliveryLocation(tId); 
  };

  const handleRoomChange = (e) => {
    const rId = e.target.value;
    setSelectedRoomId(rId);
    setDeliveryLocation(rId);
  };

  const SERVICE_RATE = 0.10; 
  const VAT_RATE = 0.12;     
  const subtotal = cartItems.reduce((total, item) => total + parseFloat(item.price) * item.quantity, 0);
  const serviceAmount = subtotal * SERVICE_RATE;
  const vatAmount = (subtotal + serviceAmount) * VAT_RATE;
  const grandTotal = subtotal + serviceAmount + vatAmount;

  return (
    <>
      {/* Overlay */}
      <div
        className={`fixed inset-0 bg-black/60 z-40 transition-opacity duration-300 ${
          isOpen ? 'opacity-100' : 'opacity-0 pointer-events-none'
        }`}
        onClick={onClose}
      />

      {/* Slide-over Panel */}
      <div
        className={`fixed top-0 right-0 h-full w-full max-w-md bg-[#fff8f0] shadow-2xl z-50 transform transition-transform duration-300 ease-in-out flex flex-col ${
          isOpen ? 'translate-x-0' : 'translate-x-full'
        }`}
      >
        {/* --- Header --- */}
        <div className="px-6 py-5 border-b border-[#e5dccb] bg-[#fff8f0] flex justify-between items-center">
          <h2 className="text-xl font-bold text-[#3C2A21]">My Order</h2>
          <button onClick={onClose} className="p-2 hover:bg-gray-100 rounded-full text-gray-500 transition-colors">
            <X size={24} />
          </button>
        </div>

        {/* --- Scrollable Content --- */}
        <div className="flex-1 overflow-y-auto p-6">
          
          {/* Order Type Selector */}
          <div className="bg-[#eae0d5] p-1 rounded-lg flex mb-6">
            <button
              onClick={() => setOrderType('Dine-in')}
              className={`flex-1 py-2 text-sm font-bold rounded-md transition-all ${
                orderType === 'Dine-in' 
                ? 'bg-[#0B3D2E] text-white shadow-md' 
                : 'text-[#5c4a40] hover:bg-[#decbc0]'
              }`}
            >
              Dine-in
            </button>
            <button
              onClick={() => setOrderType('Room Dining')}
              className={`flex-1 py-2 text-sm font-bold rounded-md transition-all ${
                orderType === 'Room Dining' 
                ? 'bg-[#0B3D2E] text-white shadow-md' 
                : 'text-[#5c4a40] hover:bg-[#decbc0]'
              }`}
            >
              Room Dining
            </button>
          </div>

          {/* Location Dropdown */}
          <div className="mb-6">
            <label className="text-xs font-bold text-[#F9A825] uppercase tracking-wide mb-2 block">
              {orderType === 'Dine-in' ? 'Select Table' : 'Select Room'}
            </label>
            <div className="relative">
                {orderType === 'Dine-in' ? (
                    <select
                        value={selectedTableId}
                        onChange={handleTableChange}
                        className="w-full border border-[#d1c0b6] rounded-lg p-3 bg-white text-[#3C2A21] font-medium focus:ring-2 focus:ring-[#F9A825] focus:border-[#F9A825] outline-none appearance-none"
                    >
                        <option value="">-- Choose a Table --</option>
                        {tables.map(table => (
                            <option key={table.table_id} value={table.table_id} disabled={table.status !== 'Available'}>
                                Table {table.table_number} ({table.capacity} pax) {table.status !== 'Available' ? '- Occupied' : ''}
                            </option>
                        ))}
                    </select>
                ) : (
                    <select
                        value={selectedRoomId}
                        onChange={handleRoomChange}
                        className="w-full border border-[#d1c0b6] rounded-lg p-3 bg-white text-[#3C2A21] font-medium focus:ring-2 focus:ring-[#F9A825] focus:border-[#F9A825] outline-none appearance-none"
                    >
                        <option value="">-- Choose a Room --</option>
                        {rooms.map(room => (
                            <option key={room.room_id} value={room.room_id}>
                                Room {room.room_num} ({room.status})
                            </option>
                        ))}
                    </select>
                )}
                <div className="absolute inset-y-0 right-0 flex items-center px-3 pointer-events-none text-gray-500">
                    <svg className="w-4 h-4 fill-current" viewBox="0 0 20 20"><path d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"/></svg>
                </div>
            </div>
          </div>

          {/* Items List */}
          <div className="space-y-4">
            {cartItems.length === 0 ? (
              <div className="flex flex-col items-center justify-center py-10 text-gray-400">
                <p>Your cart is empty</p>
              </div>
            ) : (
              cartItems.map((item) => {
                const itemTotal = parseFloat(item.price) * item.quantity;

                // --- FIX: Construct Image URL Correctly ---
                let imageUrl = '/placeholder-food.png';
                if (item.image_url) {
                    const cleanPath = item.image_url.replace(/\\/g, '/');
                    if (cleanPath.startsWith('http')) {
                        imageUrl = cleanPath;
                    } else {
                        // Use the dynamic SERVER_URL instead of hardcoded localhost
                        const path = cleanPath.startsWith('/') ? cleanPath : `/${cleanPath}`;
                        imageUrl = `${SERVER_URL}${path}`;
                    }
                }
                // -------------------------------

                return (
                  <div key={item.item_id} className="bg-white p-4 rounded-xl shadow-sm border border-[#e5dccb] flex flex-col gap-3">
                      {/* Top Section: Image + Details + Total */}
                      <div className="flex gap-4">
                          {/* Image */}
                          <div className="w-20 h-20 flex-shrink-0 rounded-lg overflow-hidden bg-gray-100">
                              <img 
                                  src={imageUrl} 
                                  alt={item.item_name} 
                                  className="w-full h-full object-cover"
                                  onError={(e) => { e.target.src = '/placeholder-food.png'; }} 
                              />
                          </div>

                          {/* Details Column */}
                          <div className="flex-1 flex flex-col gap-2">
                              {/* Name/Price & Item Total Row */}
                              <div className="flex justify-between items-start">
                                  <div>
                                      <h3 className="font-bold text-[#3C2A21] leading-tight">{item.item_name}</h3>
                                      <p className="text-[#F9A825] font-bold text-sm mt-1">
                                          ₱{parseFloat(item.price).toFixed(2)} <span className="text-gray-400 font-normal">/ea</span>
                                      </p>
                                  </div>
                                  <div className="text-lg font-bold text-[#3C2A21]">
                                      ₱{itemTotal.toFixed(2)}
                                  </div>
                              </div>
                              
                              {/* Controls Row */}
                              <div className="flex items-center justify-between">
                                  <div className="flex items-center bg-[#f3f4f6] rounded-lg p-1">
                                      <button 
                                          onClick={() => onUpdateQuantity(item.item_id, item.quantity - 1)} 
                                          className="w-7 h-7 flex items-center justify-center bg-white rounded-md shadow-sm text-gray-600 hover:text-[#F9A825] active:scale-95 transition-all"
                                      >
                                          <Minus size={14} strokeWidth={3} />
                                      </button>
                                      <span className="w-8 text-center font-bold text-[#3C2A21] text-sm">{item.quantity}</span>
                                      <button 
                                          onClick={() => onUpdateQuantity(item.item_id, item.quantity + 1)} 
                                          className="w-7 h-7 flex items-center justify-center bg-white rounded-md shadow-sm text-gray-600 hover:text-[#F9A825] active:scale-95 transition-all"
                                      >
                                          <Plus size={14} strokeWidth={3} />
                                      </button>
                                  </div>

                                  <button 
                                      onClick={() => onRemoveItem(item.item_id)} 
                                      className="text-gray-400 hover:text-red-500 transition-colors p-1"
                                  >
                                      <Trash2 size={18} />
                                  </button>
                              </div>
                          </div>
                      </div>

                      {/* Specific Instruction Input */}
                      <div className="relative">
                          <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                              <MessageSquare size={14} className="text-gray-400" />
                          </div>
                          <input
                              type="text"
                              placeholder="Add notes (e.g. No onions)"
                              value={item.instructions || ''}
                              onChange={(e) => onUpdateItemInstruction(item.item_id, e.target.value)}
                              className="w-full pl-9 pr-3 py-2 text-sm bg-[#f9f9f9] border border-gray-200 rounded-lg text-gray-600 placeholder-gray-400 focus:outline-none focus:border-[#F9A825] focus:bg-white transition-all"
                          />
                      </div>
                  </div>
                );
              })
            )}
          </div>
        </div>

        {/* --- Footer (Totals) --- */}
        <div className="bg-[#fff8f0] border-t border-[#e5dccb] p-6 shadow-[0_-4px_6px_-1px_rgba(0,0,0,0.05)]">
             <div className="space-y-2 mb-4">
                <div className="flex justify-between text-sm text-gray-600">
                    <span>Subtotal</span>
                    <span className="font-medium">₱{subtotal.toFixed(2)}</span>
                </div>
                <div className="flex justify-between text-sm text-gray-600">
                    <span>Service Charge (10%)</span>
                    <span className="font-medium">₱{serviceAmount.toFixed(2)}</span>
                </div>
                <div className="flex justify-between text-sm text-gray-600">
                    <span>VAT (12%)</span>
                    <span className="font-medium">₱{vatAmount.toFixed(2)}</span>
                </div>
                <div className="flex justify-between text-lg font-bold text-[#3C2A21] pt-2 border-t border-dashed border-gray-300">
                    <span>Total</span>
                    <span>₱{grandTotal.toFixed(2)}</span>
                </div>
             </div>
              
              <button
                onClick={() => onPlaceOrder({ 
                    table_id: orderType === 'Dine-in' ? selectedTableId : null,
                    room_id: orderType === 'Room Dining' ? selectedRoomId : null 
                })}
                disabled={
                    cartItems.length === 0 || 
                    (orderType === 'Dine-in' && !selectedTableId) || 
                    (orderType === 'Room Dining' && !selectedRoomId)
                }
                className="w-full bg-[#0B3D2E] text-white font-bold py-4 rounded-xl shadow-lg hover:bg-[#082f23] disabled:bg-gray-300 disabled:cursor-not-allowed transition-all active:scale-[0.98]"
              >
                {isPlacingOrder ? 'Processing...' : 'Place Order'}
              </button>
        </div>
      </div>
    </>
  );
};

export default CartPanel;
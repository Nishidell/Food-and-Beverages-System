import React, { useState, useEffect } from 'react';
import { Trash2, ShoppingBag, Utensils } from 'lucide-react';

const PosCart = ({
  cartItems = [],
  availableTables = [],
  onUpdateQuantity,
  onPlaceOrder,
  onRemoveItem,
  onUpdateItemInstructions,
  deliveryLocation, 
  setDeliveryLocation,
}) => {
  const [serviceMode, setServiceMode] = useState('Take Out'); 
  const [selectedTableId, setSelectedTableId] = useState(''); 

  // Calculations
  const SERVICE_RATE = 0.10; 
  const VAT_RATE = 0.12;     

  const subtotal = cartItems.reduce(
    (total, item) => total + parseFloat(item.price || 0) * item.quantity,
    0
  );
  const serviceAmount = subtotal * SERVICE_RATE;
  const vatAmount = (subtotal + serviceAmount) * VAT_RATE;
  const grandTotal = subtotal + serviceAmount + vatAmount;

  useEffect(() => {
    if (cartItems.length === 0) {
      setServiceMode('Take Out');
      setSelectedTableId('');
    }
  }, [cartItems]);

  const handleProceed = () => {
      if (serviceMode === 'For Here' && !selectedTableId) {
          alert("Please select a table for Dine-in orders.");
          return;
      }
      const tableObj = availableTables.find(t => t.table_id === parseInt(selectedTableId));
      const tableNumber = tableObj ? tableObj.table_number : 'Unknown';

      const orderMeta = {
          totalAmount: grandTotal,
          customerName: deliveryLocation || 'Guest',
          serviceMode: serviceMode,
          tableId: serviceMode === 'For Here' ? selectedTableId : null,
          tableNumber: serviceMode === 'For Here' ? tableNumber : null
      };
      onPlaceOrder(orderMeta);
  };

  return (
    <div className="flex flex-col h-full bg-white shadow-lg border-l border-gray-200">
      
      {/* 1. COMPACT HEADER */}
      <div className="px-5 py-4 bg-white border-b border-gray-100 flex justify-between items-center shrink-0">
        <h2 className="text-xl font-bold text-[#3C2A21]">New Order</h2>
        <span className="text-xs font-bold text-[#F9A825] uppercase bg-orange-50 px-2 py-1 rounded">Walk-in</span>
      </div>

      {/* 2. CONTROLS SECTION (Fixed at top, non-scrollable) */}
      <div className="px-5 py-3 space-y-3 shrink-0 bg-gray-50 border-b border-gray-200">
        {/* Service Mode Toggle */}
        <div className="flex bg-white rounded-lg p-1 border border-gray-200 shadow-sm">
            <button
                onClick={() => setServiceMode('Take Out')}
                className={`flex-1 py-2 text-xs font-bold rounded-md transition-all flex items-center justify-center gap-2 ${
                serviceMode === 'Take Out' ? 'bg-[#F9A825] text-[#3C2A21] shadow-sm' : 'text-gray-500 hover:bg-gray-50'
                }`}
            >
                <ShoppingBag size={14}/> Take Out
            </button>
            <button
                onClick={() => setServiceMode('For Here')}
                className={`flex-1 py-2 text-xs font-bold rounded-md transition-all flex items-center justify-center gap-2 ${
                serviceMode === 'For Here' ? 'bg-[#F9A825] text-[#3C2A21] shadow-sm' : 'text-gray-500 hover:bg-gray-50'
                }`}
            >
                <Utensils size={14}/> For Here
            </button>
        </div>

        {/* Table Selection (Conditional) */}
        {serviceMode === 'For Here' && (
            <select 
                value={selectedTableId}
                onChange={(e) => setSelectedTableId(e.target.value)}
                className="w-full text-sm border border-gray-300 rounded-lg p-2 focus:outline-none focus:ring-1 focus:ring-[#F9A825] bg-white"
            >
                <option value="">-- Select Table --</option>
                {availableTables.map(t => {
                    const isOccupied = t.status?.toLowerCase() === 'occupied';
                    return (
                        <option key={t.table_id} value={t.table_id} disabled={isOccupied} className={isOccupied ? "text-gray-400" : ""}>
                            Table {t.table_number} {isOccupied ? '(Occupied)' : ''}
                        </option>
                    );
                })}
            </select>
        )}

        {/* Name Input */}
        <input
            type="text" 
            value={deliveryLocation}
            onChange={(e) => setDeliveryLocation(e.target.value)}
            className="w-full border border-gray-300 rounded-lg p-2 text-sm focus:outline-none focus:ring-1 focus:ring-[#F9A825]"
            placeholder='Customer Name (e.g. Nicole)'
        />
      </div>

      {/* 3. SCROLLABLE LIST AREA (This now expands to fill space) */}
      <div className="flex-1 overflow-y-auto min-h-0 p-4 bg-white"> 
           {cartItems.length === 0 ? (
            <div className="h-full flex flex-col items-center justify-center text-gray-400 opacity-60">
                <ShoppingBag size={48} className="mb-2"/>
                <p>No items yet</p>
            </div>
          ) : (
            <div className="space-y-4">
              {cartItems.map((item, index) => (
                <div key={`${item.item_id}-${index}`} className="group bg-white border border-gray-100 rounded-xl p-3 shadow-sm hover:shadow-md transition-shadow">
                  {/* Item Header */}
                  <div className="flex justify-between items-start mb-2">
                    <div className="flex-1">
                        <p className="font-bold text-[#3C2A21] leading-tight">{item.item_name}</p>
                        <p className="text-xs text-[#F9A825] font-bold mt-1">₱{parseFloat(item.price || 0).toFixed(2)}</p>
                    </div>
                    {/* Qty Controls */}
                    <div className="flex items-center gap-2 bg-gray-50 rounded-lg p-1 border border-gray-200">
                        <button onClick={() => onUpdateQuantity(item.item_id, item.quantity - 1)} className="w-6 h-6 flex items-center justify-center rounded bg-white text-gray-600 hover:text-red-500 shadow-sm">-</button>
                        <span className="w-4 text-center text-xs font-bold">{item.quantity}</span>
                        <button onClick={() => onUpdateQuantity(item.item_id, item.quantity + 1)} className="w-6 h-6 flex items-center justify-center rounded bg-white text-gray-600 hover:text-green-600 shadow-sm">+</button>
                    </div>
                  </div>
                  
                  {/* Instruction Input */}
                  <div className="flex gap-2 items-start mt-2 pt-2 border-t border-gray-50">
                    <textarea
                        placeholder="Add notes..."
                        value={item.instructions || ''}
                        onChange={(e) => onUpdateItemInstructions(item.item_id, e.target.value)}
                        rows="1"
                        className="flex-1 text-xs p-2 bg-gray-50 border border-gray-200 rounded focus:bg-white focus:ring-1 focus:ring-[#F9A825] outline-none resize-none overflow-hidden"
                        style={{ minHeight: '34px' }}
                    ></textarea>
                    <button onClick={() => onRemoveItem(item.item_id)} className="p-2 text-gray-300 hover:text-red-500 transition-colors">
                        <Trash2 size={16} />
                    </button>
                  </div>
                </div>
              ))}
            </div>
          )}
      </div>

      {/* 4. COMPACT FOOTER (Fixed at bottom) */}
      <div className="p-4 bg-gray-50 border-t border-gray-200 shrink-0">
          <div className="space-y-1 mb-3">
            <div className="flex justify-between text-xs text-gray-500"><span>Subtotal</span><span>₱{subtotal.toFixed(2)}</span></div>
            <div className="flex justify-between text-xs text-gray-500"><span>Service (10%)</span><span>₱{serviceAmount.toFixed(2)}</span></div>
            <div className="flex justify-between text-xs text-gray-500"><span>VAT (12%)</span><span>₱{vatAmount.toFixed(2)}</span></div>
            <div className="flex justify-between text-[#3C2A21] font-bold text-lg pt-1 border-t border-gray-200 mt-1">
                <span>Total</span>
                <span>₱{grandTotal.toFixed(2)}</span>
            </div>
          </div>
          
          <button
            onClick={handleProceed} 
            disabled={cartItems.length === 0}
            className="w-full py-3 rounded-xl font-bold text-white shadow-lg bg-[#F9A825] hover:bg-[#e0961f] disabled:bg-gray-300 disabled:shadow-none transition-all active:scale-95"
          >
            Pay ₱{grandTotal.toFixed(2)}
          </button>
      </div>
    </div>
  );
};

export default PosCart;
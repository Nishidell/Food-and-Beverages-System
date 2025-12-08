import React, { useEffect } from 'react';
import { Trash2 } from 'lucide-react';

const PosCart = ({
  cartItems = [],
  onUpdateQuantity,
  onPlaceOrder,
  // Removed orderType/setOrderType props as they are no longer toggled here
  instructions,
  setInstructions,
  onRemoveItem,
  deliveryLocation, // We use this as Customer Name for Walk-ins
  setDeliveryLocation,
}) => {
  // Calculations (FOR DISPLAY ONLY)
  const SERVICE_RATE = 0.10; 
  const VAT_RATE = 0.12;     

  const subtotal = cartItems.reduce(
    (total, item) => total + parseFloat(item.price || 0) * item.quantity,
    0
  );
  const serviceAmount = subtotal * SERVICE_RATE;
  const vatAmount = (subtotal + serviceAmount) * VAT_RATE;
  const grandTotal = subtotal + serviceAmount + vatAmount;

  return (
    <div className="flex flex-col h-full bg-white shadow-lg border-l border-gray-200">
      {/* Header */}
      <div className="p-6 bg-white border-b border-gray-100">
        <h2 className="text-2xl font-bold text-[#3C2A21]">New Order</h2>
        <span className="text-xs font-bold text-[#F9A825] uppercase tracking-wider">Walk-in Service</span>
      </div>

      {/* Content Container */}
      <div className="flex-1 flex flex-col p-6 overflow-hidden">
        
        {/* Customer Name Input (Formerly Delivery Location) */}
        <div className="mb-6 text-[#3C2A21]">
          <label htmlFor="delivery_location" className="block text-sm font-semibold text-gray-700 mb-2">
            Customer Name
          </label>
          <input
            id="delivery_location"
            type="text" 
            value={deliveryLocation}
            onChange={(e) => setDeliveryLocation(e.target.value)}
            className="w-full border border-gray-300 rounded-lg p-3 focus:outline-none focus:ring-2 focus:ring-[#F9A825] focus:border-transparent"
            placeholder='e.g., "John Doe"'
            required
          />
        </div>

        {/* Cart Items List */}
        <div className="flex-1 overflow-y-auto pr-2 mb-4">
          {cartItems.length === 0 ? (
            <div className="h-full flex flex-col items-center justify-center text-gray-400">
                <p>Cart is empty.</p>
            </div>
          ) : (
            <div className="space-y-4">
              {cartItems.map((item) => (
                <div key={item.item_id} className="flex justify-between items-center group">
                  <div>
                    <p className="font-semibold text-[#3C2A21]">{item.item_name}</p>
                    <p className="text-sm text-gray-500">₱{parseFloat(item.price || 0).toFixed(2)}</p>
                  </div>
                  <div className="flex items-center gap-3">
                    <button 
                        onClick={() => onUpdateQuantity(item.item_id, item.quantity - 1)} 
                        className="bg-gray-100 w-8 h-8 rounded-full font-bold text-gray-600 hover:bg-[#F9A825] hover:text-white transition-colors"
                    >
                        -
                    </button>
                    <span className="w-6 text-center font-medium">{item.quantity}</span>
                    <button 
                        onClick={() => onUpdateQuantity(item.item_id, item.quantity + 1)} 
                        className="bg-gray-100 w-8 h-8 rounded-full font-bold text-gray-600 hover:bg-[#F9A825] hover:text-white transition-colors"
                    >
                        +
                    </button>
                    <button 
                        onClick={() => onRemoveItem(item.item_id)} 
                        className="text-gray-400 hover:text-red-500 ml-2 transition-colors"
                    >
                        <Trash2 size={18} />
                    </button>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>

        {/* Instructions */}
        <div className="mb-4">
          <label htmlFor="instructions" className="block text-sm font-semibold text-gray-700 mb-2">Special Instructions</label>
          <textarea 
            id="instructions" 
            value={instructions} 
            onChange={(e) => setInstructions(e.target.value)} 
            rows="2" 
            className="w-full border border-gray-300 rounded-lg p-3 text-sm focus:outline-none focus:ring-2 focus:ring-[#F9A825] focus:border-transparent" 
            placeholder="e.g. allergies, extra spicy, etc."
          ></textarea>
        </div>

        {/* Footer with Calculations */}
        <div className="border-t border-gray-100 pt-4 space-y-2">
          <div className="flex justify-between text-sm text-gray-600">
            <span>Subtotal</span>
            <span>₱{subtotal.toFixed(2)}</span>
          </div>
          <div className="flex justify-between text-sm text-gray-600">
            <span>Service Charge ({ (SERVICE_RATE * 100).toFixed(0) }%)</span>
            <span>₱{serviceAmount.toFixed(2)}</span>
          </div>
          <div className="flex justify-between text-sm text-gray-600">
            <span>VAT ({ (VAT_RATE * 100).toFixed(0) }%)</span>
            <span>₱{vatAmount.toFixed(2)}</span>
          </div>
          <div className="flex justify-between text-[#3C2A21] font-bold text-xl pt-2 mt-2">
            <span>Total amount</span>
            <span>₱{grandTotal.toFixed(2)}</span>
          </div>
          
          <button
            onClick={() => onPlaceOrder(grandTotal)} 
            disabled={cartItems.length === 0 || !deliveryLocation}
            className="w-full mt-4 font-bold py-4 rounded-xl transition-all shadow-md bg-[#F9A825] text-[#3C2A21] hover:bg-[#e0961f] disabled:bg-gray-300 disabled:text-gray-500 disabled:shadow-none"
          >
            Proceed to Payment
          </button>
        </div>
      </div>
    </div>
  );
};

export default PosCart;
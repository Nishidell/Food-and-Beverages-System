import React from 'react';

const CartPanel = ({ cartItems = [], onUpdateQuantity, onPlaceOrder }) => {
  // Calculate the total price of the items in the cart
  const totalPrice = cartItems.reduce(
    (total, item) => total + parseFloat(item.price) * item.quantity,
    0
  );

  return (
    <div className="bg-white rounded-lg shadow-md p-6 sticky top-8">
      <h2 className="text-2xl font-bold mb-6">My Order</h2>

      {cartItems.length === 0 ? (
        <p className="text-gray-500 text-center py-8">Your cart is empty.</p>
      ) : (
        <div className="space-y-4 max-h-96 overflow-y-auto pr-2">
          {cartItems.map((item) => (
            <div key={item.item_id} className="flex justify-between items-center">
              <div>
                <p className="font-semibold">{item.name}</p>
                <p className="text-sm text-gray-500">${parseFloat(item.price).toFixed(2)}</p>
              </div>
              <div className="flex items-center gap-3">
                <button
                  onClick={() => onUpdateQuantity(item.item_id, item.quantity - 1)}
                  className="bg-gray-200 w-6 h-6 rounded-md font-bold hover:bg-gray-300"
                >
                  -
                </button>
                <span className="w-4 text-center">{item.quantity}</span>
                <button
                  onClick={() => onUpdateQuantity(item.item_id, item.quantity + 1)}
                  className="bg-gray-200 w-6 h-6 rounded-md font-bold hover:bg-gray-300"
                >
                  +
                </button>
              </div>
            </div>
          ))}
        </div>
      )}

      {/* Footer with Total and Place Order button */}
      <div className="border-t pt-4 mt-6">
        <div className="flex justify-between font-bold text-lg mb-4">
          <span>Total</span>
          <span>${totalPrice.toFixed(2)}</span>
        </div>
        <button
          onClick={() => {
            console.log('Place Order button clicked!'); // <-- ADD THIS LINE
            onPlaceOrder();
          }}
          disabled={cartItems.length === 0}
          className="w-full bg-green-500 text-white font-bold py-3 rounded-lg hover:bg-green-600 transition-colors disabled:bg-gray-400 disabled:cursor-not-allowed"
        >
          Place Order
        </button>
      </div>
    </div>
  );
};

export default CartPanel;
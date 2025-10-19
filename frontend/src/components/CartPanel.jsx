import React from 'react';
import { useState, useEffect } from 'react';

const CartPanel = ({ cartItems = [], onUpdateQuantity }) => {
  // Calculate the total price of the items in the cart
  const totalPrice = cartItems.reduce(
    (total, item) => total + item.price * item.quantity,
    0
  );

  return (
    <div className="bg-white rounded-lg shadow-md p-6">
      <h2 className="text-2xl font-bold mb-6">My Order</h2>

      {cartItems.length === 0 ? (
        <p className="text-gray-500">Your cart is empty.</p>
      ) : (
        <div className="space-y-4">
          {cartItems.map((item) => (
            <div key={item.item_id} className="flex justify-between items-center">
              <div>
                <p className="font-semibold">{item.name}</p>
                <p className="text-sm text-gray-500">${parseFloat(item.price).toFixed(2)}</p>
              </div>
              <div className="flex items-center gap-2">
                <button
                  onClick={() => onUpdateQuantity(item.item_id, item.quantity - 1)}
                  className="bg-gray-200 px-2 rounded-md font-bold"
                >
                  -
                </button>
                <span>{item.quantity}</span>
                <button
                  onClick={() => onUpdateQuantity(item.item_id, item.quantity + 1)}
                  className="bg-gray-200 px-2 rounded-md font-bold"
                >
                  +
                </button>
              </div>
            </div>
          ))}
        </div>
      )}

      {/* Display the calculated total */}
      <div className="border-t pt-4 mt-6">
        <div className="flex justify-between font-bold text-lg">
          <span>Total</span>
          <span>${totalPrice.toFixed(2)}</span>
        </div>
        <button className="w-full bg-green-500 text-white font-bold py-3 rounded mt-4 hover:bg-green-600 transition-colors">
          Place Order
        </button>
      </div>
    </div>
  );
};

export default CartPanel;
import React, { useState } from "react";

const CartPanel = ({ cart = [], updateCart = () => {}, isCartOpen = false }) => {
  const [orderType, setOrderType] = useState("dine-in");
  const [orderNumber, setOrderNumber] = useState("");

  const increaseQty = (id) => {
    updateCart(
      cart.map((item) =>
        item.id === id ? { ...item, qty: item.qty + 1 } : item
      )
    );
  };

  const decreaseQty = (id) => {
    updateCart(
      cart.map((item) =>
        item.id === id && item.qty > 1
          ? { ...item, qty: item.qty - 1 }
          : item
      )
    );
  };

  const removeItem = (id) => {
    updateCart(cart.filter((item) => item.id !== id));
  };

  const clearCart = () => updateCart([]);

  const subtotal = Array.isArray(cart)
    ? cart.reduce((acc, item) => acc + item.price * item.qty, 0)
    : 0;

  const serviceCharge = subtotal * 0.1;
  const vat = subtotal * 0.12;
  const totalAmount = subtotal + serviceCharge + vat;

  return (
    <div
      className={`fixed top-0 right-0 h-full w-[350px] bg-white shadow-lg p-4 overflow-y-auto transform transition-transform duration-300 ${
        isCartOpen ? "translate-x-0" : "translate-x-full"
      }`}
    >
      <h2 className="text-lg font-semibold mb-3">Your Order</h2>

      {/* Order type */}
      <div className="mb-3 flex gap-3">
        <button
          className={`px-3 py-1 rounded ${
            orderType === "dine-in" ? "bg-green-700 text-white" : "bg-gray-200"
          }`}
          onClick={() => setOrderType("dine-in")}
        >
          Dine-In
        </button>
        <button
          className={`px-3 py-1 rounded ${
            orderType === "room-service" ? "bg-green-700 text-white" : "bg-gray-200"
          }`}
          onClick={() => setOrderType("room-service")}
        >
          Room Service
        </button>
      </div>

      {/* Table or room number */}
      <input
        type="text"
        className="w-full p-2 border rounded mb-3"
        placeholder={
          orderType === "dine-in" ? "Enter Table Number" : "Enter Room Number"
        }
        value={orderNumber}
        onChange={(e) => setOrderNumber(e.target.value)}
      />

      {/* Cart items */}
      {Array.isArray(cart) && cart.length === 0 ? (
        <p className="text-gray-500">Your cart is empty.</p>
      ) : (
        <div className="space-y-2">
          {cart.map((item) => (
            <div
              key={item.id}
              className="flex justify-between items-center bg-gray-50 p-2 rounded shadow-sm"
            >
              <div>
                <p className="font-semibold">{item.name}</p>
                <p className="text-sm text-gray-600">
                  ₱{item.price} × {item.qty}
                </p>
              </div>
              <div className="flex items-center space-x-2">
                <button
                  onClick={() => decreaseQty(item.id)}
                  className="px-2 bg-gray-200 rounded"
                >
                  -
                </button>
                <span>{item.qty}</span>
                <button
                  onClick={() => increaseQty(item.id)}
                  className="px-2 bg-gray-200 rounded"
                >
                  +
                </button>
                <button
                  onClick={() => removeItem(item.id)}
                  className="text-red-500 text-sm"
                >
                  ✕
                </button>
              </div>
            </div>
          ))}
        </div>
      )}

      {/* Totals */}
      <div className="border-t pt-2 text-sm mt-3">
        <p>Subtotal: ₱{subtotal.toFixed(2)}</p>
        <p>Service Charge (10%): ₱{serviceCharge.toFixed(2)}</p>
        <p>VAT (12%): ₱{vat.toFixed(2)}</p>
        <p className="font-semibold mt-2">Total: ₱{totalAmount.toFixed(2)}</p>
      </div>

      <button
        onClick={clearCart}
        className="w-full mt-4 bg-red-500 text-white py-2 rounded hover:bg-red-600"
      >
        Clear Cart
      </button>

    </div>
    
  );
};

export default CartPanel;

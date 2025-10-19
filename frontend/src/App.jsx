import React, { useState } from "react";
import CategoryTabs from "./components/CategoryTabs";
import FoodGrid from "./components/FoodGrid";
import CartPanel from "./components/CartPanel";
import { ShoppingCart } from "lucide-react";
import HeaderBar from "./components/HeaderBar";

export default function App() {
  const [activeCategory, setActiveCategory] = useState("All");
  const [cartItems, setCartItems] = useState([]);
  const [isCartOpen, setIsCartOpen] = useState(false);

  const addToCart = (item) => {
    setCartItems((prev) => {
      const existing = prev.find((i) => i.id === item.id);
      if (existing) {
        return prev.map((i) =>
          i.id === item.id ? { ...i, qty: i.qty + 1 } : i
        );
      }
      return [...prev, { ...item, qty: 1 }];
    });
  };

  const updateCart = (newCart) => setCartItems(newCart);

  return (
    <div className="min-h-screen bg-gray-100 relative transition-all duration-300">
      {/* Header */}
      <header className="flex justify-between items-center px-6 py-4 shadow-sm bg-white">
        <h1 className="text-2xl font-bold text-[#053a34]">FoodieHub</h1>


        {/* Cart Button */}
        <button
          onClick={() => setIsCartOpen(!isCartOpen)}
          className="relative bg-[#F6B24B] text-[#053a34] p-3 rounded-full shadow-md hover:bg-[#f7c36e] transition"
        >
          <ShoppingCart size={22} />
          {cartItems.length > 0 && (
            <span className="absolute -top-1 -right-1 bg-red-500 text-white text-xs px-1.5 rounded-full">
              {cartItems.length}
            </span>
          )}
        </button>
      </header>

      {/* Category + Food Grid */}
      <div
        className={`p-4 transition-all duration-300 ${
          isCartOpen ? "lg:mr-[350px]" : ""
        }`}
      >
        <CategoryTabs active={activeCategory} onChange={setActiveCategory} />
        <div className="mt-4">
          <FoodGrid activeCategory={activeCategory} addToCart={addToCart} />
        </div>
      </div>

      {/* Cart Panel */}
      <CartPanel
        cart={cartItems}
        updateCart={updateCart}
        isCartOpen={isCartOpen}
        closeCart={() => setIsCartOpen(false)}
      />

      {/* Overlay for mobile */}
      {isCartOpen && (
        <div
          onClick={() => setIsCartOpen(false)}
        ></div>
      )}
    </div>
  );
}

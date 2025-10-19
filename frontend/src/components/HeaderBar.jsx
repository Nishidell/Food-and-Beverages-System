import React from "react";
import { ShoppingCart } from "lucide-react";

export default function HeaderBar({ cartCount, onCartToggle }) {
  return (
    <header
      // I've removed the part that was causing the error for now.
      className="flex justify-between items-center px-6 py-4 shadow-sm bg-white transition-all duration-300"
    >
      <h1 className="text-2xl font-bold text-[#053a34]">FoodieHub</h1>

      <button
        onClick={onCartToggle}
        className="relative bg-[#F6B24B] text-[#053a34] p-3 rounded-full shadow-md hover:bg-[#f7c36e] transition"
      >
        <ShoppingCart size={22} />
        {cartCount > 0 && (
          <span className="absolute -top-1 -right-1 bg-red-500 text-white text-xs px-1.5 rounded-full">
            {cartCount}
          </span>
        )}
      </button>
    </header>
  );
}
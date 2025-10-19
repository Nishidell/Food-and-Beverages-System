import React from "react";

const categories = ["All", "Appetizers", "Main Course", "Desserts", "Drinks"];

export default function CategoryTabs({ active, onChange }) {
  return (
    <div className="flex justify-center bg-white shadow-sm py-4">
      <div className="flex flex-wrap justify-center gap-3">
        {categories.map((cat) => (
          <button
            key={cat}
            onClick={() => onChange(cat)}
            className={`px-4 py-2 rounded-full text-sm font-medium transition-all duration-200
              ${
                active === cat
                  ? "bg-[#053a34] text-white shadow-md"
                  : "bg-gray-100 text-[#053a34] hover:bg-gray-200"
              }`}
          >
            {cat}
          </button>
        ))}
      </div>
    </div>
  );
}

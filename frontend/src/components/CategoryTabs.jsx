import React from "react";

const categories = ["All", "Appetizers", "Main Course", "Desserts", "Drinks"];

export default function CategoryTabs({ active, onChange }) {
  return (
    <div className="flex flex-wrap gap-2 p-4 bg-white shadow-sm">
      {categories.map((cat) => (
        <button
          key={cat}
          onClick={() => onChange(cat)}
          className={`px-4 py-2 rounded-full text-sm font-medium transition-all
            ${
              active === cat
                ? "bg-[#053a34] text-white"
                : "bg-gray-100 text-[#053a34] hover:bg-gray-200"
            }`}
        >
          {cat}
        </button>
      ))}
    </div>
  );
}

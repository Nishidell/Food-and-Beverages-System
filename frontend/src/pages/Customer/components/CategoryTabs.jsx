import React from 'react';
const CategoryTabs = ({ categories, selectedCategory, onSelectCategory }) => {
  return (
    <div className="mt-8">
      <div className="flex justify-center space-x-4 border-b">
        
        {/* 1. Manually add the "All" button, which uses ID 0 */}
        <button
          key="all"
          onClick={() => onSelectCategory(0)}
          className={`py-2 px-4 text-lg font-semibold transition-colors whitespace-nowrap ${
            selectedCategory === 0
              ? 'border-b-2 border-orange-500 text-orange-300'
              : 'text-orange-300 hover:text-orange-300'
          }`}
        >
          All
        </button>

        {/* 2. Map over the categories from the API */}
        {categories.map((category) => (
          <button
            key={category.category_id}
            onClick={() => onSelectCategory(category.category_id)}
            className={`py-2 px-4 text-lg font-semibold transition-colors whitespace-nowrap ${
              selectedCategory === category.category_id
                ? 'border-b-2 border-orange-500 text-orange-300'
                : 'text-orange-300 hover:text-orange-300'
            }`}
          >
            {category.name}
          </button>
        ))}
      </div>
    </div>
  );
};

export default CategoryTabs;
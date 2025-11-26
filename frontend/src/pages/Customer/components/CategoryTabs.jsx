import React from 'react';
import '../CustomerTheme.css'; // Import the external CSS

const CategoryTabs = ({ categories, selectedCategory, onSelectCategory }) => {
  return (
    <div className="category-tabs-wrapper">
      <div className="category-tabs-track">
        <div className="category-tabs-list">

          {/* "All" button */}
          <button
            key="all"
            onClick={() => onSelectCategory(0)}
            className={`category-tab-btn ${selectedCategory === 0 ? 'active' : ''}`}
          >
            All Items
          </button>

          {/* Mapped categories */}
          {categories.map((category) => (
            <button
              key={category.category_id}
              onClick={() => onSelectCategory(category.category_id)}
              className={`category-tab-btn ${selectedCategory === category.category_id ? 'active' : ''}`}
            >
              {category.name}
            </button>
          ))}

        </div>
      </div>
    </div>
  );
};

export default CategoryTabs;
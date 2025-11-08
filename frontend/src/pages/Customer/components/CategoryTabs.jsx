import React from 'react';

const CategoryTabs = ({ categories, selectedCategory, onSelectCategory }) => {

  // 1. The main div that provides margin from the element above it
  const wrapperStyle = {
    paddingTop: '16px', // Space above the tabs
    paddingLeft: '16px', // Give some horizontal padding
    paddingRight: '16px',
    marginBottom: '16px', // Space below the tabs
  };

  // 2. The new "track" with the dark orange border
  // This is the main change.
  const tabListContainerStyle = {
    border: '2px solid #D97706', // A dark, solid orange border
    borderRadius: '50px', // Very rounded to make it a "pill"
    padding: '8px', // Padding inside the track
    overflowX: 'auto', // Allows scrolling on small screens
    backgroundColor: '#0B3D2E', // Ensures background is the dark green
  };

  // 3. The flex container for the buttons themselves
  const tabListStyle = {
    display: 'flex',
    justifyContent: 'center', // Center the tabs
    gap: '16px', // space between tabs
  };

  // 4. Style for ALL buttons (inactive)
  const baseTabStyle = {
    padding: '8px 16px',
    fontSize: '1.125rem', // 18px
    fontWeight: '600',
    color: '#F9A825', // Orange text for inactive (to match border)
    backgroundColor: 'transparent',
    border: 'none',
    borderRadius: '50px', // Very rounded
    cursor: 'pointer',
    whiteSpace: 'nowrap',
  };

  // 5. Style to ADD when a button is active
  const activeTabStyle = {
    backgroundColor: '#F9A825', // Solid orange background
    color: '#0B3D2E', // Dark text on active tab
  };

  return (
    <div style={wrapperStyle}>
      <div style={tabListContainerStyle}>
        <div style={tabListStyle}>

          {/* "All" button */}
          <button
            key="all"
            onClick={() => onSelectCategory(0)}
            style={
              selectedCategory === 0
                ? { ...baseTabStyle, ...activeTabStyle }
                : baseTabStyle
            }
          >
            All Items
          </button>

          {/* Mapped categories */}
          {categories.map((category) => (
            <button
              key={category.category_id}
              onClick={() => onSelectCategory(category.category_id)}
              style={
                selectedCategory === category.category_id
                  ? { ...baseTabStyle, ...activeTabStyle }
                  : baseTabStyle
              }
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
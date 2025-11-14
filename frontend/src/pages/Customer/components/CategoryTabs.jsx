import React from 'react';

const CategoryTabs = ({ categories, selectedCategory, onSelectCategory, theme = "customer" }) => {
  // 6. Define colors for the new 'kitchen' theme
  const kitchenTheme = {
    trackBorder: '#F9A825',    // Accent orange
    trackBg: '#523a2eff',       // Kitchen's dark brown
    inactiveText: '#F9A825',    // Accent orange
    activeBg: '#F9A825',       // Accent orange
    activeText: '#523a2eff',     // Kitchen's dark brown
  };

  // 7. Define colors for the default 'customer' theme
  const customerTheme = {
    trackBorder: '#D97706',    // Dark orange
    trackBg: '#0B3D2E',       // Dark green
    inactiveText: '#F9A825',    // Accent orange
    activeBg: '#F9A825',       // Accent orange
    activeText: '#0B3D2E',     // Dark green
  };

  // 8. Select the correct theme based on the prop
  const colors = theme === 'kitchen' ? kitchenTheme : customerTheme;

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
    border: `2px solid ${colors.trackBorder}`, // Use variable
    borderRadius: '50px', 
    padding: '8px', 
    overflowX: 'auto', 
    backgroundColor: colors.trackBg, // Use variable
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
    color: colors.inactiveText, // Use variable
    backgroundColor: 'transparent',
    border: 'none',
    borderRadius: '50px', // Very rounded
    cursor: 'pointer',
    whiteSpace: 'nowrap',
  };

  // 5. Style to ADD when a button is active
  const activeTabStyle = {
    backgroundColor: colors.activeBg, // Use variable
    color: colors.activeText, // Use variable
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
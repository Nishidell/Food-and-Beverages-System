import React, { useState, useRef, useEffect } from 'react';
import '../CustomerTheme.css'; 

const CategoryTabs = ({ categories, selectedCategory, onSelectCategory, onSortChange, theme = "customer" }) => {
  const [showFilter, setShowFilter] = useState(false);
  const [currentSort, setCurrentSort] = useState('a-z'); 
  const [dropdownStyle, setDropdownStyle] = useState({});
  
  const filterButtonRef = useRef(null);
  const scrollContainerRef = useRef(null); 

  const sortOptions = [
    { id: 'a-z', label: 'Alphabetical (A-Z)' },
    { id: 'z-a', label: 'Alphabetical (Z-A)' },
    { id: 'price-low', label: 'Price (Low-High)' },
    { id: 'price-high', label: 'Price (High-Low)' },
    { id: 'recent', label: 'Recently Added' },
  ];

  const toggleFilter = () => {
    if (!showFilter) {
      const rect = filterButtonRef.current.getBoundingClientRect();
      setDropdownStyle({
        position: 'fixed',
        top: `${rect.bottom + 5}px`, 
        left: `${rect.right - 200}px`,
        width: '200px',
        zIndex: 9999,
      });
    }
    setShowFilter(!showFilter);
  };

  const handleSortSelection = (sortId) => {
    setCurrentSort(sortId);
    setShowFilter(false);
    if (onSortChange) {
      onSortChange(sortId);
    }
  };

  useEffect(() => {
    const handleClickOutside = (event) => {
      if (
        filterButtonRef.current && 
        !filterButtonRef.current.contains(event.target) &&
        !event.target.closest('.filter-dropdown-menu')
      ) {
        setShowFilter(false);
      }
    };
    if (showFilter) document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, [showFilter]);

  useEffect(() => {
    const el = scrollContainerRef.current;
    if (el) {
      const onWheel = (e) => {
        if (e.deltaY === 0) return;
        e.preventDefault();
        el.scrollLeft += e.deltaY;
      };
      el.addEventListener('wheel', onWheel);
      return () => el.removeEventListener('wheel', onWheel);
    }
  }, []);

  return (
    <div className={`category-tabs-wrapper ${theme === 'kitchen' ? 'kitchen-theme' : 'customer-theme'}`}>
      
      <div className="border border-[#F9A825] rounded-[25px] w-full max-w-5xl mx-auto px-4 py-3 sm:px-6 lg:px-8">
        <div className="flex items-center gap-2">
            
            {/* Left Side: Scrollable Categories */}
            <div 
                className="flex-1 flex overflow-x-auto gap-3 pb-2 scrollbar-hide" 
                ref={scrollContainerRef}
                style={{ 
                    display: 'flex', 
                    flexWrap: 'nowrap', 
                    overflowX: 'auto', 
                    whiteSpace: 'nowrap',
                    scrollbarWidth: 'none', 
                    msOverflowStyle: 'none'
                }}
            >
            <button
                onClick={() => onSelectCategory(0)}
                className={`category-tab-btn flex-shrink-0 whitespace-nowrap ${selectedCategory === 0 ? 'active' : ''}`}
            >
                All Items
            </button>

            {categories.map((category) => (
                <button
                key={category.category_id}
                onClick={() => onSelectCategory(category.category_id)}
                className={`category-tab-btn flex-shrink-0 whitespace-nowrap ${selectedCategory === category.category_id ? 'active' : ''}`}
                >
                {category.name}
                </button>
            ))}
            </div>
            
            {/* Right Side: Sticky Filter Button */}
            <div className="flex-none pl-2 border-l border-gray-300">
                <button 
                    ref={filterButtonRef}
                    className={`category-tab-btn filter-trigger ${showFilter ? 'active' : ''}`}
                    onClick={toggleFilter}
                    style={{ margin: 0 }} 
                >
                    <svg 
                    width="14" height="14" viewBox="0 0 24 24" 
                    fill="none" stroke="currentColor" strokeWidth="2" 
                    strokeLinecap="round" strokeLinejoin="round"
                    style={{ marginRight: '6px' }}
                    >
                    <polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3"></polygon>
                    </svg>
                    Filter
                </button>
            </div>

        </div>
      </div>

      {showFilter && (
        <div className="filter-dropdown-menu" style={dropdownStyle}>
            {sortOptions.map((option) => (
            <div 
                key={option.id} 
                className={`filter-option ${currentSort === option.id ? 'selected' : ''}`}
                onClick={() => handleSortSelection(option.id)}
            >
                {option.label}
            </div>
            ))}
        </div>
      )}
    </div>
  );
};

export default CategoryTabs;
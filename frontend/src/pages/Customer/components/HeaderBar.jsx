import React from 'react';
import { ShoppingCart, Search, Bell } from 'lucide-react';
import ProfileDropdown from '../../../components/ProfileDropdown';
import '../CustomerTheme.css'; // Import the external CSS

export default function HeaderBar({ cartCount, onCartToggle, searchTerm, onSearchChange, notificationCount, onNotificationToggle }) {
  return (
    <header className="header-bar">

      {/* Left Column: Logo */}
      <div className="header-col-start">
        <img src="/images/logo_var.svg" alt="FoodieHub Logo" className="header-logo"/>
      </div>

      {/* Center Column: Search Bar */}
      <div className="header-col-center">
        <div className="search-icon-wrapper">
          <Search size={20} />
        </div>
        <input
          type="text"
          placeholder="Search for food..."
          className="search-input"
          value={searchTerm}
          onChange={onSearchChange}
        />
      </div>

      {/* Right Column: Cart & Profile & Notifications */}
      <div className="header-col-end">
        
        {/* Notification Button */}
        <button
          onClick={onNotificationToggle}
          className="header-icon-btn"
        >
          <Bell size={22} />
          {notificationCount > 0 && (
            <span className="icon-badge">
              {notificationCount}
            </span>
          )}
        </button>
           
        {/* Cart Button */}
        <button
          onClick={onCartToggle}
          className="header-icon-btn"
        >
          <ShoppingCart size={22} />
          {cartCount > 0 && (
            <span className="icon-badge">
              {cartCount}
            </span>
          )}
        </button>

        {/* Profile Dropdown */}
        {/* Note: To make this perfectly match, you may want to apply the 'header-icon-btn' 
            class inside ProfileDropdown.jsx as well, but for now it uses inline styles 
            that match these colors. */}
        <ProfileDropdown />
      </div>
    </header>
  );
}
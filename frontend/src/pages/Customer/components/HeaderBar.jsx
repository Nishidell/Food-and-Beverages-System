import React from 'react';
import { ShoppingCart, Search, Bell } from 'lucide-react';
import ProfileDropdown from '../../../components/ProfileDropdown';
import { useAuth } from '../../../context/AuthContext'; // ✅ Import Auth Hook
import '../CustomerTheme.css'; 

export default function HeaderBar({ cartCount, onCartToggle, searchTerm, onSearchChange, notificationCount, onNotificationToggle }) {
  const { user } = useAuth(); // ✅ Get user status

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
        
        {/* ✅ CONDITIONAL: Only show Notifications & Cart if Logged In */}
        {user && (
            <>
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
            </>
        )}

        {/* Profile Dropdown (Handles Guest View internally) */}
        <ProfileDropdown />
      </div>
    </header>
  );
}
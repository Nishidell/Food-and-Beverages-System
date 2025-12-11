import React from 'react';
import { ShoppingCart, Search, Bell } from 'lucide-react';
import ProfileDropdown from '../../../components/ProfileDropdown';
import { useAuth } from '../../../context/AuthContext';
import { useCart } from '../../../context/CartContext'; 
import '../CustomerTheme.css'; 

// ✅ New Prop: showSearch (defaults to true)
export default function HeaderBar({ 
  onCartToggle, 
  searchTerm, 
  onSearchChange, 
  notificationCount = 0, 
  onNotificationToggle,
  showSearch = true 
}) {
  const { user } = useAuth();
  const { cartCount } = useCart();

  return (
    <header className="header-bar">

      {/* Left Column: Logo */}
      <div className="header-col-start">
        <img src="/images/logo_var.svg" alt="FoodieHub Logo" className="header-logo"/>
      </div>

      {/* Center Column: Search Bar (Conditionally Rendered) */}
      <div className="header-col-center">
        {showSearch ? (
            <div className="flex w-full max-w-md items-center bg-white rounded-full px-4 py-2 shadow-sm border border-gray-100">
                <div className="text-gray-400 mr-2">
                <Search size={20} />
                </div>
                <input
                type="text"
                placeholder="Search for food..."
                className="bg-transparent border-none outline-none text-sm text-[#3C2A21] w-full placeholder-gray-400"
                value={searchTerm}
                onChange={onSearchChange}
                />
            </div>
        ) : (
            // Spacer to keep layout balanced when search is hidden
            <div className="hidden md:block w-full"></div> 
        )}
      </div>

      {/* Right Column: Cart & Profile & Notifications */}
      <div className="header-col-end">
        
        {user && (
            <>
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
                    
                <button
                onClick={onCartToggle}
                className="header-icon-btn"
                >
                <ShoppingCart size={22} />
                {/* ✅ Use Context cartCount */}
                {cartCount > 0 && (
                    <span className="icon-badge">
                    {cartCount}
                    </span>
                )}
                </button>
            </>
        )}

        <ProfileDropdown />
      </div>
    </header>
  );
}
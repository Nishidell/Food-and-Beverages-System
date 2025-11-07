import React, { useState, useEffect, useRef } from 'react';
import { User } from 'lucide-react';
import { useAuth } from '../context/AuthContext';

const ProfileDropdown = () => {
  const { user, logout } = useAuth();
  const [isDropdownOpen, setIsDropdownOpen] = useState(false);
  const dropdownRef = useRef(null);

  // Close dropdown when clicking outside
  useEffect(() => {
    function handleClickOutside(event) {
      if (dropdownRef.current && !dropdownRef.current.contains(event.target)) {
        setIsDropdownOpen(false);
      }
    }
    document.addEventListener("mousedown", handleClickOutside);
    return () => {
      document.removeEventListener("mousedown", handleClickOutside);
    };
  }, [dropdownRef]);

  // --- UPDATED: Function to get the display name ---
  const getDisplayName = () => {
    if (!user) return "Guest";
    // Check for firstName and lastName (now used for both customers and staff)
    if (user.firstName && user.lastName) return `${user.firstName} ${user.lastName}`;
    if (user.firstName) return user.firstName; // Fallback if only first name exists
    // Fallback to role if names aren't in token for some reason
    return user.role.charAt(0).toUpperCase() + user.role.slice(1);
  };
  
  if (!user) return null; // Don't show if not logged in

  const profileIconStyle = {
  backgroundColor: '#F9A825', // Your orange accent color
  color: '#3C2A21',           // Dark text/icon color for contrast
  padding: '12px',             // 'p-3'
  borderRadius: '50%',         // 'rounded-full'
  boxShadow: '0 4px 6px rgba(0,0,0,0.1)', // 'shadow-md'
  border: 'none',
  cursor: 'pointer',
};

  return (
    <div className="relative" ref={dropdownRef}>
           {/* Profile Icon Button */}
            <button
       onClick={() => setIsDropdownOpen(!isDropdownOpen)}
       style={profileIconStyle}
      >
       <User size={22} />
      </button>

      {/* Dropdown Menu */}
      {isDropdownOpen && (
        <div className="absolute right-0 mt-2 w-56 bg-white rounded-md shadow-lg py-1 z-50 ring-1 ring-black ring-opacity-5">
          <div className="px-4 py-3">
            <p className="text-sm text-gray-500">Welcome,</p>
            <p className="text-sm font-medium text-gray-900 truncate">
              {getDisplayName()} {/* <-- Use the new function */}
            </p>
          </div>
          <div className="border-t border-gray-100"></div>
          <button
            onClick={logout} // Call the logout function from context
            className="block w-full text-left px-4 py-2 text-sm text-red-600 hover:bg-gray-100"
          >
            Log Out
          </button>
        </div>
      )}
    </div>
  );
};

export default ProfileDropdown;
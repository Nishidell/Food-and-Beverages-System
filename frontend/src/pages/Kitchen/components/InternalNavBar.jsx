import React, { useState } from 'react';
import { Link, NavLink } from 'react-router-dom';
import ProfileDropdown from '../../../components/ProfileDropdown';
import { useAuth } from '../../../context/AuthContext'; 

const InternalNavBar = () => {
  const { user } = useAuth();
  
  // Your Original Styles
  const navLinkStyle = {
    color: 'white',
    textDecoration: 'none',
    padding: '8px 12px',
    borderRadius: '4px',
    fontWeight: 'bold',
    fontSize: '18px',
  };

  const activeNavLinkStyle = {
    ...navLinkStyle,
    color: '#F9A825', // Accent color for active link
  };

  const [isHovered, setIsHovered] = useState(false);

  const baseAdminLinkStyle = {
    color: 'white',
    backgroundColor: '#523a2e',
    border: '1px solid white',
    textDecoration: 'none',
    padding: '8px 12px',
    borderRadius: '6px',
    fontWeight: 'bold',
    fontSize: '16px',
    transition: 'background-color 0.2s',
  };
  
  const hoverAdminLinkStyle = {
    backgroundColor: '#F9A825', 
    color: '#3C2A21', 
    border: '1px solid #F9A825',
  };

  // Permission Helper
  const hasAccess = (allowedPositions) => {
    if (!user || !user.position) return false;
    return allowedPositions.includes(user.position);
  };

  return (
    <nav style={{
        backgroundColor: '#3C2A21', // Dark brown background
        color: 'white',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'space-between',
        padding: '10px 24px',
        boxShadow: '0 2px 4px rgba(0,0,0,0.1)',
        position: 'sticky',
        top: 0,
        zIndex: 60,
    }}>
      {/* Left: Logo */}
      <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
        <Link to="/kitchen">
          <img src="/images/foodAndBeverages.png" alt="Logo" style={{ height: '64px' }} />
        </Link>
      </div>

{/* Center: Navigation Links */}
      <div style={{ display: 'flex', gap: '0.5rem' }}>
          
          {/* 1. Kitchen View (Orders) */}
          {hasAccess(['General Manager', 'Operations Manager', 'Head Chef', 'Assistant Chef']) && (
            <NavLink 
                to="/kitchen" 
                end 
                style={({ isActive }) => (isActive ? activeNavLinkStyle : navLinkStyle)}
            >
              Orders
            </NavLink>
          )}

          {/* 2. Waiter POS */}
          {hasAccess(['General Manager', 'Operations Manager', 'Service Supervisor']) && (
             <NavLink 
                to="/kitchen/waiter" 
                style={({ isActive }) => (isActive ? activeNavLinkStyle : navLinkStyle)}
             >
               Waiter
             </NavLink>
          )}

          {/* 3. Cashier Dashboard */}
          {hasAccess(['General Manager', 'Operations Manager', 'Finance Manager']) && (
             <NavLink 
                to="/kitchen/cashier" 
                style={({ isActive }) => (isActive ? activeNavLinkStyle : navLinkStyle)}
             >
               Cashier
             </NavLink>
          )}
          
          {/* 4. Tables */}
          {hasAccess(['General Manager', 'Operations Manager', 'Service Supervisor']) && (
             <NavLink 
                to="/kitchen/tables" 
                style={({ isActive }) => (isActive ? activeNavLinkStyle : navLinkStyle)}
             >
               Table Availablity
             </NavLink>
          )}

          {/* 5. Inventory */}
          {hasAccess(['General Manager', 'Operations Manager', 'Inventory Manager']) && (
             <NavLink 
                to="/kitchen/inventory" 
                style={({ isActive }) => (isActive ? activeNavLinkStyle : navLinkStyle)}
             >
               Inventory
             </NavLink>
          )}

          {/* 6. Archive */}
          {hasAccess(['General Manager', 'Operations Manager', 'Head Chef', 'Assistant Chef']) && (
             <NavLink 
                to="/kitchen/archive" 
                style={({ isActive }) => (isActive ? activeNavLinkStyle : navLinkStyle)}
             >
               Archive
             </NavLink>
          )}
      </div>

      {/* Right: Admin Button & Profile */}
      <div style={{ display: 'flex', alignItems: 'center', gap: '24px' }}>
        
        {/* Conditionally render Admin Dashboard link */}
        {user && (user.position === 'General Manager' || user.position === 'Operations Manager') && (
          <Link
            to="/admin"
            style={isHovered ? { ...baseAdminLinkStyle, ...hoverAdminLinkStyle } : baseAdminLinkStyle}
            onMouseEnter={() => setIsHovered(true)}
            onMouseLeave={() => setIsHovered(false)}
          >
            Go to Admin Dashboard
          </Link>
        )}

        <ProfileDropdown />
      </div>
    </nav>
  );
};

export default InternalNavBar;
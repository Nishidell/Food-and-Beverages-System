import React from 'react';
import { Link, NavLink } from 'react-router-dom';
import ProfileDropdown from './ProfileDropdown';
import { useAuth } from '../context/AuthContext';

const InternalNavBar = () => {
  const { user } = useAuth();

  return (
    <nav className="bg-primary text-white flex items-center justify-between px-6 py-2 shadow-md sticky top-0 z-10">
      {/* Left: Logo and Title */}
      <div className="flex items-center gap-4">
        <Link to={user.role === 'admin' ? '/admin' : '/kitchen'}>
          <img src="/images/logo_var.svg" alt="Logo" className="h-16" />
        </Link>
        <h1 className="text-xl font-bold">
          {user.role === 'admin' ? 'Admin Dashboard' : 'Kitchen Display'}
        </h1>
      </div>

      {/* Center: Navigation Links */}
      <div className="flex items-center gap-6">
        {/* Admin-only link */}
        {user.role === 'admin' && (
          <NavLink
            to="/admin"
            className={({ isActive }) =>
              `text-lg font-medium hover:text-accent ${isActive ? 'text-accent' : 'text-white'}`
            }
          >
            Dashboard
          </NavLink>
        )}
        
        {/* Staff/Admin links */}
        <NavLink
          to="/kitchen"
          className={({ isActive }) =>
            `text-lg font-medium hover:text-accent ${isActive ? 'text-accent' : 'text-white'}`
          }
        >
          Kitchen
        </NavLink>
        <NavLink
          to="/kitchen/archive"
          className={({ isActive }) =>
            `text-lg font-medium hover:text-accent ${isActive ? 'text-accent' : 'text-white'}`
          }
        >
          Archive
        </NavLink>
      </div>

      {/* Right: Profile Dropdown */}
      <div className="justify-self-end">
        <ProfileDropdown />
      </div>
    </nav>
  );
};

export default InternalNavBar;
import React from 'react';
import { useAuth } from '../../context/AuthContext';
import { Navigate } from 'react-router-dom';

// This component is for routes like /login and /register
// If the user is already logged in, it redirects them to their default page.
const AuthRoute = ({ children }) => {
  const { isAuthenticated, user } = useAuth();

  const getRedirectPath = (user) => {
    if (!user) return '/';

    // 1. Check Position (Staff)
    if (user.position) {
      switch (user.position) {
        case 'F&B Admin':
          return '/admin';
        case 'Kitchen Staffs':
        case 'Waiter':
        case 'Cashier':
        case 'Stock Controller':
          return '/kitchen';
        default:
          return '/kitchen'; // Default staff page
      }
    }

    // 2. Check Role (Customer)
    if (user.role === 'customer') {
      return '/';
    }

    return '/';
  };

  if (isAuthenticated) {
    // Pass the whole user object to the helper
    const path = getRedirectPath(user);
    return <Navigate to={path} replace />;
  }

  // User is not logged in, show the login/register page
  return children;
};

export default AuthRoute;
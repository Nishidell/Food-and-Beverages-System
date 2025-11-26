import React from 'react';
import { useAuth } from '../../context/AuthContext';
import { Navigate, useLocation } from 'react-router-dom';

const ProtectedRoute = ({ children, allowedRoles }) => {
  const { isAuthenticated, user } = useAuth();
  const location = useLocation();

  if (!isAuthenticated) {
    return <Navigate to="/login" state={{ from: location }} replace />;
  }

  // Logic: Check if EITHER the user's role OR the user's position is allowed
  const userRole = user.role;
  const userPosition = user.position;

  const isAllowed = allowedRoles.some(allowed => 
    allowed === userRole || allowed === userPosition
  );

  if (allowedRoles && !isAllowed) {
    return <Navigate to="/not-authorized" replace />;
  }

  return children;
};
export default ProtectedRoute;
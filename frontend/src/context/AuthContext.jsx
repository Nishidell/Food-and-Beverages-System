import React, { createContext, useContext, useState, useEffect } from 'react';
import { useNavigate, useLocation } from 'react-router-dom';
import { jwtDecode } from 'jwt-decode'; 
import toast from 'react-hot-toast';
import apiClient from '../utils/apiClient'; 

const AuthContext = createContext(null);

export const AuthProvider = ({ children }) => {
  const [token, setToken] = useState(() => localStorage.getItem('authToken'));
  const [user, setUser] = useState(() => {
    const savedToken = localStorage.getItem('authToken');
    if (savedToken) {
      try {
        return jwtDecode(savedToken); 
      } catch (error) {
        console.error("Failed to decode token on load", error);
        localStorage.removeItem('authToken');
        return null;
      }
    }
    return null;
  });

  const navigate = useNavigate();

  // Sync token changes to localStorage
  useEffect(() => {
    if (token) {
      try {
        const decodedUser = jwtDecode(token);
        setUser(decodedUser);
        localStorage.setItem('authToken', token);
      } catch (error) {
        console.error("Invalid token", error);
        setToken(null);
        setUser(null);
        localStorage.removeItem('authToken');
      }
    } else {
      setUser(null);
      localStorage.removeItem('authToken');
    }
  }, [token]);

  // Handles redirecting the user based on their role
  const handleRedirect = (decodedUser) => {
    const { role, position } = decodedUser;

    // 1. Check Position (For Staff)
    if (position) {
      switch (position) {
        case 'F&B Admin':
          navigate('/admin');
          break;
        case 'Kitchen Staffs':
          navigate('/kitchen'); 
          break;
        case 'Cashier':
          navigate('/kitchen/pos'); 
          break;
        case 'Stock Controller':
          navigate('/kitchen/inventory'); 
          break;
        default:
          console.warn(`Unknown staff position: ${position}`);
          navigate('/kitchen'); 
      }
      return;
    }

    // 2. Check Role (For Customers)
    if (role === 'customer') {
      navigate('/');
      return;
    }

    navigate('/');
  };

  // ✅ NEW: URL Token Listener (Method 1: Auto-Login)
  // Checks if the user arrived via a link like http://localhost:5173/?token=XYZ...
  useEffect(() => {
    const params = new URLSearchParams(window.location.search);
    const urlToken = params.get('token');

    if (urlToken) {
        try {
            // 1. Verify the token is valid
            const decoded = jwtDecode(urlToken);

            // 2. Save it immediately
            setToken(urlToken);
            setUser(decoded);
            localStorage.setItem('authToken', urlToken);

            // 3. Clean the URL (Remove the token so it doesn't look messy)
            window.history.replaceState({}, document.title, window.location.pathname);

            // 4. Notify and Redirect
            toast.success(`Welcome back, ${decoded.firstName || 'Guest'}!`);
            handleRedirect(decoded);

        } catch (error) {
            console.error("Invalid URL token", error);
            toast.error("Invalid login link.");
        }
    }
  }, []); // Run once on mount

  // Login function
  const login = async (email, password) => {
    try {
      const response = await apiClient('/auth/login', {
        method: 'POST',
        body: JSON.stringify({ email, password }),
      });

      const data = await response.json();
      if (!response.ok) {
        throw new Error(data.message || 'Login failed');
      }

      setToken(data.token); 
      const decoded = jwtDecode(data.token);
      handleRedirect(decoded);
      
      toast.success('Logged in successfully!');
      return true;

    } catch (error) {
      toast.error(error.message);
      return false;
    }
  };

  // Register function
  const register = async (firstName, lastName, email, password, phone) => {
    try {
      const response = await apiClient('/auth/register', {
        method: 'POST',
        body: JSON.stringify({
          first_name: firstName,
          last_name: lastName,
          email,
          password,
          phone,
          role: 'customer', 
        }),
      });

      const data = await response.json();
      if (!response.ok) {
        throw new Error(data.message || 'Registration failed');
      }

      toast.success('Registration successful! Please log in.');
      return true;

    } catch (error) {
      toast.error(error.message);
      return false;
    }
  };

  // Logout function
  const logout = () => {
    setToken(null);
    navigate('/login');
    toast.success('Logged out.');
  };

  const value = {
    token,
    user,
    login,
    register,
    logout,
    isAuthenticated: !!token,
  };

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
};

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
};
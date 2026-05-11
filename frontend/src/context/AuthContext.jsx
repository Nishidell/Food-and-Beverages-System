import React, { createContext, useContext, useState, useEffect } from 'react';
import { useNavigate, useLocation } from 'react-router-dom';
import { jwtDecode } from 'jwt-decode'; 
import toast from 'react-hot-toast';
import apiClient from '../utils/apiClient'; 

const AuthContext = createContext(null);

// Helper to ensure the user object always has the required fields for the UI
const formatUser = (decodedToken) => {
  if (!decodedToken) return null;
  
  return {
    ...decodedToken,
    // Extract the name from the email (e.g., 'guest' from 'guest@gmail.com') if firstName is missing
    firstName: decodedToken.firstName || decodedToken.first_name || (decodedToken.email ? decodedToken.email.split('@')[0] : 'Guest'),
    lastName: decodedToken.lastName || decodedToken.last_name || '',
    role: decodedToken.role || 'customer',
    id: decodedToken.id || decodedToken.client_id
  };
};

export const AuthProvider = ({ children }) => {
  const [token, setToken] = useState(() => localStorage.getItem('authToken'));
  const [user, setUser] = useState(() => {
    const savedToken = localStorage.getItem('authToken');
    if (savedToken) {
      try {
       return formatUser(jwtDecode(savedToken)); 
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
        case 'General Manager':
        case 'Operation Manager':
          navigate('/admin');
          break;
        case 'Head Chef':
        case 'Assistant Chef':
          navigate('/kitchen'); 
          break;
        case 'Service Supervisor':
          navigate('/kitchen/waiter'); 
          break;
        case 'Finance Manager':
          navigate('/kitchen/cashier'); 
          break;
        case 'Inventory Manager':
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

 // ==========================================
  // ✅ UPGRADED: Universal URL Token Listener
  // ==========================================
  useEffect(() => {
    // Check both standard queries and hash fragments
    const urlParams = new URLSearchParams(window.location.search);
    const hashParams = new URLSearchParams(window.location.hash.replace('#', '?'));
    
    // Grab the token from whichever format the CRS team used
    const urlToken = 
        hashParams.get('token') || hashParams.get('sso_token') || 
        urlParams.get('token') || urlParams.get('sso_token');

    if (urlToken) {
        try {
            // 1. Verify and decode
            const decoded = jwtDecode(urlToken);

            // 2. Inject directly into React State and Local Storage
            setToken(urlToken);
            setUser(decoded);
            localStorage.setItem('authToken', urlToken);

            // 3. Clean the messy URL string silently
            window.history.replaceState({}, document.title, window.location.pathname);

            // 4. Welcome the guest and load the dashboard!
            toast.success(`Welcome back, ${decoded.firstName || 'Guest'}!`);
            handleRedirect(decoded);

        } catch (error) {
            console.error("Invalid URL token", error);
            toast.error("Invalid login link.");
        }
    }
  }, []); 
  // ==========================================

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

      const decoded = jwtDecode(data.token);
      
      setToken(data.token);           // 1. Set Token
      setUser(decoded);               // 2. Set User Data IMMEDIATELY
      localStorage.setItem('authToken', data.token); // 3. Save to Storage
      
      handleRedirect(decoded);        // 4. Navigate
      
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
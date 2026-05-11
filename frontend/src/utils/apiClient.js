// utils/apiClient.js

// 1. Define your base URL (adjust this to match your actual environment variable if needed)
const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:21917/api';

const apiClient = async (endpoint, customOptions = {}) => {
  // ==========================================
  // ✅ THE FIX: The Dynamic Token Grab
  // By placing this INSIDE the function, it checks the pocket 
  // fresh every single time a network request is made.
  // ==========================================
  const token = localStorage.getItem('authToken');

  // 2. Set up default headers
  const headers = {
    'Content-Type': 'application/json',
    ...customOptions.headers,
  };

  // 3. If a token was found in the pocket, attach it securely
  if (token) {
    headers['Authorization'] = `Bearer ${token}`;
  }

  // 4. Combine headers with any other options (like method: 'POST', body: ...)
  const config = {
    ...customOptions,
    headers,
  };

  // 5. Clean up the URL formatting
  const url = `${API_URL}${endpoint.startsWith('/') ? endpoint : `/${endpoint}`}`;

  // 6. Make the actual request
  try {
    const response = await fetch(url, config);
    
    // We return the raw response because your AuthContext 
    // handles the `!response.ok` checks and JSON parsing itself!
    return response; 
    
  } catch (error) {
    console.error("API Client Error:", error);
    throw error;
  }
};

export default apiClient;
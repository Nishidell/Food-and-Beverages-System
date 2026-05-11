// utils/apiClient.js

// 1. Grab the URL from Vercel (or use localhost)
let API_URL = import.meta.env.VITE_API_URL || 'http://localhost:21917/api';

if (!API_URL.endsWith('/api')) {
  // Remove trailing slash if it exists, then append /api
  API_URL = API_URL.replace(/\/$/, '') + '/api';
}

const apiClient = async (endpoint, customOptions = {}) => {
  // 2. Grab the fresh token every time
  const token = localStorage.getItem('authToken');

  const headers = {
    'Content-Type': 'application/json',
    ...customOptions.headers,
  };

  if (token) {
    headers['Authorization'] = `Bearer ${token}`;
  }

  const config = {
    ...customOptions,
    headers,
  };

  // 3. Build the safe URL
  const url = `${API_URL}${endpoint.startsWith('/') ? endpoint : `/${endpoint}`}`;

  try {
    const response = await fetch(url, config);
    return response; 
  } catch (error) {
    console.error("API Client Error:", error);
    throw error;
  }
};

export default apiClient;
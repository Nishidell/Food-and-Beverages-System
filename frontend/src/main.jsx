import React from "react";
import ReactDOM from "react-dom/client";
import { BrowserRouter } from 'react-router-dom';
import App from "./App.jsx";
import "./index.css";
import { AuthProvider } from "./context/AuthContext.jsx"; 
import { SocketProvider } from "./context/SocketContext.jsx";
import { CartProvider } from './context/CartContext';

ReactDOM.createRoot(document.getElementById("root")).render(
 // <React.StrictMode>
    <BrowserRouter>
      <AuthProvider> 
        <SocketProvider>
          <CartProvider>
        <App />
        </CartProvider>
        </SocketProvider>
      </AuthProvider>
    </BrowserRouter>
 // </React.StrictMode>
);
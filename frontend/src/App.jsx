import React, { useEffect } from 'react';
import { Toaster } from 'react-hot-toast';
import { Routes, Route, useLocation, useNavigate } from 'react-router-dom';
import Snowfall from 'react-snowfall';

// Import Pages
import MenuPage from './pages/Customer/MenuPage';
import AdminPage from './pages/Admin/AdminPage';
import KitchenPage from './pages/Kitchen/KitchenPage';
import WaiterPOS from './pages/Kitchen/WaiterPOS';
import ArchivePage from './pages/Kitchen/ArchivePage';
import TableManager from './pages/Kitchen/TableManager';
import LoginPage from './pages/Auth/LoginPage';
import RegisterPage from './pages/Auth/RegisterPage';
import NotAuthorizedPage from './pages/Auth/NotAuthorizedPage';
import DiningReservationPage from './pages/Customer/DiningReservationPage.jsx';

import PaymentSuccess from './pages/Customer/PaymentSuccess.jsx';
import PaymentCancel from './pages/Customer/PaymentCancel.jsx';
import InventoryPage from './pages/Kitchen/InventoryPage.jsx';
import MyOrdersPage from './pages/Customer/MyOrdersPage';
import CashierPage from './pages/Kitchen/CashierDashboard.jsx'; 
import ItemDetailsPage from './pages/Customer/ItemDetailsPage.jsx';

// Import Route Handlers
import GlobalRateLimitHandler from './components/GlobalRateLimitHandler'; 
import ProtectedRoute from './components/routing/ProtectedRoute';
import AuthRoute from './components/routing/AuthRoute';



function App() {
  const location = useLocation();
  const navigate = useNavigate();

  // --- SSO TOKEN CATCHER ---
  useEffect(() => {
    // 1. Scan the URL for the 'sso_token' parameter
    const searchParams = new URLSearchParams(location.search);
    const ssoToken = searchParams.get('sso_token');

    if (ssoToken) {
      // 2. Save it exactly where your normal F&B login saves it
      localStorage.setItem('authToken', ssoToken);
      
      // 3. Delete the token from the URL for security and a cleaner UI
      searchParams.delete('sso_token');
      
      // 4. Rebuild the URL without the token
      const cleanUrl = searchParams.toString() 
        ? `${location.pathname}?${searchParams.toString()}` 
        : location.pathname;
        
      // Force a hard reload so AuthContext wakes up and sees the new token
      window.location.replace(cleanUrl);
    }
  }, [location]); 

  // --- SEASONAL LOGIC ---
  // JavaScript months are 0-indexed (0 = Jan, 11 = Dec)
  const currentMonth = new Date().getMonth();
  const isDecember = currentMonth === 11; 
  
  // TIP: To test this if it's NOT December right now, uncomment the line below:
  // const isDecember = true; 

  return (
    <>
      {/* CONDITIONAL RENDERING:
        The Snowfall component only exists in the DOM if isDecember is true.
      */}
      {isDecember && (
        <Snowfall 
            color="#82C3D9"
            snowflakeCount={150}
            style={{
            position: 'fixed',
            width: '100vw',
            height: '100vh',
            zIndex: 50,
            pointerEvents: 'none',
            top: 0,
            left: 0,
          }}
        />
      )}

      <Toaster 
        position="top-center" 
        toastOptions={{
          duration: 3000,
          success: { duration: 2000 },
          error: { duration: 4000 },
        }}
      />
      
      {/* WRAPPER: Protects all routes from Rate Limiting */}
      <GlobalRateLimitHandler>
        <Routes>
          {/* === AUTH ROUTES (Only for guests) === */}
          <Route
            path="/login"
            element={
              <AuthRoute>
                <LoginPage />
              </AuthRoute>
            }
          />
          <Route path="/dining-reservation" element={<DiningReservationPage />} />
          <Route path="/not-authorized" element={<NotAuthorizedPage />} />

        {/*  MenuPage is now public (Guest Mode) */}
          <Route path="/" element={<MenuPage />} />
          <Route path="/item/:id" element={<ItemDetailsPage />} />
          
          <Route path="/payment-success" element={<PaymentSuccess />} />
          <Route path="/payment-cancel" element={<PaymentCancel />} />

          {/* === PROTECTED ROUTES (Login Required) === */}
          
         {/* Customer Protected Pages */}
          <Route
            path="/my-orders"
            element={
              <ProtectedRoute allowedRoles={['customer']}>
                <MyOrdersPage />
              </ProtectedRoute>
            }
          />

          {/* Admin Dashboard */}
          <Route
            path="/admin"
            element={
              <ProtectedRoute allowedRoles={['General Manager', 'Operations Manager']}>
                <AdminPage />
              </ProtectedRoute>
            }
          />

          {/* Kitchen Portal: Orders (KOD) */}
          <Route
            path="/kitchen"
            element={
              <ProtectedRoute allowedRoles={['General Manager', 'Operations Manager', 'Head Chef', 'Assistant Chef']}>
                <KitchenPage />
              </ProtectedRoute>
            }
          />

          {/* Kitchen Portal: Waiter POS */}
          <Route
            path="/kitchen/waiter"
            element={
              <ProtectedRoute allowedRoles={['General Manager', 'Operations Manager', 'Service Supervisor']}>
                <WaiterPOS />
              </ProtectedRoute>
            }
          />
          
          {/* POS: Cashier */}
          <Route
            path="/kitchen/cashier"
            element={
              <ProtectedRoute allowedRoles={['General Manager', 'Operations Manager', 'Finance Manager']}>
                <CashierPage />
              </ProtectedRoute>
            }
          />

          {/* Tables */}
          <Route
            path="/kitchen/tables"
            element={
              <ProtectedRoute allowedRoles={['General Manager', 'Operations Manager', 'Service Supervisor']}>
                <TableManager />
              </ProtectedRoute>
            }
          />

          {/* Inventory */}
          <Route
            path="/kitchen/inventory"
            element={
              <ProtectedRoute allowedRoles={['General Manager', 'Operations Manager', 'Inventory Manager']}>
                <InventoryPage />
              </ProtectedRoute>
            }
          />
          
          {/* Archive */}
          <Route
            path="/kitchen/archive"
            element={
              <ProtectedRoute allowedRoles={['General Manager', 'Operations Manager', 'Head Chef', 'Assistant Chef']}>
                <ArchivePage />
              </ProtectedRoute>
            }
          />

        </Routes>
      </GlobalRateLimitHandler>
    </>
  );
}

export default App;
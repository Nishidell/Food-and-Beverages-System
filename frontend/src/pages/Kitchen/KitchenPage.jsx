// frontend/src/pages/Kitchen/KitchenPage.jsx
import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import toast from 'react-hot-toast';

function KitchenPage() {
  const [kitchenOrders, setKitchenOrders] = useState([]);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(true);
  const [isPolling, setIsPolling] = useState(false);
  const [filterStatus, setFilterStatus] = useState('All');

  const fetchOrderDetails = async (orderId) => {
    try {
      const response = await fetch(`http://localhost:3000/api/orders/${orderId}`);
      if (!response.ok) {
        console.error(`Failed to fetch details for order ${orderId}`);
        return null;
      }
      return await response.json();
    } catch (err) {
      console.error(`Error fetching details for order ${orderId}:`, err);
      return null;
    }
  };

  const fetchAndPopulateOrders = async (isInitialLoad = false) => {
    if (!isInitialLoad && isPolling) return;
    if (isInitialLoad) setLoading(true);
    setIsPolling(true);
    setError(null);

    try {
      const listResponse = await fetch('http://localhost:3000/api/orders/kitchen');
      if (!listResponse.ok) {
        throw new Error('Failed to fetch kitchen orders list');
      }
      const ordersList = await listResponse.json();

      const ordersWithDetails = await Promise.all(
        ordersList.map(order => fetchOrderDetails(order.order_id))
      );
      
      const newOrders = ordersWithDetails.filter(order => order !== null);

      // --- THIS FIXES THE FLICKER ---
      // We only update the state if the data *actually* changed
      setKitchenOrders(prevOrders => {
        // Create simple strings of IDs and statuses to compare
        const prevDataString = JSON.stringify(prevOrders.map(o => ({ id: o.order_id, status: o.status })));
        const newDataString = JSON.stringify(newOrders.map(o => ({ id: o.order_id, status: o.status })));
        
        if (prevDataString !== newDataString) {
          return newOrders; // The data is different, update the state
        }
        return prevOrders; // The data is the same, do nothing (prevents flicker)
      });

    } catch (err) {
      setError(err.message);
    } finally {
      if (isInitialLoad) setLoading(false);
      setIsPolling(false);
    }
  };

  // --- THIS FIXES THE STATUS INCONSISTENCY ---
  const handleUpdateStatus = async (orderId, newStatus) => {
    try {
      // All statuses are sent as lowercase
      const response = await fetch(`http://localhost:3000/api/orders/${orderId}/status`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ status: newStatus.toLowerCase() }), // Send lowercase
      });

      if (!response.ok) {
        let errorMsg = `Failed to update status to ${newStatus}`;
        try { const errorData = await response.json(); errorMsg = errorData.message || errorMsg; } catch(e) {}
        throw new Error(errorMsg);
      }

      setKitchenOrders(currentOrders => {
        // Check for lowercase statuses
        if (newStatus.toLowerCase() === 'served' || newStatus.toLowerCase() === 'cancelled') {
          return currentOrders.filter(order => order.order_id !== orderId);
        } else {
          return currentOrders.map(order =>
            order.order_id === orderId ? { ...order, status: newStatus } : order
          );
        }
      });
      toast.success(`Order #${orderId} marked as ${newStatus}`);
    } catch (err) {
      console.error("Status update error:", err);
      toast.error(err.message);
    }
  };

  useEffect(() => {
    fetchAndPopulateOrders(true);
    const intervalId = setInterval(() => {
      fetchAndPopulateOrders(false);
    }, 5000);
    return () => clearInterval(intervalId);
  }, []);

  if (loading) {
    return <div className="p-8 text-center text-lg">Loading active orders...</div>;
  }

  if (error && kitchenOrders.length === 0) {
    return <div className="p-8 text-center text-red-500">Error: {error}</div>;
  }

  const filteredOrders = kitchenOrders.filter(order => {
    if (filterStatus === 'All') {
      return true;
    }
    return order.status.toLowerCase() === filterStatus.toLowerCase();
  });

  const FilterButton = ({ status }) => {
    const isActive = filterStatus.toLowerCase() === status.toLowerCase();
    const count = status === 'All' 
      ? kitchenOrders.length 
      : kitchenOrders.filter(o => o.status.toLowerCase() === status.toLowerCase()).length;

    return (
      <button
        onClick={() => setFilterStatus(status)}
        className={`py-2 px-4 rounded-md font-semibold text-sm transition-colors ${
          isActive 
            ? 'bg-figma-dark-green text-white' 
            : 'bg-white text-gray-700 hover:bg-gray-100'
        }`}
      >
        {status} ({count})
      </button>
    );
  };

  return (
    <div className="bg-figma-cream min-h-screen px-4 py-8">
      <div className="container mx-auto">
        <h1 className="text-3xl font-bold mb-6 text-center text-figma-dark-green">Kitchen Order Display</h1>

        <div className="flex justify-center gap-2 mb-6">
          <FilterButton status="All" />
          <FilterButton status="Pending" />
          <FilterButton status="Preparing" />
          <FilterButton status="Ready" />
          {/* Note: "Served" will not appear here as it's removed from the kitchenOrders list */}
        </div>

        {filteredOrders.length === 0 ? ( // <-- CHECK filteredOrders
          <p className="text-center text-gray-500 mt-10">
            {filterStatus === 'All' ? 'No active orders.' : `No ${filterStatus} orders.`}
          </p>
        ) : (
          <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
            {filteredOrders.map(order => ( // <-- MAP filteredOrders
              <div key={order.order_id} className="p-4 rounded-lg shadow-md bg-white flex flex-col h-full">
                <div className="mb-3 border-b pb-2">
                  <h2 className="font-bold text-lg text-figma-dark-green">Order #{order.order_id}</h2>
                  <p className="text-xs text-gray-500">Time: {new Date(order.order_date).toLocaleTimeString()}</p>
                  <p className="text-sm">Type: <span className="font-medium">{order.order_type}</span></p>
                  <p className="text-sm">Location: <span className="font-medium">{order.delivery_location}</span></p>
                  <p className="text-sm">Customer: <span className="font-medium">{order.first_name} {order.last_name}</span></p>
                </div>

                <div className="space-y-2 mb-3 flex-grow overflow-y-auto max-h-48 pr-1">
                  <h3 className="font-semibold text-figma-dark-green">Items:</h3>
                  {order.details && order.details.length > 0 ? (
                    order.details.map(item => (
                      <div key={item.detail_id} className="text-sm ml-2">
                        <span className="font-medium">{item.quantity} x</span> {item.item_name}
                        {item.instructions && <p className="text-xs text-gray-600 italic pl-4">- {item.instructions}</p>}
                      </div>
                    ))
                  ) : (
                    <p className="text-sm text-gray-500 ml-2">No item details found.</p>
                  )}
                </div>

                 {/* --- STATUS DISPLAY (standardized to lowercase) --- */}
                 <div className="text-center mb-3">
                   <span className={`py-1 px-3 rounded-full text-xs font-semibold ${
                        order.status.toLowerCase() === 'pending' ? 'bg-yellow-200 text-yellow-800' :
                        order.status.toLowerCase() === 'preparing' ? 'bg-blue-200 text-blue-800' :
                        order.status.toLowerCase() === 'ready' ? 'bg-green-200 text-green-800' :
                        'bg-gray-200 text-gray-800'
                      }`}
                    >
                      Status: {order.status}
                    </span>
                 </div>

                {/* --- ACTION BUTTONS (standardized to lowercase) --- */}
                <div className="mt-auto pt-4 border-t flex flex-col gap-2">
                  {order.status.toLowerCase() === 'pending' && (
                    <button
                      onClick={() => handleUpdateStatus(order.order_id, 'Preparing')}
                      className="bg-figma-light-green text-white py-2 px-4 rounded-md text-sm font-semibold hover:bg-opacity-90 transition-colors w-full"
                    >
                      Accept (Prepare)
                    </button>
                  )}
                  {order.status.toLowerCase() === 'preparing' && (
                    <button
                      onClick={() => handleUpdateStatus(order.order_id, 'Ready')}
                      className="bg-blue-500 text-white py-2 px-4 rounded-md text-sm font-semibold hover:bg-blue-600 transition-colors w-full"
                    >
                      Mark as Ready
                    </button>
                  )}
                  {order.status.toLowerCase() === 'ready' && (
                    <button
                      onClick={() => handleUpdateStatus(order.order_id, 'Served')}
                      className="bg-figma-orange text-white py-2 px-4 rounded-md text-sm font-semibold hover:bg-opacity-90 transition-colors w-full"
                    >
                      Mark as Served
                    </button>
                  )}
                  {(order.status.toLowerCase() === 'pending' || order.status.toLowerCase() === 'preparing' || order.status.toLowerCase() === 'ready') && (
                     <button
                      onClick={() => handleUpdateStatus(order.order_id, 'Cancelled')}
                      className="bg-red-500 text-white py-2 px-4 rounded-md text-sm font-semibold hover:bg-red-600 transition-colors w-full"
                    >
                      Cancel
                    </button>
                   )}
                </div>
              </div>
            ))}
          </div>
        )}
         <div className="mt-8 text-center">
           <Link to="/" className="text-blue-500 hover:underline">&larr; Back to Customer Menu</Link>
         </div>
      </div>
    </div>
  );
}

export default KitchenPage;
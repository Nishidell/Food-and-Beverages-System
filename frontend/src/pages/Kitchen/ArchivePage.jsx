import React, { useState, useEffect } from 'react';
import InternalNavBar from './components/InternalNavBar';
import { useAuth } from '../../context/AuthContext';
import apiClient from '../../utils/apiClient';
import './KitchenTheme.css'; // Import CSS

function ArchivePage() {
  const [servedOrders, setServedOrders] = useState([]);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(true);
  const { token } = useAuth();

  const fetchOrderDetails = async (orderId) => {
    try {
      const response = await apiClient(`/orders/${orderId}`); 
      if (!response.ok) return null;
      return await response.json();
    } catch (err) {
      return null;
    }
  };

  useEffect(() => {
    const fetchServedOrders = async () => {
      try {
        setLoading(true);
        const listResponse = await apiClient('/orders/served'); 
        if (!listResponse.ok) throw new Error('Failed to fetch served orders');
        const ordersList = await listResponse.json();

        const ordersWithDetails = await Promise.all(
          ordersList.map(order => fetchOrderDetails(order.order_id))
        );
        
        setServedOrders(ordersWithDetails.filter(order => order !== null));
      } catch (err) {
        if (err.message !== 'Session expired') setError(err.message);
      } finally {
        setLoading(false);
      }
    };
    if (token) fetchServedOrders();
  }, [token]);

  return (
    <>
      <InternalNavBar />
      <div className="kitchen-page">
        <div className="kitchen-container">
          <h1 className="kitchen-title">Served Orders Archive</h1>

          {loading ? (
            <div className="text-center text-white text-xl py-10">Loading archive...</div>
          ) : error ? (
            <div className="text-center text-red-500 text-xl py-10">Error: {error}</div>
          ) : servedOrders.length === 0 ? (
            <p className="text-center text-gray-400 text-lg py-10">No served orders found.</p>
          ) : (
            <div className="grid grid-cols-1 md:grid-cols-3 lg:grid-cols-4 gap-6">
              {servedOrders.map(order => (  
                <div key={order.order_id} className="kitchen-card">
                  <div className="kitchen-card-header">
                    <h2 className="text-xl font-bold text-[#3C2A21]">Order #{order.order_id}</h2>
                    <p className="text-xs text-gray-600">Time: {new Date(order.order_date).toLocaleString()}</p>
                  </div>

                  <div className="kitchen-card-body overflow-y-auto max-h-48">
                    <p><span className="info-label">Type:</span> {order.order_type}</p>
                    <p><span className="info-label">Loc:</span> {order.delivery_location}</p>
                    <div className="mt-2 border-t pt-2 border-gray-300">
                        <h3 className="font-bold text-sm">Items:</h3>
                        {order.items?.map(item => (
                            <div key={item.detail_id} className="text-sm">
                                <span className="font-bold">{item.quantity}x</span> {item.item_name}
                                {item.instructions && <span className="block text-xs italic text-red-500 ml-4">{item.instructions}</span>}
                            </div>
                        ))}
                    </div>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      </div>
    </>
  );
}

export default ArchivePage;
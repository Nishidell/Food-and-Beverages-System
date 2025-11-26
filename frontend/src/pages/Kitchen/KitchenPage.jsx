import React, { useState, useEffect } from 'react';
import toast from 'react-hot-toast';
import { Trash2, Clock, Package, CheckCircle, CheckCircle2 } from 'lucide-react';
import InternalNavBar from './components/InternalNavBar';
import apiClient from '../../utils/apiClient';
import './KitchenTheme.css'; // Import the CSS

function KitchenPage() {
  const [kitchenOrders, setKitchenOrders] = useState([]);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(true);
  const [isPolling, setIsPolling] = useState(false);
  const [filterStatus, setFilterStatus] = useState('All');
  const [filterType, setFilterType] = useState('All Types');
  const [servedCount, setServedCount] = useState(0);

  const fetchOrderDetails = async (orderId) => {
    try {
      const response = await apiClient(`/orders/${orderId}`);
      if (!response.ok) return null;
      return await response.json();
    } catch (err) {
      return null;
    }
  };

  const fetchAndPopulateOrders = async (isInitialLoad = false) => {
    if (!isInitialLoad && isPolling) return;
    if (isInitialLoad) setLoading(true);
    setIsPolling(true);
    setError(null);

    try {
      const [kitchenResponse, servedResponse] = await Promise.all([
        apiClient('/orders/kitchen'),
        apiClient('/orders/served')
      ]);

      if (!kitchenResponse.ok || !servedResponse.ok) throw new Error('Failed to fetch orders');

      const ordersList = await kitchenResponse.json();
      const servedList = await servedResponse.json();

      setServedCount(servedList.length);

      const ordersWithDetails = await Promise.all(
        ordersList.map(order => fetchOrderDetails(order.order_id))
      );

      setKitchenOrders(ordersWithDetails.filter(order => order !== null));
    } catch (err) {
       if (err.message !== 'Session expired') {
        setError(err.message);
        setKitchenOrders([]);
      }
    } finally {
      if (isInitialLoad) setLoading(false);
      setIsPolling(false);
    }
  };

  const handleUpdateStatus = async (orderId, newStatus) => {
    try {
      const response = await apiClient(`/orders/${orderId}/status`, {
        method: 'PUT',
        body: JSON.stringify({ status: newStatus.toLowerCase() }),
      });

      if (!response.ok) throw new Error("Failed to update status");

      setKitchenOrders(currentOrders => {
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
      toast.error(err.message);
    }
  };

  useEffect(() => {
    fetchAndPopulateOrders(true);
    const intervalId = setInterval(() => fetchAndPopulateOrders(false), 5000);
    return () => clearInterval(intervalId);
  }, []);

  const filteredOrders = kitchenOrders.filter(order => {
    const statusMatch = filterStatus === 'All' || order.status?.toLowerCase() === filterStatus.toLowerCase();
    const typeMatch = filterType === 'All Types' || order.order_type?.toLowerCase() === filterType.toLowerCase();
    return statusMatch && typeMatch;
  });

  const pendingCount = kitchenOrders.filter(o => o.status?.toLowerCase() === 'pending').length;
  const preparingCount = kitchenOrders.filter(o => o.status?.toLowerCase() === 'preparing').length;
  const readyCount = kitchenOrders.filter(o => o.status?.toLowerCase() === 'ready').length;

  const getStatusBadgeClass = (status) => {
    switch(status?.toLowerCase()) {
        case 'pending': return 'bg-yellow-200 text-yellow-800';
        case 'preparing': return 'bg-blue-200 text-blue-800';
        case 'ready': return 'bg-green-200 text-green-800';
        default: return 'bg-gray-200 text-gray-800';
    }
  };

  return (
    <>
    <InternalNavBar />
    <div className="kitchen-page">
      <div className="kitchen-container">
        <h1 className="kitchen-title">Kitchen Order Display</h1>

        {/* Summary Cards */}
        <div className="summary-grid">
            <div className="summary-box">
                <div><h3 className="font-bold text-sm uppercase">Pending</h3><p className="text-3xl font-bold">{pendingCount}</p></div>
                <div className="p-3 rounded-full bg-amber-500 text-white"><Clock size={24}/></div>
            </div>
            <div className="summary-box">
                <div><h3 className="font-bold text-sm uppercase">Preparing</h3><p className="text-3xl font-bold">{preparingCount}</p></div>
                <div className="p-3 rounded-full bg-blue-500 text-white"><Package size={24}/></div>
            </div>
            <div className="summary-box">
                <div><h3 className="font-bold text-sm uppercase">Ready</h3><p className="text-3xl font-bold">{readyCount}</p></div>
                <div className="p-3 rounded-full bg-green-500 text-white"><CheckCircle size={24}/></div>
            </div>
            <div className="summary-box">
                <div><h3 className="font-bold text-sm uppercase">Served</h3><p className="text-3xl font-bold">{servedCount}</p></div>
                <div className="p-3 rounded-full bg-gray-500 text-white"><CheckCircle2 size={24}/></div>
            </div>
        </div>

        {/* Filters */}
        <div className="filter-container">
            <div className="flex-1">
                <label className="block text-sm font-bold mb-1 text-[#F9A825]">Filter by Status</label>
                <select value={filterStatus} onChange={(e) => setFilterStatus(e.target.value)} className="w-full p-2 rounded border border-gray-300">
                    <option value="All">All</option>
                    <option value="Pending">Pending</option>
                    <option value="Preparing">Preparing</option>
                    <option value="Ready">Ready</option>
                </select>
            </div>
            <div className="flex-1">
                <label className="block text-sm font-bold mb-1 text-[#F9A825]">Filter by Type</label>
                <select value={filterType} onChange={(e) => setFilterType(e.target.value)} className="w-full p-2 rounded border border-gray-300">
                    <option value="All Types">All Types</option>
                    <option value="Dine-in">Dine-in</option>
                    <option value="Room Dining">Room Dining</option>
                    <option value="Walk-in">Walk-in</option>
                    <option value="Phone Order">Phone Order</option>
                </select>
            </div>
        </div>

        {loading ? (
            <div className="text-center text-white text-xl py-10">Loading active orders...</div>
        ) : filteredOrders.length === 0 ? (
            <div className="text-center text-gray-400 text-lg py-10">No orders found.</div>
        ) : (
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
                {filteredOrders.map(order => {
                    const instructions = order.items?.[0]?.instructions;
                    return (
                        <div key={order.order_id} className="kitchen-card">
                            <div className="kitchen-card-header relative">
                                <span className={`absolute top-4 right-4 px-3 py-1 rounded-full text-xs font-bold uppercase ${getStatusBadgeClass(order.status)}`}>
                                    {order.status}
                                </span>
                                <h2 className="text-xl font-bold text-gray-800">#{order.order_id}</h2>
                                <p className="text-sm text-gray-500">{new Date(order.order_date).toLocaleTimeString()}</p>
                            </div>
                            
                            <div className="kitchen-card-body">
                                <p><span className="info-label">Type:</span> {order.order_type}</p>
                                <p><span className="info-label">Loc:</span> {order.delivery_location}</p>
                                <p><span className="info-label">Name:</span> {order.first_name} {order.last_name}</p>
                                
                                <div className="mt-2 border-t pt-2">
                                    <p className="font-bold text-sm mb-1">Items:</p>
                                    {order.items?.map(item => (
                                        <div key={item.detail_id} className="mb-2">
                                            {/* Item Name & Quantity */}
                                            <div className="item-text font-medium">
                                                {item.quantity} x {item.item_name}
                                            </div>
                                            
                                            {/* --- FIX: Display Instruction Here --- */}
                                            {item.instructions && (
                                                <div className="text-xs text-red-600 italic ml-4 bg-red-50 px-1 rounded inline-block border border-red-100">
                                                    Note: {item.instructions}
                                                </div>
                                            )}
                                        </div>
                                    ))}
                                </div>
                                
                                {/* Remove the old "General Note" block from here since we removed general notes */}
                            </div>

                            <div className="kitchen-card-footer">
                                {order.status?.toLowerCase() === 'pending' && (
                                    <div className="flex gap-2">
                                        <button onClick={() => handleUpdateStatus(order.order_id, 'Preparing')} className="kitchen-btn btn-green flex-1">Accept</button>
                                        <button onClick={() => handleUpdateStatus(order.order_id, 'Cancelled')} className="kitchen-btn btn-red"><Trash2 size={18}/></button>
                                    </div>
                                )}
                                {order.status?.toLowerCase() === 'preparing' && (
                                    <div className="flex gap-2">
                                        <button onClick={() => handleUpdateStatus(order.order_id, 'Ready')} className="kitchen-btn btn-blue flex-1">Ready</button>
                                        <button onClick={() => handleUpdateStatus(order.order_id, 'Cancelled')} className="kitchen-btn btn-red"><Trash2 size={18}/></button>
                                    </div>
                                )}
                                {order.status?.toLowerCase() === 'ready' && (
                                    <button onClick={() => handleUpdateStatus(order.order_id, 'Served')} className="kitchen-btn btn-amber w-full">Served</button>
                                )}
                            </div>
                        </div>
                    );
                })}
            </div>
        )}
      </div>
    </div>
    </>
  );
}

export default KitchenPage;
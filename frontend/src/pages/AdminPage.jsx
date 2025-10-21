import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import MenuManagementTable from './MenuManagementTable';

// This component now contains the full table structure for orders.
const OrderManagementTable = ({ orders }) => (
  <div className="bg-white shadow-md rounded-lg overflow-hidden">
    <h2 className="text-2xl font-bold p-6">Order Management</h2>
    <table className="min-w-full leading-normal">
      <thead>
        <tr className="bg-gray-100 text-gray-600 uppercase text-sm leading-normal">
          <th className="py-3 px-6 text-left">Order ID</th>
          <th className="py-3 px-6 text-left">Customer ID</th>
          <th className="py-3 px-6 text-center">Total Amount</th>
          <th className="py-3 px-6 text-center">Status</th>
          <th className="py-3 px-6 text-left">Date</th>
        </tr>
      </thead>
      <tbody className="text-gray-600 text-sm font-light">
        {orders.map((order) => (
          <tr key={order.order_id} className="border-b border-gray-200 hover:bg-gray-50">
            <td className="py-3 px-6 text-left whitespace-nowrap">
              <span className="font-medium">{order.order_id}</span>
            </td>
            <td className="py-3 px-6 text-left">
              <span>{order.customer_id}</span>
            </td>
            <td className="py-3 px-6 text-center">
              <span className="font-medium">${parseFloat(order.total_amount).toFixed(2)}</span>
            </td>
            <td className="py-3 px-6 text-center">
              <span
                className={`py-1 px-3 rounded-full text-xs font-semibold ${
                  order.status === 'Pending' ? 'bg-yellow-200 text-yellow-800' :
                  order.status === 'Completed' ? 'bg-green-200 text-green-800' :
                  order.status === 'Cancelled' ? 'bg-red-200 text-red-800' :
                  'bg-gray-200 text-gray-800'
                }`}
              >
                {order.status}
              </span>
            </td>
            <td className="py-3 px-6 text-left">
              <span>{new Date(order.order_date).toLocaleString()}</span>
            </td>
          </tr>
        ))}
      </tbody>
    </table>
  </div>
);

function AdminPage() {
  const [orders, setOrders] = useState([]);
  const [menuItems, setMenuItems] = useState([]);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(true);
  const [currentView, setCurrentView] = useState('orders');

  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        const [ordersResponse, itemsResponse] = await Promise.all([
          fetch('http://localhost:3000/api/orders'),
          fetch('http://localhost:3000/api/items')
        ]);
        if (!ordersResponse.ok || !itemsResponse.ok) throw new Error('Failed to fetch data');
        const ordersData = await ordersResponse.json();
        const itemsData = await itemsResponse.json();
        setOrders(ordersData);
        setMenuItems(itemsData);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };
    fetchData();
  }, []);

  if (loading) return <div className="p-8">Loading dashboard...</div>;
  if (error) return <div className="p-8 text-red-500">Error: {error}</div>;

  return (
    <div className="container mx-auto px-4 py-8">
      <h1 className="text-3xl font-bold mb-4">Admin Dashboard</h1>
      <Link to="/" className="text-blue-500 hover:underline mb-8 block">&larr; Back to Menu</Link>
      
      <nav className="flex space-x-4 border-b mb-8">
        <button
          onClick={() => setCurrentView('orders')}
          className={`py-2 px-4 text-lg font-semibold transition-colors ${
            currentView === 'orders'
              ? 'border-b-2 border-orange-500 text-orange-500'
              : 'text-gray-500 hover:text-orange-500'
          }`}
        >
          Order Management
        </button>
        <button
          onClick={() => setCurrentView('menu')}
          className={`py-2 px-4 text-lg font-semibold transition-colors ${
            currentView === 'menu'
              ? 'border-b-2 border-orange-500 text-orange-500'
              : 'text-gray-500 hover:text-orange-500'
          }`}
        >
          Menu Management
        </button>
      </nav>

      <main>
        {currentView === 'orders' && <OrderManagementTable orders={orders} />}
        {currentView === 'menu' && <MenuManagementTable items={menuItems} />}
      </main>
    </div>
  );
}

export default AdminPage;
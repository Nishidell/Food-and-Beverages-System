import React, { useEffect, useState } from "react";
import { CircleDollarSign, ShoppingCart, Box, Armchair } from "lucide-react"; 
import { useNavigate } from "react-router-dom"; // ✅ Import useNavigate
import apiClient from "../../../utils/apiClient";
import { useSocket } from "../../../context/SocketContext";

// ✅ Accept onNavigate prop from AdminPage
const AdminDashboard = ({ onNavigate }) => {
  const navigate = useNavigate(); // ✅ Hook for URL navigation
  
  const [data, setData] = useState({
    summary: { totalSales: 0, salesGrowth: 0, activeOrders: 0, lowStock: 0, availableTables: 0, totalTables: 0, totalSeatingCapacity: 0 },
    recentOrders: [],
    stockAlerts: [],
  });
  const [loading, setLoading] = useState(true);
  
  const { socket } = useSocket();

  const fetchData = async () => {
    try {
      const res = await apiClient("/dashboard/summary");
      const json = await res.json();
      setData(json);
    } catch (err) {
      console.error("Failed to load dashboard data:", err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchData();

    if (socket) {
        socket.on('new-order', () => {
            console.log("💰 New Order! Updating Dashboard...");
            fetchData(); 
        });

        socket.on('order-status-updated', () => {
            fetchData();
        });

        socket.on('table-update', () => {
             console.log("🪑 Table Updated! Refreshing dashboard...");
             fetchData();
        });
    }

    return () => {
        if(socket) {
            socket.off('new-order');
            socket.off('order-status-updated');
            socket.off('table-update');
        }
    }
  }, [socket]);

  const { summary, recentOrders, stockAlerts } = data;

  // ✅ Common style for clickable cards
  const cardStyle = "bg-[#fff2e0] rounded-xl p-5 shadow-md border border-[#6e1a1a] cursor-pointer transition-transform hover:scale-105 hover:shadow-lg";

  if (loading) {
    return (
      <div className="min-h-screen bg-[#480c1b] p-6">
        {/* Skeleton Summary Cards */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 mb-10">
          {[1, 2, 3, 4].map((i) => (
            <div key={i} className="bg-[#fff2e0] rounded-xl p-5 shadow-md border border-[#6e1a1a] animate-pulse">
              <div className="h-7 w-7 bg-[#480c1b]/10 rounded-full mb-2"></div>
              <div className="h-4 bg-[#480c1b]/10 rounded w-1/2 mt-1 mb-2"></div>
              <div className="h-8 bg-[#480c1b]/10 rounded w-1/3 mt-2"></div>
            </div>
          ))}
        </div>

        {/* Skeleton Main Section */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
          {[1, 2].map((i) => (
            <div key={i} className="bg-[#fff2e0] rounded-xl shadow-lg p-5 animate-pulse">
              <div className="flex justify-between items-center mb-3">
                <div className="h-6 bg-[#480c1b]/10 rounded w-1/3"></div>
              </div>
              <div className="space-y-2 mt-4">
                {[1, 2, 3, 4].map((j) => (
                  <div key={j} className="flex justify-between items-center border-b border-[#480c1b]/10 py-3">
                    <div className="w-1/2">
                      <div className="h-4 bg-[#480c1b]/10 rounded w-1/2 mb-2"></div>
                      <div className="h-3 bg-[#480c1b]/10 rounded w-1/3"></div>
                    </div>
                    <div className="flex items-center gap-4 w-1/3 justify-end">
                      <div className="h-4 bg-[#480c1b]/10 rounded w-8"></div>
                      <div className="h-6 bg-[#480c1b]/10 rounded-full w-16"></div>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          ))}
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-[#480c1b] text-black p-6">
      {/* Summary Cards */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 mb-10">
        
        {/* Total Sales -> Switch to Analytics Tab */}
        <div 
            className={cardStyle}
            onClick={() => onNavigate('analytics')}
        >
          <div className="flex justify-between items-center mb-2">
            <CircleDollarSign className="text-orange-400" size={28} />
          </div>
          <h3 className="text-sm text-black">Total Sales Today</h3>
          <p className="text-3xl font-bold mt-1">
            ₱{summary.totalSales.toLocaleString()}
          </p>
        </div>

        {/* Active Orders -> Switch to Orders Tab */}
        <div 
            className={cardStyle}
            onClick={() => onNavigate('orders')}
        >
          <div className="flex justify-between items-center mb-2">
            <ShoppingCart className="text-blue-400" size={28} />
          </div>
          <h3 className="text-sm text-black">Active Orders</h3>
          <p className="text-3xl font-bold mt-1">{summary.activeOrders}</p>
        </div>

        {/* Low Stock -> Navigate to /kitchen/inventory URL */}
        <div 
            className={cardStyle}
            onClick={() => navigate('/kitchen/inventory')}
        >
          <div className="flex justify-between items-center mb-2">
            <Box className="text-red-400" size={28} />
            {summary.lowStock >= 3 ? (
              <span className="text-xs font-semibold text-red-300 animate-pulse">
                Action needed
              </span>
            ) : null}
          </div>
          <h3 className="text-sm text-black">Stock Alerts (Low & Out)</h3>
          <p className="text-3xl font-bold mt-1">{summary.lowStock}</p>
        </div>

        {/* Available Tables & Seating Capacity -> Switch to Tables Tab */}
        <div 
            className={cardStyle}
            onClick={() => onNavigate('tables')}
        >
          <div className="flex justify-between items-center mb-2">
            {/* You can keep the Armchair icon, it works for both concepts */}
            <Armchair className="text-green-600" size={28} />
          </div>
          <h3 className="text-sm text-black">Available Tables</h3>
          <div className="flex items-end gap-2">
            {/* Displaying Available / Total Tables as the main metric */}
            <p className="text-3xl font-bold mt-1">
              {summary.availableTables} <span className="text-2xl font-normal text-gray-500">/ {summary.totalTables}</span>
            </p>
          
          </div>
          {/* Added the small static indicator for Total Capacity below */}
          <p className="text-xs text-gray-500 mt-1">
            (Total Capacity: {summary.totalSeatingCapacity} Seats)
          </p>
        </div>
      </div>

      {/* Main Section */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
        {/* Recent Orders */}
        <div className="bg-[#fff2e0] text-black rounded-xl shadow-lg p-5">
          <div className="flex justify-between items-center mb-3">
            <h2 className="text-lg font-semibold">Recent Orders</h2>
          </div>
          {recentOrders.length > 0 ? (
            <ul>
              {recentOrders.map((order) => (
                <li
                  key={order.order_id}
                  className="flex justify-between items-center border-b border-gray-300 py-2 text-sm"
                >
                  <div>
                    <p className="font-semibold">ORD-{order.order_id}</p>
                    <p className="text-gray-600">
                      {order.order_type === 'Dine-in'
                        ? `Table: ${order.delivery_location}`
                        : `Order Type: ${order.order_type}`
                      }
                    </p>
                  </div>
                  <div className="flex items-center gap-4">
                    <span>₱{order.total_amount}</span>
                    <span
                      className={`px-2 py-1 rounded-full text-xs font-semibold ${
                        order.status === "preparing"
                          ? "bg-blue-200 text-blue-800"
                          : order.status === "ready"
                          ? "bg-green-200 text-green-800"
                          : order.status === "delivered"
                          ? "bg-purple-200 text-purple-800"
                          : "bg-yellow-200 text-yellow-800"
                      }`}
                    >
                      {order.status}
                    </span>
                  </div>
                </li>
              ))}
            </ul>
          ) : (
            <p className="text-gray-600 text-center">No recent orders</p>
          )}
        </div>

        {/* Stock Alerts */}
        <div className="bg-[#fff2e0] text-black rounded-xl shadow-lg p-5">
          <h2 className="text-lg font-semibold mb-3">Stock Alerts</h2>
          {stockAlerts.length > 0 ? (
            <ul>
              {stockAlerts.map((item) => {
                // Safely grab the stock value regardless of how the backend names it
                const stockValue = parseFloat(item.stock_level !== undefined ? item.stock_level : item.stock || 0);
                const isOut = stockValue <= 0;

                return (
                  <li
                    key={item.ingredient_id}
                    className="flex justify-between items-center border-b border-gray-300 py-2 text-sm"
                  >
                    <div>
                      <p className="font-semibold">{item.name}</p>
                      {/* Swapped supplier_name for actual stock count so admins see the numbers instantly */}
                      <p className="text-gray-600 text-xs font-bold">Current Stock: {stockValue}</p> 
                    </div>
                    <span
                      className={`px-3 py-1 rounded-full text-xs font-bold uppercase border ${
                        isOut
                          ? "bg-gray-200 text-gray-700 border-gray-300"
                          : "bg-red-100 text-red-700 border-red-200"
                      }`}
                    >
                      {isOut ? "Out of Stock" : "Low Stock"}
                    </span>
                  </li>
                );
              })}
            </ul>
          ) : (
            <p className="text-gray-600 text-center">No low-stock items</p>
          )}
        </div>
      </div>

      {/* Footer */}
      <div className="text-center mt-10 text-amber-400 font-semibold">
        The Celestia Hotel • 100 Pasado St. Villa Celestia, Flat Uno, Palawan, Philippines
      </div>
    </div>
  );
};

export default AdminDashboard;
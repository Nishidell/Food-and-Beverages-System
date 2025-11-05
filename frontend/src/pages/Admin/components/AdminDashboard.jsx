import React, { useEffect, useState } from "react";
import { CircleDollarSign, ShoppingCart, Box, Users } from "lucide-react";
import { useAuth } from "../../../context/AuthContext";
import apiClient from "../../../utils/apiClient";

const AdminDashboard = () => {
  const [summary, setSummary] = useState({
    totalSales: 0,
    activeOrders: 0,
    lowStock: 0,
    totalCustomers: 0,
  });
  const [recentOrders, setRecentOrders] = useState([]);
  const [stockAlerts, setStockAlerts] = useState([]);

  useEffect(() => {
    const fetchDashboardData = async () => {
      try {
        const [salesRes, ordersRes, stockRes, customersRes] = await Promise.all([
        apiClient("/dashboard/sales"),
        apiClient("/dashboard/orders"),
        apiClient("/dashboard/low-stock"),
        apiClient("/dashboard/customers"),
        ]);


        const salesData = await salesRes.json();
        const ordersData = await ordersRes.json();
        const stockData = await stockRes.json();
        const customersData = await customersRes.json();

        // Defensive fallbacks
        const safeOrders = Array.isArray(ordersData) ? ordersData : [];
        const safeStock = Array.isArray(stockData) ? stockData : [];
        const safeCustomers = Array.isArray(customersData) ? customersData : [];

        setSummary({
          totalSales: salesData?.totalSales || 0,
          activeOrders: safeOrders.filter(o => o.status !== "Completed").length,
          lowStock: safeStock.length,
          totalCustomers: safeCustomers.length,
        });

        setRecentOrders(safeOrders.slice(0, 5));
        setStockAlerts(safeStock);
      } catch (err) {
        console.error("Failed to load dashboard data:", err);
      }
    };

    fetchDashboardData();
  }, []);

  return (
    <div className="min-h-screen bg-[#4b0a0a] text-white p-6">
      {/* Summary Cards */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6 mb-10">
        {/* Total Sales */}
        <div className="bg-[#5c0e0e] rounded-xl p-5 shadow-md border border-[#6e1a1a]">
          <div className="flex justify-between items-center mb-2">
            <CircleDollarSign className="text-orange-400" size={28} />
            <span className="text-green-400 text-xs font-semibold">+12.5%</span>
          </div>
          <h3 className="text-sm text-gray-300">Total Sales Today</h3>
          <p className="text-3xl font-bold mt-1">
            ₱{summary.totalSales.toLocaleString()}
          </p>
        </div>

        {/* Active Orders */}
        <div className="bg-[#5c0e0e] rounded-xl p-5 shadow-md border border-[#6e1a1a]">
          <div className="flex justify-between items-center mb-2">
            <ShoppingCart className="text-blue-400" size={28} />
            <span className="text-yellow-300 text-xs font-semibold">
              2 pending
            </span>
          </div>
          <h3 className="text-sm text-gray-300">Active Orders</h3>
          <p className="text-3xl font-bold mt-1">{summary.activeOrders}</p>
        </div>

        {/* Low Stock */}
        <div className="bg-[#5c0e0e] rounded-xl p-5 shadow-md border border-[#6e1a1a]">
          <div className="flex justify-between items-center mb-2">
            <Box className="text-red-400" size={28} />
            <span className="text-red-300 text-xs font-semibold">
              Action needed
            </span>
          </div>
          <h3 className="text-sm text-gray-300">Low Stock Items</h3>
          <p className="text-3xl font-bold mt-1">{summary.lowStock}</p>
        </div>

        {/* Customers */}
        <div className="bg-[#5c0e0e] rounded-xl p-5 shadow-md border border-[#6e1a1a]">
          <div className="flex justify-between items-center mb-2">
            <Users className="text-green-400" size={28} />
            <span className="text-green-300 text-xs font-semibold">+8.2%</span>
          </div>
          <h3 className="text-sm text-gray-300">Total Customers</h3>
          <p className="text-3xl font-bold mt-1">{summary.totalCustomers}</p>
        </div>
      </div>

      {/* Main Section */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
        {/* Recent Orders */}
        <div className="bg-[#fff2e0] text-black rounded-xl shadow-lg p-5">
          <div className="flex justify-between items-center mb-3">
            <h2 className="text-lg font-semibold">Recent Orders</h2>
            <button className="text-sm text-orange-600 hover:underline">
              View All
            </button>
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
                    <p className="text-gray-600">{order.room || order.table}</p>
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
          {Array.isArray(stockAlerts) && stockAlerts.length > 0 ? (
            <ul>
              {stockAlerts.map((item) => (
                <li
                  key={item.ingredient_id || item.id}
                  className="flex justify-between items-center border-b border-gray-300 py-2 text-sm"
                >
                  <div>
                    <p className="font-semibold">{item.name}</p>
                    <p className="text-gray-600">{item.supplier_name}</p>
                  </div>
                  <span
                    className={`px-2 py-1 rounded-full text-xs font-semibold ${
                      item.stock === 0
                        ? "bg-red-200 text-red-800"
                        : "bg-orange-200 text-orange-800"
                    }`}
                  >
                    {item.stock === 0 ? "out-of-stock" : "low-stock"}
                  </span>
                </li>
              ))}
            </ul>
          ) : (
            <p className="text-gray-600 text-center">No low-stock items</p>
          )}
          <button className="mt-4 w-full bg-[#5b0c0c] text-white py-2 rounded-md hover:bg-[#6e1212] transition">
            Create Purchase Order
          </button>
        </div>
      </div>

      {/* Footer */}
      <div className="text-center mt-10 text-amber-400 font-semibold">
        Celestia Hotel • Quezon City
      </div>
    </div>
  );
};

export default AdminDashboard;

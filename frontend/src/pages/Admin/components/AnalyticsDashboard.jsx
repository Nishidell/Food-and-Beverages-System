import React, { useState, useEffect } from "react";
import { useAuth } from "../../../context/AuthContext";
import apiClient from "../../../utils/apiClient";
import toast from "react-hot-toast";
import {
  ResponsiveContainer,
  BarChart,
  Bar,
  PieChart,
  Pie,
  Cell,
  LineChart,
  Line,
  XAxis,
  YAxis,
  Tooltip,
  Legend,
  CartesianGrid,
} from "recharts";
import '../AdminTheme.css'; // Import the Theme

// Helper: PHP currency format
const formatCurrency = (amount) =>
  new Intl.NumberFormat("en-PH", {
    style: "currency",
    currency: "PHP",
  }).format(amount || 0);

// THEME COLORS: [Dark Brown, Gold, Light Brown, Cream-Darker, Accent Red]
const THEME_COLORS = ["#3C2A21", "#F9A825", "#8D6E63", "#D1C0B6", "#EF4444"];

const AnalyticsDashboard = () => {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const { token } = useAuth();

  useEffect(() => {
    const fetchAnalytics = async () => {
      setLoading(true);
      try {
        const response = await apiClient("/analytics");
        if (!response.ok) throw new Error("Failed to fetch analytics data.");
        const result = await response.json();
        setData(result);
      } catch (err) {
        if (err.message !== "Session expired") {
          setError(err.message);
          toast.error(err.message);
        }
      } finally {
        setLoading(false);
      }
    };
    if (token) fetchAnalytics();
  }, [token]);

  if (loading) return <div className="p-8 text-center text-white text-lg">Loading analytics...</div>;
  if (error) return <div className="p-8 text-center text-red-500">Error: {error}</div>;
  if (!data) return <div className="p-8 text-center text-white">No data available.</div>;

  // --- Chart Data Preparation ---
  const salesTrendData = [
    { name: "Today", sales: data.salesTrends.today.sales },
    { name: "Yesterday", sales: data.salesTrends.yesterday.sales },
    { name: "This Week", sales: data.salesTrends.thisWeek.sales },
    { name: "This Month", sales: data.salesTrends.thisMonth.sales },
  ];

  const orderTypeData = data.orderTypeDistribution.map((o) => ({
    name: o.order_type,
    value: o.orders,
  }));

  const paymentMethodData = (data.paymentMethods || []).map((method) => ({
    name: method.payment_method,
    value: Number(method.total_value) || 0,
  }));

  const topItemsData = data.topSellingItems.map((i) => ({
    name: i.item_name,
    sold: i.total_sold,
    sales: i.total_sales,
  }));

  return (
    <div className="admin-section-container grid grid-cols-1 lg:grid-cols-2 gap-6">
      
      {/* Sales Trend Chart */}
      <div className="admin-card">
        <h3 className="text-xl font-bold mb-4" style={{color: '#3C2A21'}}>Sales Trends</h3>
        <ResponsiveContainer width="100%" height={300}>
          <LineChart data={salesTrendData}>
            <CartesianGrid strokeDasharray="3 3" stroke="#D1C0B6" />
            <XAxis dataKey="name" stroke="#3C2A21" />
            <YAxis stroke="#3C2A21" />
            <Tooltip 
                formatter={(val) => formatCurrency(val)} 
                contentStyle={{ backgroundColor: '#fff2e0', borderColor: '#D1C0B6', color: '#3C2A21' }}
            />
            <Legend />
            <Line
              type="monotone"
              dataKey="sales"
              stroke="#F9A825" // Gold Line
              strokeWidth={3}
              activeDot={{ r: 8, fill: '#3C2A21' }}
            />
          </LineChart>
        </ResponsiveContainer>
      </div>

      {/* Order Type Distribution */}
      <div className="admin-card flex flex-col">
        <h3 className="text-xl font-bold mb-4" style={{color: '#3C2A21'}}>Order Type Distribution</h3>
        <div className="flex-1 flex items-center justify-center">
            <ResponsiveContainer width="100%" height={300}>
            <PieChart>
                <Pie
                data={orderTypeData}
                dataKey="value"
                nameKey="name"
                outerRadius={100}
                label
                >
                {orderTypeData.map((_, i) => (
                    <Cell key={i} fill={THEME_COLORS[i % THEME_COLORS.length]} />
                ))}
                </Pie>
                <Tooltip contentStyle={{ backgroundColor: '#fff2e0', borderColor: '#D1C0B6', color: '#3C2A21' }} />
                <Legend />
            </PieChart>
            </ResponsiveContainer>
        </div>
        <div className="mt-4 p-4 rounded-lg text-center" style={{ backgroundColor: '#3C2A21', color: '#F9A825' }}>
            <span className="text-2xl font-bold block">{data.peakHour}</span>
            <span className="text-sm opacity-90 text-white">Peak Hours</span>
        </div>
      </div>

      {/* Top Selling Items */}
      <div className="admin-card">
        <h3 className="text-xl font-bold mb-4" style={{color: '#3C2A21'}}>Top Selling Items</h3>
        <ResponsiveContainer width="100%" height={300}>
          <BarChart data={topItemsData}>
            <CartesianGrid strokeDasharray="3 3" stroke="#D1C0B6" />
            <XAxis dataKey="name" stroke="#3C2A21" />
            <YAxis stroke="#3C2A21" />
            <Tooltip 
                formatter={(val) => formatCurrency(val)} 
                contentStyle={{ backgroundColor: '#fff2e0', borderColor: '#D1C0B6', color: '#3C2A21' }}
            />
            <Bar dataKey="sales" fill="#3C2A21" radius={[4, 4, 0, 0]} />
          </BarChart>
        </ResponsiveContainer>
      </div>

      {/* Payment Methods */}
      <div className="admin-card">
        <h3 className="text-xl font-bold mb-4" style={{color: '#3C2A21'}}>Payment Methods</h3>
        {paymentMethodData.length === 0 ? (
            <div className="h-64 flex items-center justify-center text-gray-500">
            No payment data available.
            </div>
        ) : (
            <ResponsiveContainer width="100%" height={300}>
            <PieChart>
                <Pie
                data={paymentMethodData}
                dataKey="value"
                nameKey="name"
                outerRadius={100}
                label
                >
                {paymentMethodData.map((_, i) => (
                    <Cell key={i} fill={THEME_COLORS[i % THEME_COLORS.length]} />
                ))}
                </Pie>
                <Tooltip 
                    formatter={(val) => `₱${val.toLocaleString()}`} 
                    contentStyle={{ backgroundColor: '#fff2e0', borderColor: '#D1C0B6', color: '#3C2A21' }}
                />
                <Legend />
            </PieChart>
            </ResponsiveContainer>
        )}
      </div>
    </div>
  );
};

export default AnalyticsDashboard;
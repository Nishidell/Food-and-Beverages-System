import React, { useState } from "react";
import * as XLSX from "xlsx"; 
import { Download, Calendar } from "lucide-react"; 
import toast from "react-hot-toast"; 
import '../AdminTheme.css';

const OrderManagement = ({ orders }) => {
  // --- HELPERS ---
  const getTodayStr = () => new Date().toLocaleDateString('en-CA');
  const getStartOfWeek = (date) => {
    const d = new Date(date);
    const day = d.getDay(); 
    const diff = d.getDate() - day + (day === 0 ? -6 : 1); 
    return new Date(d.setDate(diff)).toLocaleDateString('en-CA');
  };
  const getStartOfMonth = (date) => {
    const d = new Date(date);
    return new Date(d.getFullYear(), d.getMonth(), 1).toLocaleDateString('en-CA');
  };
  const fixDate = (dateInput) => {
      if (!dateInput) return new Date();
      const dateStr = typeof dateInput === 'string' ? dateInput : new Date(dateInput).toISOString();
      if (dateStr.includes(' ') && !dateStr.includes('T')) return new Date(dateStr.replace(' ', 'T') + 'Z');
      if (dateStr.includes('T') && !dateStr.endsWith('Z') && !dateStr.includes('+')) return new Date(dateStr + 'Z');
      return new Date(dateStr);
  };
  const getLocalDatePart = (dateObj) => new Date(dateObj).toLocaleDateString('en-CA');

  const [quickFilter, setQuickFilter] = useState('Today');
  const [startDate, setStartDate] = useState(getTodayStr());
  const [endDate, setEndDate] = useState(getTodayStr());

  const handleQuickFilterChange = (e) => {
    const filter = e.target.value;
    setQuickFilter(filter);
    const today = new Date();
    const endStr = getTodayStr();
    let startStr = endStr;

    if (filter === 'Today') { startStr = endStr; }
    else if (filter === 'Yesterday') {
        const yesterday = new Date(today);
        yesterday.setDate(yesterday.getDate() - 1);
        startStr = yesterday.toLocaleDateString('en-CA');
        setStartDate(startStr); setEndDate(startStr); return;
    } else if (filter === 'This Week') { startStr = getStartOfWeek(today); }
    else if (filter === 'This Month') { startStr = getStartOfMonth(today); }
    else if (filter === 'Custom') { return; }

    if (filter !== 'Custom') { setStartDate(startStr); setEndDate(endStr); }
  };

  const filteredOrders = orders.filter((order) => {
    if (!startDate && !endDate) return true;
    const orderDateObj = fixDate(order.order_date || order.created_at);
    const orderDateStr = getLocalDatePart(orderDateObj);
    return orderDateStr >= startDate && orderDateStr <= endDate;
  });

  const handleExportOrders = () => {
    if (filteredOrders.length === 0) { toast.error("No orders to export."); return; }
    const dataToExport = filteredOrders.map(order => ({
      'Order ID': order.order_id,
      'Customer Name': (order.first_name || order.last_name) ? `${order.first_name} ${order.last_name}` : 'Guest',
      'Order Type': order.order_type,
      'Location': order.delivery_location,
      'Date': fixDate(order.order_date).toLocaleString(),
      'Status': order.status,
      'Total Amount': Number(order.total_amount || 0)
    }));
    const worksheet = XLSX.utils.json_to_sheet(dataToExport, { origin: "A4" });
    const title = [{ v: "ORDER MANAGEMENT REPORT", t: "s" }];
    const rangeText = `Filter: ${quickFilter} (${startDate} to ${endDate})`;
    const dateInfo = [{ v: `Generated: ${new Date().toLocaleString()} | ${rangeText}`, t: "s" }];
    XLSX.utils.sheet_add_aoa(worksheet, [title, dateInfo], { origin: "A1" });
    const totalRevenue = dataToExport.reduce((acc, curr) => acc + curr['Total Amount'], 0);
    const totalRow = { 'Order ID': "TOTALS:", 'Total Amount': totalRevenue };
    XLSX.utils.sheet_add_json(worksheet, [totalRow], { origin: -1, skipHeader: true });
    const workbook = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(workbook, worksheet, "Orders");
    XLSX.writeFile(workbook, `Order_Report_${getTodayStr()}.xlsx`);
    toast.success("Order report downloaded!");
  };

  return (
    <div className="w-full">
      {/* 1. HEADER ROW (Title Left, Filters Right) */}
      <div className="flex flex-col sm:flex-row justify-between items-center gap-4 mb-6">
        <div>
            <h2 className="admin-page-title mb-1">Order Management</h2>
            <p className="text-sm text-gray-300">Track and manage customer orders</p>
        </div>
        
        <div className="flex flex-wrap items-center gap-4 justify-end">
            {/* Date Filter Dropdown */}
            <div className="relative">
                <select 
                    value={quickFilter} 
                    onChange={handleQuickFilterChange} 
                    className="admin-select-primary appearance-none pr-10" 
                    style={{ minWidth: '150px' }}
                >
                    <option value="Today">Today</option>
                    <option value="Yesterday">Yesterday</option>
                    <option value="This Week">This Week</option>
                    <option value="This Month">This Month</option>
                    <option value="Custom">Custom</option>
                </select>
                <div className="absolute right-3 top-1/2 transform -translate-y-1/2 pointer-events-none text-[#3C2A21]">
                    <Calendar size={18} />
                </div>
            </div>

            {/* Custom Range Inputs (Show only if Custom) */}
            {quickFilter === 'Custom' && (
                <div className="flex items-center gap-2 animate-fadeIn bg-[#fff2e0] p-1 rounded-lg border border-[#6e1a1a]">
                    <input type="date" value={startDate} onChange={(e) => setStartDate(e.target.value)} max={endDate} className="admin-input-date h-10"/>
                    <span className="text-gray-700 font-bold">-</span>
                    <input type="date" value={endDate} onChange={(e) => setEndDate(e.target.value)} min={startDate} className="admin-input-date h-10"/>
                </div>
            )}

            {/* Export Button */}
            <button onClick={handleExportOrders} className="admin-btn admin-btn-primary">
                <Download size={20} /> Export List
            </button>
        </div>
      </div>

      {/* 3. TABLE CARD */}
      <div className="admin-table-container"> 
        <table className="admin-table">
          <thead>
            <tr>
              <th>Order ID</th>
              <th>Customer Name</th>
              <th>Type</th>
              <th>Location</th>
              <th className="text-center">Total</th>
              <th className="text-center">Status</th>
              <th>Date</th>
            </tr>
          </thead>
          <tbody>
            {filteredOrders.length > 0 ? (
              filteredOrders.map((order) => (
                <tr key={order.order_id}>
                  <td className="font-medium">{order.order_id}</td>
                  <td>{order.first_name || order.last_name ? `${order.first_name} ${order.last_name}` : 'Guest'}</td>
                  <td>{order.order_type}</td>
                  <td>{order.delivery_location}</td>
                  <td className="text-center font-bold">₱{parseFloat(order.total_amount || 0).toFixed(2)}</td>
                  <td className="text-center">
                    <span className={`status-badge ${
                        order.status === 'pending' ? 'bg-yellow-200 text-yellow-800' :
                        order.status === 'served' ? 'bg-green-200 text-green-800' :
                        order.status === 'cancelled' ? 'bg-red-200 text-red-800' :
                        'bg-gray-200 text-gray-800'
                      }`}
                    >
                      {order.status}
                    </span>
                  </td>
                  <td>{fixDate(order.order_date).toLocaleString()}</td>
                </tr>
              ))
            ) : (
              <tr><td colSpan="7" className="text-center p-8 text-gray-500">No orders found.</td></tr>
            )}
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default OrderManagement;
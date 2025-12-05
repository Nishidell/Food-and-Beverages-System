import React, { useState } from "react";
import * as XLSX from "xlsx"; // ✅ Import for Excel
import { Download, Calendar } from "lucide-react"; // ✅ Icons
import toast from "react-hot-toast"; // ✅ For notifications
import '../AdminTheme.css';

const OrderManagement = ({ orders }) => {
  // 1. Add State for Filters
  const [startDate, setStartDate] = useState("");
  const [endDate, setEndDate] = useState("");

  // 2. LOGIC: Filter orders by Date Range
  const filteredOrders = orders.filter((order) => {
    // Show all if no dates selected
    if (!startDate && !endDate) return true; 

    // Parse order date (Support 'order_date' or 'created_at')
    const orderDate = new Date(order.order_date || order.created_at).getTime();
    
    // Set start time to 00:00:00 and end time to 23:59:59
    const start = startDate ? new Date(startDate).setHours(0, 0, 0, 0) : null;
    const end = endDate ? new Date(endDate).setHours(23, 59, 59, 999) : null;

    if (start && end) return orderDate >= start && orderDate <= end;
    if (start) return orderDate >= start;
    if (end) return orderDate <= end;
    return true;
  });

  // 3. LOGIC: Export Filtered Orders to Excel
  const handleExportOrders = () => {
    if (filteredOrders.length === 0) {
      toast.error("No orders to export.");
      return;
    }

    // A. Format data for Excel
    const dataToExport = filteredOrders.map(order => ({
      'Order ID': order.order_id,
      'Customer Name': (order.first_name || order.last_name) ? `${order.first_name} ${order.last_name}` : 'Guest',
      'Order Type': order.order_type,
      'Location': order.delivery_location,
      'Date': new Date(order.order_date).toLocaleString(),
      'Status': order.status,
      'Total Amount': Number(order.total_amount || 0) // Ensure number for auto-sum
    }));

    // B. Create Sheet
    const worksheet = XLSX.utils.json_to_sheet(dataToExport, { origin: "A4" });

    // C. Add Header (Title & Date)
    const title = [{ v: "ORDER MANAGEMENT REPORT", t: "s" }];
    let rangeText = "All Orders";
    if (startDate || endDate) {
       rangeText = `Filter: ${startDate || 'Start'} to ${endDate || 'Now'}`;
    }
    const dateInfo = [{ v: `Generated: ${new Date().toLocaleString()} | ${rangeText}`, t: "s" }];
    
    XLSX.utils.sheet_add_aoa(worksheet, [title, dateInfo], { origin: "A1" });

    // D. Add Totals Row
    const totalRevenue = dataToExport.reduce((acc, curr) => acc + curr['Total Amount'], 0);
    const totalRow = {
      'Order ID': "TOTALS:",
      'Total Amount': totalRevenue
    };
    XLSX.utils.sheet_add_json(worksheet, [totalRow], { origin: -1, skipHeader: true });

    // E. Download
    const workbook = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(workbook, worksheet, "Orders");
    XLSX.writeFile(workbook, `Order_Report_${new Date().toISOString().split('T')[0]}.xlsx`);
    toast.success("Order report downloaded!");
  };

  return (
    <div className="admin-section-container">
              <h2 className="admin-page-title p-6">Order Management</h2>
      <div className="admin-table-container">

        {/* --- 4. FILTER & EXPORT CONTROLS --- */}
        <div className="flex flex-col md:flex-row justify-between items-center mb-6 gap-4 bg-[#fff2e0] p-4 mx-6 rounded-lg border border-[#D1C0B6]">
          
          {/* Date Filters */}
          <div className="flex items-center gap-2 flex-wrap">
            <div className="flex items-center gap-2 bg-white px-3 py-2 rounded border border-[#D1C0B6]">
              <Calendar size={18} className="text-[#3C2A21]" />
              <span className="text-sm font-bold text-[#3C2A21]">From:</span>
              <input 
                type="date" 
                value={startDate} 
                onChange={(e) => setStartDate(e.target.value)}
                className="outline-none text-[#3C2A21] bg-transparent cursor-pointer text-sm"
              />
            </div>
            
            <div className="flex items-center gap-2 bg-white px-3 py-2 rounded border border-[#D1C0B6]">
              <span className="text-sm font-bold text-[#3C2A21]">To:</span>
              <input 
                type="date" 
                value={endDate} 
                onChange={(e) => setEndDate(e.target.value)}
                className="outline-none text-[#3C2A21] bg-transparent cursor-pointer text-sm"
              />
            </div>

            {/* Clear Button */}
            {(startDate || endDate) && (
              <button 
                onClick={() => { setStartDate(""); setEndDate(""); }}
                className="text-sm text-red-500 hover:text-red-700 underline font-medium ml-2"
              >
                Clear
              </button>
            )}
          </div>

          {/* Export Button */}
          <button
            onClick={handleExportOrders}
            className="flex items-center gap-2 px-5 py-2.5 rounded-lg font-bold shadow-md hover:scale-105 transition-transform"
            style={{ backgroundColor: '#F9A825', color: '#3C2A21' }}
          >
            <Download size={18} />
            Export List
          </button>
        </div>

        {/* --- 5. TABLE (Updated to use filteredOrders) --- */}
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
                  <td>
                    {order.first_name || order.last_name ? `${order.first_name} ${order.last_name}` : 'Guest'}
                  </td>
                  <td>{order.order_type}</td>
                  <td>{order.delivery_location}</td>
                  <td className="text-center font-bold">
                    ₱{parseFloat(order.total_amount || 0).toFixed(2)}
                  </td>
                  <td className="text-center">
                    <span
                      className={`status-badge ${
                        order.status === 'Pending' ? 'bg-yellow-200 text-yellow-800' :
                        order.status === 'Completed' ? 'bg-green-200 text-green-800' :
                        order.status === 'Cancelled' ? 'bg-red-200 text-red-800' :
                        'bg-gray-200 text-gray-800'
                      }`}
                    >
                      {order.status}
                    </span>
                  </td>
                  <td>{new Date(order.order_date).toLocaleString()}</td>
                </tr>
              ))
            ) : (
              <tr>
                <td colSpan="7" className="text-center p-8 text-gray-500">
                  No orders found for the selected date range.
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default OrderManagement;
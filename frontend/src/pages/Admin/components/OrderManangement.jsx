import React, { useState } from "react";
import * as XLSX from "xlsx";
import { Download, Calendar } from "lucide-react";
import toast from "react-hot-toast";
import apiClient from "../../../utils/apiClient";
import "../AdminTheme.css";

const OrderManagement = ({ orders }) => {
  // ==========================================
  // 1. DATE HELPERS
  // ==========================================
  const getTodayStr = () => new Date().toLocaleDateString("en-CA");

  const getStartOfWeek = (date) => {
    const d = new Date(date);
    const day = d.getDay();
    const diff = d.getDate() - day + (day === 0 ? -6 : 1);
    return new Date(d.setDate(diff)).toLocaleDateString("en-CA");
  };

  const getStartOfMonth = (date) => {
    const d = new Date(date);
    return new Date(d.getFullYear(), d.getMonth(), 1).toLocaleDateString("en-CA");
  };

  const fixDate = (dateInput) => {
    if (!dateInput) return new Date();
    const dateStr = typeof dateInput === "string" ? dateInput : new Date(dateInput).toISOString();
    if (dateStr.includes(" ") && !dateStr.includes("T")) return new Date(dateStr.replace(" ", "T") + "Z");
    if (dateStr.includes("T") && !dateStr.endsWith("Z") && !dateStr.includes("+")) return new Date(dateStr + "Z");
    return new Date(dateStr);
  };

  const getLocalDatePart = (dateObj) => new Date(dateObj).toLocaleDateString("en-CA");

  // ==========================================
  // 2. STATE MANAGEMENT
  // ==========================================
  const [quickFilter, setQuickFilter] = useState("Today");
  const [startDate, setStartDate] = useState(getTodayStr());
  const [endDate, setEndDate] = useState(getTodayStr());

  // Modal State
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [selectedOrderId, setSelectedOrderId] = useState(null);
  const [selectedOrderDetails, setSelectedOrderDetails] = useState(null);
  const [isLoadingDetails, setIsLoadingDetails] = useState(false);

  // ==========================================
  // 3. FILTERING LOGIC
  // ==========================================
  const handleQuickFilterChange = (e) => {
    const filter = e.target.value;
    setQuickFilter(filter);
    
    const today = new Date();
    const endStr = getTodayStr();
    let startStr = endStr;

    if (filter === "Today") {
      startStr = endStr;
    } else if (filter === "Yesterday") {
      const yesterday = new Date(today);
      yesterday.setDate(yesterday.getDate() - 1);
      startStr = yesterday.toLocaleDateString("en-CA");
      setStartDate(startStr);
      setEndDate(startStr);
      return;
    } else if (filter === "This Week") {
      startStr = getStartOfWeek(today);
    } else if (filter === "This Month") {
      startStr = getStartOfMonth(today);
    } else if (filter === "Custom") {
      return;
    }

    if (filter !== "Custom") {
      setStartDate(startStr);
      setEndDate(endStr);
    }
  };

  const filteredOrders = orders.filter((order) => {
    if (!startDate && !endDate) return true;
    const orderDateObj = fixDate(order.order_date || order.created_at);
    const orderDateStr = getLocalDatePart(orderDateObj);
    return orderDateStr >= startDate && orderDateStr <= endDate;
  });

  // ==========================================
  // 4. ACTION HANDLERS
  // ==========================================
  const handleExportOrders = () => {
    if (filteredOrders.length === 0) {
      toast.error("No orders to export.");
      return;
    }

    const dataToExport = filteredOrders.map((order) => ({
      "Order ID": order.order_id,
      "Customer Name": order.first_name || order.last_name ? `${order.first_name} ${order.last_name}` : "Guest",
      "Order Type": order.order_type,
      "Location": order.delivery_location,
      "Date": fixDate(order.order_date).toLocaleString(),
      "Status": order.status,
      "Payment Status": order.payment_status ? order.payment_status.replace(/_/g, " ").toUpperCase() : "UNKNOWN",
      "Total Amount": Number(order.total_amount || 0),
    }));

    const worksheet = XLSX.utils.json_to_sheet(dataToExport, { origin: "A4" });
    const title = [{ v: "ORDER MANAGEMENT REPORT", t: "s" }];
    const rangeText = `Filter: ${quickFilter} (${startDate} to ${endDate})`;
    const dateInfo = [{ v: `Generated: ${new Date().toLocaleString()} | ${rangeText}`, t: "s" }];
    
    XLSX.utils.sheet_add_aoa(worksheet, [title, dateInfo], { origin: "A1" });

    const totalRevenue = dataToExport.reduce((acc, curr) => acc + curr["Total Amount"], 0);
    const totalRow = { "Order ID": "TOTALS:", "Total Amount": totalRevenue };
    
    XLSX.utils.sheet_add_json(worksheet, [totalRow], { origin: -1, skipHeader: true });

    const workbook = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(workbook, worksheet, "Orders");
    XLSX.writeFile(workbook, `Order_Report_${getTodayStr()}.xlsx`);
    
    toast.success("Order report downloaded!");
  };

  const handleViewOrder = async (orderId) => {
    setSelectedOrderId(orderId);
    setIsModalOpen(true);
    setIsLoadingDetails(true);

    try {
      const response = await apiClient(`/orders/${orderId}`);
      if (!response.ok) throw new Error("Failed to fetch order details");
      const data = await response.json();
      setSelectedOrderDetails(data);
    } catch (err) {
      toast.error(err.message);
    } finally {
      setIsLoadingDetails(false);
    }
  };

  const closeModal = () => {
    setIsModalOpen(false);
    setSelectedOrderDetails(null);
    setSelectedOrderId(null);
  };

  // ==========================================
  // 5. RENDER UI
  // ==========================================
  return (
    <div className="w-full">
      
      {/* HEADER ROW */}
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
              style={{ minWidth: "150px" }}
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

          {/* Custom Range Inputs */}
          {quickFilter === "Custom" && (
            <div className="flex items-center gap-2 animate-fadeIn bg-[#fff2e0] p-1 rounded-lg border border-[#6e1a1a]">
              <input
                type="date"
                value={startDate}
                onChange={(e) => setStartDate(e.target.value)}
                max={endDate}
                className="admin-input-date h-10"
              />
              <span className="text-gray-700 font-bold">-</span>
              <input
                type="date"
                value={endDate}
                onChange={(e) => setEndDate(e.target.value)}
                min={startDate}
                className="admin-input-date h-10"
              />
            </div>
          )}

          {/* Export Button */}
          <button onClick={handleExportOrders} className="admin-btn admin-btn-primary">
            <Download size={20} /> Export List
          </button>
        </div>
      </div>

      {/* TABLE DATA */}
      <div className="admin-table-container">
        <table className="admin-table">
          <thead>
            <tr>
              <th>Order ID</th>
              <th>Customer Name</th>
              <th>Type</th>
              <th>Location</th>
              <th className="text-center">Total</th>
              <th className="text-center">Order Status</th>
              <th className="text-center">Payment</th>
              <th>Date</th>
              <th className="text-center">Action</th>
            </tr>
          </thead>
          <tbody>
            {filteredOrders.length > 0 ? (
              filteredOrders.map((order) => (
                <tr key={order.order_id}>
                  <td className="font-medium">{order.order_id}</td>
                  <td>{order.first_name || order.last_name ? `${order.first_name} ${order.last_name}` : "Guest"}</td>
                  <td>{order.order_type}</td>
                  <td>{order.delivery_location}</td>
                  <td className="text-center font-bold">
                    ₱{parseFloat(order.total_amount || 0).toFixed(2)}
                  </td>
                  
                  {/* Order Status Badge */}
                  <td className="text-center">
                    <span className={`status-badge ${
                        order.status === "Open" ? "bg-blue-200 text-blue-800" : 
                        order.status === "Settled" ? "bg-green-200 text-green-800" : 
                        order.status === "cancelled" ? "bg-red-200 text-red-800" : 
                        "bg-gray-200 text-gray-800"
                      }`}
                    >
                      {order.status}
                    </span>
                  </td>

                  {/* Payment Status Badge */}
                  <td className="text-center">
                    <span className={`status-badge ${
                        order.payment_status === "paid" ? "bg-green-200 text-green-800" : 
                        order.payment_status === "charged_to_room" ? "bg-purple-200 text-purple-800" : 
                        "bg-yellow-200 text-yellow-800"
                      }`}
                    >
                      {order.payment_status ? order.payment_status.replace(/_/g, " ").toUpperCase() : "UNKNOWN"}
                    </span>
                  </td>
                  
                  <td>{fixDate(order.order_date).toLocaleString()}</td>
                  
                  {/* Action Button */}
                  <td className="text-center">
                    <button
                      onClick={() => handleViewOrder(order.order_id)}
                      className="text-[#F9A825] hover:text-[#3C2A21] font-bold underline text-sm"
                    >
                      View
                    </button>
                  </td>
                </tr>
              ))
            ) : (
              <tr>
                <td colSpan="9" className="text-center p-8 text-gray-500">
                  No orders found.
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>

      {/* ========================================== */}
      {/* 6. ORDER DETAILS MODAL                     */}
      {/* ========================================== */}
      {isModalOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-4"> 
          <div className="bg-[#fff2e0] rounded-xl shadow-2xl w-full max-w-2xl max-h-[90vh] flex flex-col border border-[#6e1a1a] overflow-hidden animate-fadeIn">
            
            {/* Modal Header */}
            <div className="p-6 border-b border-[#D1C0B6] flex justify-between items-center bg-[#3C2A21] text-[#fff2e0]">
              <h2 className="text-2xl font-bold">Order #{selectedOrderId}</h2>
              <button onClick={closeModal} className="text-gray-300 hover:text-white font-bold text-xl">
                &times;
              </button>
            </div>

            {/* Modal Body */}
            <div className="p-6 overflow-y-auto flex-1 text-[#3C2A21]">
              {isLoadingDetails ? (
                <div className="text-center py-8 font-bold animate-pulse">
                  Fetching receipt details...
                </div>
              ) : selectedOrderDetails ? (
                <div>
                  <div className="grid grid-cols-2 gap-4 mb-6 text-sm border-b border-[#D1C0B6] pb-4">
                    <p><span className="font-bold">Customer:</span> {selectedOrderDetails.first_name || "Guest"} {selectedOrderDetails.last_name}</p>
                    <p><span className="font-bold">Location:</span> {selectedOrderDetails.delivery_location}</p>
                    <p><span className="font-bold">Type:</span> {selectedOrderDetails.order_type}</p>
                    <p><span className="font-bold">Payment:</span> {selectedOrderDetails.payment_method}</p>
                  </div>

                  <h3 className="font-bold text-lg mb-3">Order Items</h3>
                  <table className="w-full text-left mb-6">
                    <thead className="bg-[#D1C0B6] text-[#3C2A21]">
                      <tr>
                        <th className="p-2 rounded-tl-md">Qty</th>
                        <th className="p-2">Item</th>
                        <th className="p-2 text-right rounded-tr-md">Subtotal</th>
                      </tr>
                    </thead>
                    <tbody>
                      {selectedOrderDetails.items.map((item, idx) => (
                        <tr key={idx} className="border-b border-[#D1C0B6] border-dashed">
                          <td className="p-2 font-bold">{item.quantity}x</td>
                          <td className="p-2">{item.item_name}</td>
                          <td className="p-2 text-right">
                            ₱{parseFloat(item.subtotal).toFixed(2)}
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>

                  {/* Financial Summary */}
                  <div className="flex justify-end">
                    <div className="w-1/2 space-y-1 text-sm">
                      <div className="flex justify-between">
                        <p>Subtotal:</p> 
                        <p>₱{parseFloat(selectedOrderDetails.items_total).toFixed(2)}</p>
                      </div>
                      <div className="flex justify-between">
                        <p>Service Charge (10%):</p> 
                        <p>₱{parseFloat(selectedOrderDetails.service_charge_amount).toFixed(2)}</p>
                      </div>
                      <div className="flex justify-between">
                        <p>VAT (12%):</p> 
                        <p>₱{parseFloat(selectedOrderDetails.vat_amount).toFixed(2)}</p>
                      </div>
                      <div className="flex justify-between font-bold text-lg pt-2 border-t border-[#D1C0B6] mt-2">
                        <p>Total:</p> 
                        <p className="text-[#DC2626]">
                          ₱{parseFloat(selectedOrderDetails.total_price).toFixed(2)}
                        </p>
                      </div>
                    </div>
                  </div>
                </div>
              ) : (
                <div className="text-center py-8 text-red-500 font-bold">
                  Failed to load order details.
                </div>
              )}
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default OrderManagement;
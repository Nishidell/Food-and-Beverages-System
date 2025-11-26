import React from "react";
import '../AdminTheme.css';

const OrderManagement = ({ orders }) => (
  <div className="admin-section-container">
    <div className="admin-table-container">
      <h2 className="admin-page-title p-6">Order Management</h2>
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
          {orders.map((order) => (
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
          ))}
        </tbody>
      </table>
    </div>
  </div>
);

export default OrderManagement;
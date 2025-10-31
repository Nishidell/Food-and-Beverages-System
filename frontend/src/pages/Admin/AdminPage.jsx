import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import toast from 'react-hot-toast'; // <-- IMPORT TOAST
import MenuManagementTable from './MenuManagementTable';
import AddItemModal from './AddItemModal';
import InternalNavBar from '../../components/InternalNavBar';
import StaffManagementTable from './StaffManagementTable';
import { useAuth } from '../../context/AuthContext';
import StaffModal from './StaffModal';

// Order Management Table Component
const OrderManagementTable = ({ orders }) => (
  <div className="bg-white shadow-md rounded-lg overflow-hidden">
    <h2 className="text-2xl font-bold p-6">Order Management</h2>
    <table className="min-w-full leading-normal">
      <thead>
        <tr className="bg-gray-100 text-gray-600 uppercase text-sm leading-normal">
          <th className="py-3 px-6 text-left">Order ID</th>
          <th className="py-3 px-6 text-left">Cust. ID</th>
          <th className="py-3 px-6 text-left">Type</th>
          <th className="py-3 px-6 text-left">Location</th>
          <th className="py-3 px-6 text-center">Total</th>
          <th className="py-3 px-6 text-center">Status</th>
          <th className="py-3 px-6 text-left">Date</th>
        </tr>
      </thead>
      <tbody className="text-gray-600 text-sm font-light">
        {orders.map((order) => (
          <tr key={order.order_id} className="border-b border-gray-200 hover:bg-gray-50">
            <td className="py-3 px-6 text-left whitespace-nowrap">{order.order_id}</td>
            <td className="py-3 px-6 text-left">{order.customer_id}</td>
            <td className="py-3 px-6 text-left">{order.order_type}</td>
            <td className="py-3 px-6 text-left">{order.delivery_location}</td>
            <td className="py-3 px-6 text-center">₱{parseFloat(order.total_amount).toFixed(2)}</td>
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
            {/* MOVED Data Cell */}
            <td className="py-3 px-6 text-left">{new Date(order.order_date).toLocaleString()}</td>
          </tr>
        ))}
      </tbody>
    </table>
  </div>
);

function AdminPage() {
  const [orders, setOrders] = useState([]);
  const [menuItems, setMenuItems] = useState([]);
  const [staffList, setStaffList] = useState([]);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(true);
  const [currentView, setCurrentView] = useState('orders');
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [editingItem, setEditingItem] = useState(null);
  const [isStaffModalOpen, setIsStaffModalOpen] = useState(false);
  const [editingStaff, setEditingStaff] = useState(null);
  const [menuFilterCategory, setMenuFilterCategory] = useState('All');

  const { token } = useAuth();

  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        const headers = {
          'Authorization': `Bearer ${token}`
        };

        const [ordersResponse, itemsResponse, staffResponse] = await Promise.all([
          fetch('http://localhost:3000/api/orders'),
          fetch('http://localhost:3000/api/items'),
          fetch('http://localhost:3000/api/admin/staff', { headers }) 
        ]);
        if (!ordersResponse.ok || !itemsResponse.ok) throw new Error('Failed to fetch data');
        const ordersData = await ordersResponse.json();
        const itemsData = await itemsResponse.json();
        const staffData = await staffResponse.json();

        setOrders(ordersData);
        setMenuItems(itemsData);
        setStaffList(staffData);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };
    if (token) {
    fetchData();
    }
  }, [token]);

  

  const handleAddNewItem = async (formData) => {
    try {
      const response = await fetch('http://localhost:3000/api/items', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(formData),
      });
      if (!response.ok) throw new Error('Failed to save the item.');
      const newItem = await response.json();
      setMenuItems(prevItems => [...prevItems, newItem]);
      toast.success('Item added successfully!'); // <-- USE TOAST
      closeModal(); // <-- THIS FIXES THE BUG
    } catch (error) {
      toast.error(error.message); // <-- Use toast for errors too
    }
  };

  const handleUpdateItem = async (itemData) => {
    try {
      const response = await fetch(`http://localhost:3000/api/items/${editingItem.item_id}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(itemData),
      });
      if (!response.ok) throw new Error('Failed to update item.');
      const updatedItem = await response.json();
      setMenuItems(prevItems => prevItems.map(item => item.item_id === updatedItem.item_id ? updatedItem : item));
      toast.success('Item updated successfully!'); // <-- USE TOAST
      closeModal();
    } catch (error) {
      toast.error(error.message);
    }
  };

  const handleDeleteItem = async (itemIdToDelete) => {
    if (!window.confirm('Are you sure you want to delete this item?')) return;
    try {
      const response = await fetch(`http://localhost:3000/api/items/${itemIdToDelete}`, {
        method: 'DELETE',
      });
      if (!response.ok) throw new Error('Failed to delete the item.');
      setMenuItems(prevItems => prevItems.filter(item => item.item_id !== itemIdToDelete));
      toast.success('Item deleted successfully!'); // <-- USE TOAST
    } catch (error) {
      toast.error(error.message);
    }
  };

const openModalForEdit = (item) => {
    setEditingItem(item);
    setIsModalOpen(true);
  };
  
  const openModalForAdd = () => {
    setEditingItem(null);
    setIsModalOpen(true);
  };

  const closeModal = () => {
    setIsModalOpen(false);
    setEditingItem(null);
  };

  const handleMenuFilterChange = (category) => {
    setMenuFilterCategory(category);
  };

  const handleClearMenuFilters = () => {
    setMenuFilterCategory('All');
  };

  const handleAddStaff = async (formData) => {
    try {
      const response = await fetch('http://localhost:3000/api/admin/staff', {
        method: 'POST',
        headers: { 
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        },
        body: JSON.stringify(formData),
      });
      if (!response.ok) {
        const errData = await response.json();
        throw new Error(errData.message || 'Failed to save the staff member.');
      }
      const newStaff = await response.json(); // The backend returns { staff_id, message }
      // Refetch the list to get the full new staff details
      const listResponse = await fetch('http://localhost:3000/api/admin/staff', { 
        headers: { 'Authorization': `Bearer ${token}` }
      });
      const updatedList = await listResponse.json();
      setStaffList(updatedList);
      
      toast.success('Staff member added successfully!');
      closeStaffModal();
    } catch (error) {
      toast.error(error.message);
    }
  };

  const handleUpdateStaff = async (formData) => {
    // Don't send an empty password field
    const payload = { ...formData };
    if (!payload.password) {
      delete payload.password;
    }

    try {
      const response = await fetch(`http://localhost:3000/api/admin/staff/${editingStaff.staff_id}`, {
        method: 'PUT',
        headers: { 
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        },
        body: JSON.stringify(payload),
      });
      if (!response.ok) {
        const errData = await response.json();
        throw new Error(errData.message || 'Failed to update staff member.');
      }
      
      // Refetch the list to get updated details
      const listResponse = await fetch('http://localhost:3000/api/admin/staff', { 
        headers: { 'Authorization': `Bearer ${token}` }
      });
      const updatedList = await listResponse.json();
      setStaffList(updatedList);

      toast.success('Staff member updated successfully!');
      closeStaffModal();
    } catch (error) {
      toast.error(error.message);
    }
  };

  const handleDeleteStaff = async (staffIdToDelete) => {
    if (!window.confirm('Are you sure you want to delete this staff account?')) return;
    try {
      const response = await fetch(`http://localhost:3000/api/admin/staff/${staffIdToDelete}`, {
        method: 'DELETE',
        headers: {
          'Authorization': `Bearer ${token}`
        }
      });
      if (!response.ok) {
        const errData = await response.json();
        throw new Error(errData.message || 'Failed to delete the staff member.');
      }
      setStaffList(prevList => prevList.filter(staff => staff.staff_id !== staffIdToDelete));
      toast.success('Staff member deleted successfully!');
    } catch (error) {
      toast.error(error.message);
    }
  };

  // --- 11. ADD MODAL HANDLERS FOR STAFF ---

  const openStaffModalForEdit = (staff) => {
    setEditingStaff(staff);
    setIsStaffModalOpen(true);
  };
  
  const openStaffModalForAdd = () => {
    setEditingStaff(null);
    setIsStaffModalOpen(true);
  };

  const closeStaffModal = () => {
    setIsStaffModalOpen(false);
    setEditingStaff(null);
  };

  // ... (loading/error checks)
  if (loading) return <div className="p-8">Loading dashboard...</div>;
  if (error) return <div className="p-8 text-red-500">Error: {error}</div>;
  
  const uniqueCategories = ['All', ...new Set(menuItems.map(item => item.category))];
  const allCategories = ['All', ...new Set(menuItems.map(item => item.category))];
  const categoriesForForm = allCategories.filter(c => c !== 'All'); // Exclude 'All' for the Add/Edit form

  const filteredMenuItems = menuItems.filter(item => 
    menuFilterCategory === 'All' || item.category === menuFilterCategory
  );

   return (
    <>
    <InternalNavBar />
    <div className="container mx-auto px-4 py-8">
      
      {/* --- THIS IS THE CORRECTED NAVIGATION SECTION --- */}
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

        {/* --- ADD STAFF MANAGEMENT TAB --- */}
        <button
          onClick={() => setCurrentView('staff')}
          className={`py-2 px-4 text-lg font-semibold transition-colors ${
            currentView === 'staff'
              ? 'border-b-2 border-orange-500 text-orange-500'
              : 'text-gray-500 hover:text-orange-500'
          }`}
        >
          Staff Management
        </button>
      </nav>

      <main>
        {currentView === 'orders' && <OrderManagementTable orders={orders} />}
        {currentView === 'menu' && (
          <MenuManagementTable
            // Pass the filtered list and total count
            items={filteredMenuItems} 
            totalItems={filteredMenuItems.length} 
            // Pass categories for the filter dropdown
            categories={allCategories} 
            selectedCategory={menuFilterCategory}
            onFilterChange={handleMenuFilterChange}
            onClearFilters={handleClearMenuFilters}
            // Pass modal handlers
            onAddItem={openModalForAdd}
            onEditItem={openModalForEdit}
            onDeleteItem={handleDeleteItem}
          />
        )}

        {/* --- 13. RENDER THE STAFF TABLE --- */}
        {currentView === 'staff' && (
          <StaffManagementTable
            staffList={staffList}
            onAddStaff={openStaffModalForAdd}
            onEditStaff={openStaffModalForEdit}
            onDeleteStaff={handleDeleteStaff}
          />
        )}

      </main>
      {/* --- FIX: Render the AddItemModal here --- */}
      <AddItemModal
        isOpen={isModalOpen}
        onClose={closeModal}
        onSave={editingItem ? handleUpdateItem : handleAddNewItem}
        itemToEdit={editingItem}
        categories={uniqueCategories.filter(c => c !== 'All')}
      />

      {/* --- 14. RENDER THE NEW STAFF MODAL --- */}
      <StaffModal
        isOpen={isStaffModalOpen}
        onClose={closeStaffModal}
        onSave={editingStaff ? handleUpdateStaff : handleAddStaff}
        staffToEdit={editingStaff}
      />
    </div>
    </>
  );
}

export default AdminPage;
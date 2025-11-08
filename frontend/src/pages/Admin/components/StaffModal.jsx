import React, { useState, useEffect } from 'react';
import { X } from 'lucide-react';

const StaffModal = ({ isOpen, onClose, onSave, staffToEdit }) => {
  const [formData, setFormData] = useState({
    first_name: '',
    last_name: '',
    email: '',
    password: '',
    role: 'waiter', // Default role
  });
  const isEditMode = Boolean(staffToEdit);

  useEffect(() => {
    if (isOpen) {
      if (isEditMode) {
        setFormData({
          first_name: staffToEdit.first_name || '',
          last_name: staffToEdit.last_name || '',
          email: staffToEdit.email || '',
          password: '', // Keep password blank on edit
          role: staffToEdit.role || 'waiter',
        });
      } else {
        // Reset for new staff member
        setFormData({
          first_name: '',
          last_name: '',
          email: '',
          password: '',
          role: 'waiter',
        });
      }
    }
  }, [staffToEdit, isOpen]);

  if (!isOpen) return null;

  const handleChange = (e) => {
    const { id, value } = e.target;
    setFormData((prevData) => ({ ...prevData, [id]: value }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    onSave(formData);
  };

  return (
    <div className="fixed inset-0 bg-black/75 z-50 flex justify-center items-center">
      <div className="bg-white rounded-lg shadow-xl p-8 w-full max-w-md">
        <div className="flex justify-between items-center mb-6">
          <h2 className="text-2xl font-bold">{isEditMode ? 'Edit Staff Account' : 'Add New Staff Account'}</h2>
          <button onClick={onClose} className="text-gray-500 hover:text-gray-800"><X size={24} /></button>
        </div>
        <form onSubmit={handleSubmit} className="space-y-4">
          
          <div className="flex space-x-4">
            <div className="w-1/2">
              <label htmlFor="first_name" className="block text-sm font-medium text-gray-700">First Name</label>
              <input type="text" id="first_name" value={formData.first_name} onChange={handleChange} required className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3"/>
            </div>
            <div className="w-1/2">
              <label htmlFor="last_name" className="block text-sm font-medium text-gray-700">Last Name</label>
              <input type="text" id="last_name" value={formData.last_name} onChange={handleChange} required className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3"/>
            </div>
          </div>

          <div>
            <label htmlFor="email" className="block text-sm font-medium text-gray-700">Email Address</label>
            <input type="email" id="email" value={formData.email} onChange={handleChange} required className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3"/>
          </div>

          <div>
            <label htmlFor="password" className="block text-sm font-medium text-gray-700">Password</label>
            <input type="password" id="password" value={formData.password} onChange={handleChange} required={!isEditMode} className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3"/>
            {isEditMode && <p className="text-xs text-gray-500 mt-1">Leave blank to keep the same password.</p>}
          </div>

          <div>
            <label htmlFor="role" className="block text-sm font-medium text-gray-700">Role</label>
            <select
              id="role"
              value={formData.role}
              onChange={handleChange}
              required
              className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3"
            >
              <option value="waiter">Waiter</option>
              <option value="cashier">Cashier</option>
              <option value="admin">Admin</option>
            </select>
          </div>

          <div className="mt-8 flex justify-end gap-4">
            <button type="button" onClick={onClose} className="py-2 px-4 bg-gray-200 text-gray-800 rounded-md hover:bg-gray-300">Cancel</button>
            <button type="submit" className="py-2 px-4 bg-blue-500 text-white rounded-md hover:bg-blue-600">
              Save Staff
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default StaffModal;
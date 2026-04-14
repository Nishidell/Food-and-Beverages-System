import React, { useState } from 'react';
import { X } from 'lucide-react';

const BudgetRequestModal = ({ isOpen, onClose, onSubmit }) => {
  const [formData, setFormData] = useState({
    title: '',
    requested_amount: '',
    priority: 'medium', 
    purpose: ''
  });

  if (!isOpen) return null;

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    onSubmit({
        ...formData,
        requested_amount: parseFloat(formData.requested_amount)
    });
    
    setFormData({ title: '', requested_amount: '', priority: 'medium', purpose: '' });
  };

  return (
    <div className="fixed inset-0 bg-black/75 z-50 flex justify-center items-center">
      <div className="bg-white rounded-lg shadow-xl p-8 w-full max-w-md">
        
        <div className="flex justify-between items-center mb-6">
          <h2 className="text-2xl font-bold text-[#480c1b]">New Budget Request</h2>
          <button onClick={onClose} className="text-gray-500 hover:text-gray-800 transition-colors">
            <X size={24} />
          </button>
        </div>

        <form onSubmit={handleSubmit} className="space-y-4">
          
          <div>
            <label className="block text-sm font-medium text-gray-700">Request Title</label>
            <input
              type="text"
              name="title"
              value={formData.title}
              onChange={handleChange}
              required
              placeholder="e.g., New Espresso Machine"
              className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:ring-[#F9A825] focus:border-[#F9A825] outline-none"
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700">Requested Amount (₱)</label>
            <div className="relative mt-1">
              <span className="absolute inset-y-0 left-0 pl-3 flex items-center text-gray-500 font-bold">₱</span>
              <input
                type="number"
                name="requested_amount"
                step="0.01"
                min="0"
                value={formData.requested_amount}
                onChange={handleChange}
                required
                placeholder="0.00"
                className="block w-full pl-8 border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:ring-[#F9A825] focus:border-[#F9A825] outline-none"
              />
            </div>
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700">Priority Level</label>
            <select
              name="priority"
              value={formData.priority}
              onChange={handleChange}
              className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:ring-[#F9A825] focus:border-[#F9A825] outline-none bg-white"
            >
              <option value="low">Low (Routine Upgrades)</option>
              <option value="medium">Medium (Needed soon)</option>
              <option value="high">High (Urgent / Broken Equipment)</option>
            </select>
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700">Purpose / Justification</label>
            <textarea
              name="purpose"
              value={formData.purpose}
              onChange={handleChange}
              required
              rows="3"
              placeholder="Explain why this budget is needed by the kitchen..."
              className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:ring-[#F9A825] focus:border-[#F9A825] outline-none"
            ></textarea>
          </div>

          <div className="mt-8 flex justify-end gap-4">
            <button
              type="button"
              onClick={onClose}
              className="py-2 px-4 bg-gray-200 text-gray-800 font-medium rounded-md hover:bg-gray-300 transition-colors"
            >
              Cancel
            </button>
            <button
              type="submit"
              className="bg-[#F9A825] text-white font-bold py-2 px-6 rounded hover:bg-[#c47b04] transition-colors"
            >
              Submit Request
            </button>
          </div>

        </form>
      </div>
    </div>
  );
};

export default BudgetRequestModal;
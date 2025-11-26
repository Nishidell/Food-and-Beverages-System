import React, { useState, useEffect } from 'react';
import { X } from 'lucide-react';
import toast from 'react-hot-toast';
import apiClient from '../../../utils/apiClient';

// Added 'promotionToEdit' prop
const AddPromotionModal = ({ isOpen, onClose, onSave, promotionToEdit = null }) => {
  const [formData, setFormData] = useState({
    name: '',
    description: '',
    discount_percentage: '',
    start_date: '',
    end_date: '',
  });

  // Effect: Populate form if editing, otherwise reset
  useEffect(() => {
    if (isOpen) {
        if (promotionToEdit) {
            // Format dates to YYYY-MM-DD for the input
            const startDate = new Date(promotionToEdit.start_date).toISOString().split('T')[0];
            const endDate = new Date(promotionToEdit.end_date).toISOString().split('T')[0];

            setFormData({
                name: promotionToEdit.name,
                description: promotionToEdit.description || '',
                discount_percentage: promotionToEdit.discount_percentage,
                start_date: startDate,
                end_date: endDate,
            });
        } else {
            setFormData({ name: '', description: '', discount_percentage: '', start_date: '', end_date: '' });
        }
    }
  }, [isOpen, promotionToEdit]);

  if (!isOpen) return null;

  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    
    const isEdit = !!promotionToEdit;
    const url = isEdit ? `/promotions/${promotionToEdit.promotion_id}` : '/promotions';
    const method = isEdit ? 'PUT' : 'POST';

    try {
      const response = await apiClient(url, {
        method: method,
        body: JSON.stringify(formData),
      });

      if (!response.ok) throw new Error(`Failed to ${isEdit ? 'update' : 'create'} promotion`);
      
      toast.success(`Promotion ${isEdit ? 'updated' : 'created'} successfully!`);
      onSave(); // Refresh list
      onClose();
    } catch (error) {
      toast.error(error.message);
    }
  };

  return (
    <div className="fixed inset-0 bg-black/75 z-50 flex justify-center items-center">
      <div className="bg-white rounded-lg shadow-xl p-6 w-full max-w-md">
        <div className="flex justify-between items-center mb-4">
          <h2 className="text-xl font-bold text-[#3C2A21]">
            {promotionToEdit ? 'Edit Promotion' : 'Create Master Promotion'}
          </h2>
          <button onClick={onClose} className="text-gray-500 hover:text-gray-800"><X size={24} /></button>
        </div>

        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="block text-sm font-semibold text-gray-700">Promotion Name</label>
            <input name="name" value={formData.name} onChange={handleChange} required placeholder="e.g. Summer Sale" className="w-full border p-2 rounded" />
          </div>
          
          <div>
            <label className="block text-sm font-semibold text-gray-700">Description</label>
            <textarea name="description" value={formData.description} onChange={handleChange} rows="2" placeholder="e.g. 20% off on all drinks" className="w-full border p-2 rounded" />
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-semibold text-gray-700">Discount (%)</label>
              <input type="number" name="discount_percentage" value={formData.discount_percentage} onChange={handleChange} required min="1" max="100" className="w-full border p-2 rounded" />
            </div>
            <div className="flex items-end pb-2 text-sm text-gray-500">
              % Off
            </div>
          </div>

          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-semibold text-gray-700">Start Date</label>
              <input type="date" name="start_date" value={formData.start_date} onChange={handleChange} required className="w-full border p-2 rounded" />
            </div>
            <div>
              <label className="block text-sm font-semibold text-gray-700">End Date</label>
              <input type="date" name="end_date" value={formData.end_date} onChange={handleChange} required className="w-full border p-2 rounded" />
            </div>
          </div>

          <div className="flex justify-end gap-3 mt-6">
            <button type="button" onClick={onClose} className="px-4 py-2 text-gray-600 hover:bg-gray-100 rounded">Cancel</button>
            <button type="submit" className="px-4 py-2 bg-[#F9A825] text-white font-bold rounded hover:bg-yellow-600">
                {promotionToEdit ? 'Save Changes' : 'Create Promo'}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default AddPromotionModal;
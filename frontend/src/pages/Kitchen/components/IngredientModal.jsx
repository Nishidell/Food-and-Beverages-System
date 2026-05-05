import React, { useState, useEffect } from 'react';
import { X, AlertTriangle } from 'lucide-react';

const formatUnitDisplay = (value, unit) => {
    const num = parseFloat(value);
    if (isNaN(num)) return `${value} ${unit}`;

    if (unit === 'g' && num >= 1000) {
        return `${(num / 1000).toLocaleString('en-PH', { maximumFractionDigits: 2 })} kg`;
    }
    if (unit === 'ml' && num >= 1000) {
        return `${(num / 1000).toLocaleString('en-PH', { maximumFractionDigits: 2 })} L`;
    }
    
    // For pieces or amounts under 1000, just format with commas
    return `${num.toLocaleString('en-PH', { maximumFractionDigits: 2 })} ${unit}`;
};

const IngredientModal = ({ isOpen, onClose, onSave, ingredientToEdit }) => {

  const unitOptions = [
    { value: 'g', label: 'g (grams)' },
    { value: 'ml', label: 'ml (milliliters)' },
    { value: 'pcs', label: 'pcs (pieces)' },
  ];
  
 const [formData, setFormData] = useState({
    name: '',
    unit_of_measurement: '',
    stock_level: 0,
    reorder_point: 10,
    unit_cost: '',
  });

  const isEditMode = Boolean(ingredientToEdit);

useEffect(() => {
    if (isOpen) {
      if (isEditMode) {
        setFormData({
          name: ingredientToEdit.name || '',
          unit_of_measurement: ingredientToEdit.unit_of_measurement || '',
          stock_level: Math.floor(parseFloat(ingredientToEdit.stock_level || 0)), 
          reorder_point: Math.floor(parseFloat(ingredientToEdit.reorder_point || 10)), 
          unit_cost: ingredientToEdit.unit_cost || '',
        });
      } else {
        // Reset for new ingredient
        setFormData({
          name: '',
          unit_of_measurement: '',
          stock_level: 0,
          reorder_point: 10, 
          unit_cost: '', 
        });
      }
    }
  }, [ingredientToEdit, isOpen]);

  if (!isOpen) return null;

  const handleChange = (e) => {
    const { id, value } = e.target;

    setFormData((prevData) => {
        const newData = { ...prevData, [id]: value };

        // ✅ SMART LOGIC: Auto-suggest threshold based on Unit
        if (id === 'unit_of_measurement') {
            if (value === 'g' || value === 'ml') {
                newData.reorder_point = 1000; // Default to 1kg / 1L
            } else if (value === 'pcs') {
                newData.reorder_point = 10;   // Default to 10 pieces
            }
        }

        return newData;
    });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    const cleanData = {
      ...formData,
      stock_level: Math.floor(parseFloat(formData.stock_level || 0)),
      reorder_point: Math.floor(parseFloat(formData.reorder_point || 10))
    };
    onSave(cleanData);
  };

  return (
    <div className="fixed inset-0 bg-black/75 z-50 flex justify-center items-start pt-24 pb-10 overflow-y-auto">
      <div className="bg-white rounded-lg shadow-xl p-8 w-full max-w-2xl">
        <div className="flex justify-between items-center mb-6">
          <h2 className="text-2xl font-bold text-primary">
            {isEditMode ? 'Edit Ingredient' : 'Add New Ingredient'}
          </h2>
          <button onClick={onClose} className="text-gray-500 hover:text-gray-800"><X size={24} /></button>
        </div>
        
        <form onSubmit={handleSubmit} className="space-y-6">
          
          {/* ================= TOP SECTION: 2 COLUMNS ================= */}
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            
            {/* --- LEFT COLUMN --- */}
            <div className="space-y-4">
              {/* 1. Name Input */}
              <div>
                <label htmlFor="name" className="block text-sm font-medium text-gray-700">Ingredient Name</label>
                <input
                  type="text" id="name" value={formData.name} onChange={handleChange} required
                  className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3"
                  placeholder="e.g., Beef, Lettuce, Buns"
                />
              </div>

              {/* 2. Unit Selection */}
              <div>
                <label htmlFor="unit_of_measurement" className="block text-sm font-medium text-gray-700">Unit of Measurement</label>
                <select
                  id="unit_of_measurement" value={formData.unit_of_measurement} onChange={handleChange} required
                  className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3"
                >
                  <option value="" disabled>Select a unit</option>
                  {unitOptions.map(option => (
                    <option key={option.value} value={option.value}>{option.label}</option>
                  ))}
                </select>
              </div>
            </div>

            {/* --- RIGHT COLUMN --- */}
            <div className="space-y-4">
              {/* 3. Unit Cost Input */}
              <div>
                <label htmlFor="unit_cost" className="block text-sm font-medium text-gray-700">Unit Cost (₱)</label>
                <div className="relative mt-1">
                  <span className="absolute inset-y-0 left-0 pl-3 flex items-center text-gray-500 font-bold">₱</span>
                  <input
                    type="number" id="unit_cost" step="0.01" min="0" value={formData.unit_cost} onChange={handleChange} required
                    className="block w-full pl-8 border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:ring-amber-500 focus:border-amber-500"
                    placeholder="0.00"
                  />
                </div>
              </div>

              {/* 4. Initial Stock */}
              {!isEditMode && (
                <div>
                  <label htmlFor="stock_level" className="block text-sm font-medium text-gray-700">Initial Stock</label>
                  <input
                    type="number" id="stock_level" step="1" min="0" value={formData.stock_level} onChange={handleChange} required
                    className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3"
                  />
                  {/*  NEW UX HELPER TEXT */}
                  {formData.stock_level > 0 && formData.unit_of_measurement && (
                      <p className="text-xs text-green-600 mt-1 font-semibold">
                          Equivalent to: {formatUnitDisplay(formData.stock_level, formData.unit_of_measurement)}
                      </p>
                  )}
                </div>
              )}
            </div>
          </div>

          {/* ================= MIDDLE SECTION: FULL WIDTH ================= */}
          {/* 5. Low Stock Threshold */}
          <div className="bg-orange-50 p-3 rounded-md border border-orange-100 mt-2">
            <label htmlFor="reorder_point" className="flex items-center gap-2 text-sm font-bold text-orange-800">
              <AlertTriangle size={16} />
              Low Stock Threshold (Alert Level)
            </label>
            <div className="flex items-center gap-2 mt-1">
                <input
                  type="number" id="reorder_point" step="1" min="0" value={formData.reorder_point} onChange={handleChange} required
                  className="block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:ring-orange-500 focus:border-orange-500"
                />
                <span className="text-sm text-gray-500 font-bold min-w-[30px]">{formData.unit_of_measurement || ''}</span>
            </div>
            <p className="text-xs text-orange-600 mt-1">System will alert you when stock falls below this number.</p>
          </div>

          {/* ================= BOTTOM SECTION: BUTTONS ================= */}
          <div className="mt-8 flex justify-end gap-4">
            <button type="button" onClick={onClose} className="py-2 px-4 bg-gray-200 text-gray-800 rounded-md hover:bg-gray-300">
              Cancel
            </button>
            <button type="submit" className="bg-[#F9A825] text-white font-bold py-2 px-6 rounded hover:bg-[#c47b04] transition-colors">
              Save Ingredient
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default IngredientModal;
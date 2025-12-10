import React, { useState, useEffect } from 'react';
import { X, Save, Trash2, Plus, Edit2, Check, XCircle } from 'lucide-react';
import apiClient from '../../../utils/apiClient';
import toast from 'react-hot-toast';
import '../AdminTheme.css';

const ManageCategoriesModal = ({ isOpen, onClose, onDataChange }) => {
  const [categories, setCategories] = useState([]);
  const [loading, setLoading] = useState(false);
  
  // State for Adding
  const [newCategory, setNewCategory] = useState('');
  const [isAdding, setIsAdding] = useState(false);

  // State for Editing
  const [editingId, setEditingId] = useState(null);
  const [editValue, setEditValue] = useState('');

  // Fetch Categories internally to ensure latest state
  const fetchCategories = async () => {
    setLoading(true);
    try {
      const res = await apiClient('/categories');
      if (res.ok) {
        setCategories(await res.json());
      }
    } catch (error) {
      console.error("Error fetching categories:", error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (isOpen) {
        fetchCategories();
        setNewCategory('');
        setEditingId(null);
    }
  }, [isOpen]);

  // --- HANDLERS ---

  const handleAdd = async (e) => {
    e.preventDefault();
    if (!newCategory.trim()) return;

    setIsAdding(true);
    try {
      const res = await apiClient('/categories', {
        method: 'POST',
        body: JSON.stringify({ name: newCategory })
      });
      
      if (!res.ok) throw new Error('Failed to create category');
      
      toast.success('Category added');
      setNewCategory('');
      fetchCategories();
      onDataChange(); 
    } catch (error) {
      toast.error(error.message);
    } finally {
      setIsAdding(false);
    }
  };

  const handleDelete = async (id) => {
    if (!window.confirm('Delete this category? Items in this category might lose their tag.')) return;
    try {
      const res = await apiClient(`/categories/${id}`, { method: 'DELETE' });
      if (!res.ok) throw new Error('Failed to delete');
      
      toast.success('Category deleted');
      fetchCategories();
      onDataChange(); 
    } catch (error) {
      toast.error(error.message);
    }
  };

  const startEdit = (cat) => {
    setEditingId(cat.category_id);
    setEditValue(cat.name);
  };

  const cancelEdit = () => {
    setEditingId(null);
    setEditValue('');
  };

  const saveEdit = async (id) => {
    if (!editValue.trim()) return;
    try {
      const res = await apiClient(`/categories/${id}`, {
        method: 'PUT',
        body: JSON.stringify({ name: editValue })
      });
      if (!res.ok) throw new Error('Failed to update');

      toast.success('Category updated');
      setEditingId(null);
      fetchCategories();
      onDataChange(); 
    } catch (error) {
      toast.error(error.message);
    }
  };

  if (!isOpen) return null;

  return (
    // ✅ FIX: Force transparent background using RGBA style
    <div 
        className="fixed inset-0 flex justify-center items-center z-50 animate-fadeIn"
        style={{ backgroundColor: 'rgba(0, 0, 0, 0.5)' }} 
    >
      <div className="bg-white rounded-lg w-full max-w-lg p-6 shadow-2xl relative flex flex-col max-h-[80vh]">
        {/* Header */}
        <div className="flex justify-between items-center mb-6">
            <h2 className="text-xl font-bold text-[#3C2A21]">Manage Categories</h2>
            <button onClick={onClose} className="text-gray-500 hover:text-gray-700">
                <X size={24} />
            </button>
        </div>

        {/* 1. ADD NEW SECTION */}
        <form onSubmit={handleAdd} className="flex gap-2 mb-6 border-b border-gray-200 pb-6">
            <input 
              type="text" 
              value={newCategory}
              onChange={(e) => setNewCategory(e.target.value)}
              className="flex-1 p-2 border border-gray-300 rounded focus:ring-2 focus:ring-[#F9A825] outline-none"
              placeholder="New Category Name..."
            />
            <button 
              type="submit" 
              disabled={isAdding}
              className="admin-btn admin-btn-primary"
            >
              {isAdding ? <span className="animate-spin">...</span> : <Plus size={20} />}
              Add
            </button>
        </form>

        {/* 2. CATEGORY LIST */}
        <div className="flex-1 overflow-y-auto pr-2">
            {loading ? (
                <p className="text-center text-gray-500">Loading...</p>
            ) : categories.length === 0 ? (
                <p className="text-center text-gray-400 italic">No categories found.</p>
            ) : (
                <div className="space-y-2">
                    {categories.map((cat) => (
                        <div key={cat.category_id} className="flex justify-between items-center p-3 bg-gray-50 rounded border border-gray-200 hover:border-[#F9A825] transition-colors group">
                            
                            {/* EDIT MODE vs VIEW MODE */}
                            {editingId === cat.category_id ? (
                                // --- EDIT MODE ---
                                <div className="flex-1 flex gap-2 items-center">
                                    <input 
                                        type="text" 
                                        value={editValue}
                                        onChange={(e) => setEditValue(e.target.value)}
                                        className="flex-1 p-1 px-2 border border-[#F9A825] rounded outline-none bg-white font-bold text-[#3C2A21]"
                                        autoFocus
                                    />
                                    <button onClick={() => saveEdit(cat.category_id)} className="p-1 text-green-600 hover:bg-green-100 rounded">
                                        <Check size={18} />
                                    </button>
                                    <button onClick={cancelEdit} className="p-1 text-red-500 hover:bg-red-100 rounded">
                                        <XCircle size={18} />
                                    </button>
                                </div>
                            ) : (
                                // --- VIEW MODE ---
                                <>
                                    <span className="font-bold text-[#3C2A21]">{cat.name}</span>
                                    <div className="flex gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                                        <button 
                                            onClick={() => startEdit(cat)}
                                            className="p-1 text-blue-600 hover:bg-blue-100 rounded"
                                            title="Rename"
                                        >
                                            <Edit2 size={16} />
                                        </button>
                                        <button 
                                            onClick={() => handleDelete(cat.category_id)}
                                            className="p-1 text-red-500 hover:bg-red-100 rounded"
                                            title="Delete"
                                        >
                                            <Trash2 size={16} />
                                        </button>
                                    </div>
                                </>
                            )}
                        </div>
                    ))}
                </div>
            )}
        </div>
      </div>
    </div>
  );
};

export default ManageCategoriesModal;
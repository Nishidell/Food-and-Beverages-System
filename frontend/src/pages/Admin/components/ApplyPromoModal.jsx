import React, { useState, useEffect } from 'react';
import { X, Search, CheckCircle, Trash2, Undo2, Save } from 'lucide-react';
import toast from 'react-hot-toast';
import apiClient from '../../../utils/apiClient';

const ApplyPromoModal = ({ isOpen, onClose, promotion, allItems = [], onRefresh }) => {
  // Batch State: We track pending adds and removes locally
  const [itemsToAdd, setItemsToAdd] = useState([]);
  const [itemsToRemove, setItemsToRemove] = useState([]);
  
  const [searchTerm, setSearchTerm] = useState('');
  const [loading, setLoading] = useState(false);

  // Reset state when modal opens
  useEffect(() => {
    if (isOpen) {
        setItemsToAdd([]);
        setItemsToRemove([]);
        setSearchTerm('');
    }
  }, [isOpen]);

  if (!isOpen || !promotion) return null;

  const filteredItems = allItems.filter(item => 
    item.item_name.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const isLinkedToCurrent = (item) => item.promotion_id === promotion.promotion_id;
  const isLinkedToOther = (item) => item.promotion_id && item.promotion_id !== promotion.promotion_id;

  // --- HANDLERS ---

  const handleRowClick = (item) => {
    if (isLinkedToCurrent(item)) {
        // ITEM IS CURRENTLY ACTIVE: Toggle "Pending Remove"
        setItemsToRemove(prev => 
            prev.includes(item.item_id) 
            ? prev.filter(id => id !== item.item_id) // Undo remove (Keep it)
            : [...prev, item.item_id] // Mark for remove
        );
    } else {
        // ITEM IS INACTIVE: Toggle "Pending Add"
        setItemsToAdd(prev => 
            prev.includes(item.item_id) 
            ? prev.filter(id => id !== item.item_id) // Undo add
            : [...prev, item.item_id] // Mark for add
        );
    }
  };

  const handleSelectAll = () => {
    // Select all available items that aren't already active
    const availableItems = filteredItems.filter(i => !isLinkedToCurrent(i));
    
    // If all visible available items are selected, deselect them
    const allSelected = availableItems.every(i => itemsToAdd.includes(i.item_id));

    if (allSelected) {
        setItemsToAdd(prev => prev.filter(id => !availableItems.find(i => i.item_id === id)));
    } else {
        const newIds = availableItems.map(i => i.item_id);
        setItemsToAdd(prev => [...new Set([...prev, ...newIds])]);
    }
  };

  const handleSaveChanges = async () => {
    const totalChanges = itemsToAdd.length + itemsToRemove.length;
    if (totalChanges === 0) return;

    setLoading(true);
    try {
      const promises = [];

      // 1. Process Additions
      if (itemsToAdd.length > 0) {
        promises.push(apiClient('/promotions/apply', {
          method: 'POST',
          body: JSON.stringify({
            promotion_id: promotion.promotion_id,
            item_ids: itemsToAdd
          })
        }));
      }

      // 2. Process Removals
      if (itemsToRemove.length > 0) {
        promises.push(apiClient('/promotions/remove', {
          method: 'POST',
          body: JSON.stringify({ item_ids: itemsToRemove })
        }));
      }

      await Promise.all(promises);

      toast.success(`Updated successfully! (+${itemsToAdd.length}, -${itemsToRemove.length})`);
      if (onRefresh) onRefresh();
      onClose(); // Close modal only on success
    } catch (error) {
      toast.error("Failed to save changes: " + error.message);
    } finally {
      setLoading(false);
    }
  };

  // Calculate pending counts for UI
  const hasChanges = itemsToAdd.length > 0 || itemsToRemove.length > 0;

  return (
    <div className="fixed inset-0 bg-black/75 z-50 flex justify-center items-center">
      <div className="bg-white rounded-lg shadow-xl w-full max-w-2xl h-[80vh] flex flex-col">
        
        {/* Header */}
        <div className="p-6 border-b flex justify-between items-center bg-gray-50 rounded-t-lg">
          <div>
            <h2 className="text-xl font-bold text-[#3C2A21]">Manage: {promotion.name}</h2>
            <p className="text-sm text-gray-500">
                <span className="text-green-600 font-bold">{promotion.discount_percentage}% OFF</span> • Select items to add or remove
            </p>
          </div>
          <button onClick={onClose} className="text-gray-400 hover:text-gray-800"><X /></button>
        </div>

        {/* Search Bar */}
        <div className="p-4 border-b flex gap-4 items-center bg-white">
            <div className="relative flex-1">
                <Search className="absolute left-3 top-2.5 text-gray-400" size={18}/>
                <input 
                    type="text" 
                    placeholder="Search items..." 
                    value={searchTerm}
                    onChange={e => setSearchTerm(e.target.value)}
                    className="w-full pl-10 pr-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                />
            </div>
            <button onClick={handleSelectAll} className="text-sm font-semibold text-blue-600 hover:underline">
                Select All Visible
            </button>
        </div>

        {/* Items List */}
        <div className="flex-1 overflow-y-auto p-4 grid grid-cols-1 gap-2 bg-gray-50">
            {filteredItems.map(item => {
                const isCurrent = isLinkedToCurrent(item);
                const isOther = isLinkedToOther(item);
                
                // Check pending states
                const isMarkedForAdd = itemsToAdd.includes(item.item_id);
                const isMarkedForRemove = itemsToRemove.includes(item.item_id);

                // Determine Styles based on state
                let containerClass = "bg-white border-gray-200 hover:border-blue-300"; // Default
                let icon = <div className="w-5 h-5 rounded-full border border-gray-300" />; // Empty circle
                let statusText = null;

                if (isCurrent) {
                    if (isMarkedForRemove) {
                        // Was Active -> Now Marked for Removal
                        containerClass = "bg-red-50 border-red-300 opacity-75";
                        icon = <Undo2 size={20} className="text-red-500" />;
                        statusText = <span className="text-red-600 font-bold text-xs">Removing...</span>;
                    } else {
                        // Active (Stable)
                        containerClass = "bg-green-50 border-green-300 hover:bg-red-50 hover:border-red-300 group";
                        icon = (
                            <>
                                <CheckCircle size={20} className="text-green-600 group-hover:hidden" />
                                <Trash2 size={20} className="text-red-500 hidden group-hover:block" />
                            </>
                        );
                        statusText = <span className="text-green-600 font-bold text-xs group-hover:text-red-500">Active (Click to remove)</span>;
                    }
                } else if (isMarkedForAdd) {
                    // Was Inactive -> Now Marked for Add
                    containerClass = "bg-blue-50 border-blue-500";
                    icon = <CheckCircle size={20} className="text-blue-600" />;
                    statusText = <span className="text-blue-600 font-bold text-xs">Will Add</span>;
                } else if (isOther) {
                    // Linked to another promo
                    containerClass = "bg-orange-50 border-orange-200 opacity-75";
                    statusText = <span className="text-orange-600 text-xs">In: {item.promo_name}</span>;
                }

                return (
                    <div 
                        key={item.item_id}
                        onClick={() => handleRowClick(item)}
                        className={`p-3 border rounded-lg flex justify-between items-center cursor-pointer transition-all ${containerClass}`}
                    >
                        <div className="flex items-center gap-3">
                            <div className="flex items-center justify-center w-6">
                                {icon}
                            </div>
                            <div>
                                <p className={`font-medium ${isMarkedForRemove ? 'text-gray-400 line-through' : 'text-gray-800'}`}>
                                    {item.item_name}
                                </p>
                                <p className="text-xs text-gray-500">{item.category}</p>
                            </div>
                        </div>
                        <div>{statusText}</div>
                    </div>
                );
            })}
        </div>

        {/* Footer with Save Button */}
        <div className="p-4 border-t bg-white rounded-b-lg flex justify-between items-center shadow-[0_-4px_6px_-1px_rgba(0,0,0,0.1)]">
            <div className="text-sm text-gray-600">
                {itemsToAdd.length > 0 && <span className="text-blue-600 font-bold mr-3">+ Adding {itemsToAdd.length}</span>}
                {itemsToRemove.length > 0 && <span className="text-red-600 font-bold">- Removing {itemsToRemove.length}</span>}
                {!hasChanges && "No changes pending"}
            </div>
            
            <div className="flex gap-3">
                <button 
                    onClick={onClose}
                    className="px-4 py-2 text-gray-600 hover:bg-gray-100 rounded-lg font-medium"
                >
                    Cancel
                </button>
                <button 
                    onClick={handleSaveChanges} 
                    disabled={!hasChanges || loading}
                    className={`px-6 py-2 rounded-lg font-bold flex items-center gap-2 transition-colors ${
                        hasChanges 
                        ? "bg-[#F9A825] text-white hover:bg-yellow-600 shadow-md" 
                        : "bg-gray-200 text-gray-400 cursor-not-allowed"
                    }`}
                >
                    {loading ? 'Saving...' : <><Save size={18}/> Save Changes</>}
                </button>
            </div>
        </div>

      </div>
    </div>
  );
};

export default ApplyPromoModal;
import React, { useState, useEffect } from 'react';
import { Plus, Tag, Calendar, Trash2, CheckCircle, Power, XCircle } from 'lucide-react';
import apiClient from '../../../utils/apiClient';
import AddPromotionModal from './AddPromotionModal';
import ApplyPromoModal from './ApplyPromoModal';
import toast from 'react-hot-toast';

const PromotionsManagement = () => {
  const [promotions, setPromotions] = useState([]);
  const [allItems, setAllItems] = useState([]); // We need items to pass to the Apply Modal
  const [loading, setLoading] = useState(true);
  
  // Modal States
  const [isAddModalOpen, setIsAddModalOpen] = useState(false);
  const [selectedPromoForApply, setSelectedPromoForApply] = useState(null); // If not null, Apply Modal is open

  // 1. Fetch Data
  const fetchData = async () => {
    setLoading(true);
    try {
      const [promosRes, itemsRes] = await Promise.all([
        apiClient('/promotions'),
        apiClient('/items') // We need all items to show in the checklist
      ]);

      if (promosRes.ok) setPromotions(await promosRes.json());
      if (itemsRes.ok) setAllItems(await itemsRes.json());

    } catch (err) {
      console.error("Failed to load promotions data", err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchData();
  }, []);

  const handleDelete = async (id) => {
  if (!window.confirm('Are you sure you want to delete this campaign? All linked items will revert to their original price.')) {
    return;
  }

  try {
    const response = await apiClient(`/promotions/${id}`, {
      method: 'DELETE',
    });

    if (!response.ok) throw new Error('Failed to delete promotion');

    toast.success('Promotion deleted successfully');
    fetchData(); // Refresh the list
  } catch (error) {
    toast.error(error.message);
  }
};

const handleToggleStatus = async (id, currentStatus) => {
    const action = currentStatus ? 'deactivate' : 'activate';
    if (!window.confirm(`Are you sure you want to ${action} this campaign?`)) return;

    try {
      const response = await apiClient(`/promotions/${id}/status`, {
        method: 'PUT',
      });

      if (!response.ok) throw new Error('Failed to update status');
      
      toast.success(`Promotion ${action}d successfully`);
      fetchData(); // Refresh list
    } catch (error) {
      toast.error(error.message);
    }
  };

  return (
    <div className="mt-8">
      <div className="flex justify-between items-center mb-6">
        <h2 style={{ color: '#F9A825', fontSize: '1.5rem', fontWeight: 'bold' }}>Promotion Campaigns</h2>
        <button
          onClick={() => setIsAddModalOpen(true)}
          className="bg-[#F9A825] text-white font-bold py-2 px-4 rounded hover:bg-[#c47b04] transition-colors flex items-center gap-2"
        >
          <Plus size={20} /> Create New Promo
        </button>
      </div>

      {loading ? <p className="text-white">Loading campaigns...</p> : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {promotions.map(promo => (
                <div key={promo.promotion_id} className={`bg-white rounded-lg shadow-md p-5 border-l-4 relative ${promo.is_active ? 'border-[#F9A825]' : 'border-gray-300'}`}>
                    {/* Header */}
                    <div className="flex justify-between items-start">
                        <div>
                            <h3 className={`text-lg font-bold ${promo.is_active ? 'text-gray-800' : 'text-gray-500'}`}>
                                {promo.name}
                            </h3>
                            <span className={`inline-block text-xs font-bold px-2 py-1 rounded mt-1 ${promo.is_active ? 'bg-red-100 text-red-600' : 'bg-gray-200 text-gray-500'}`}>
                                {promo.discount_percentage}% OFF
                            </span>
                        </div>
                        
                        {/* Status Badge */}
                        <div className={`flex items-center gap-1 text-xs font-bold px-2 py-1 rounded-full ${promo.is_active ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-500'}`}>
                            {promo.is_active ? <CheckCircle size={14}/> : <XCircle size={14}/>}
                            {promo.is_active ? 'ACTIVE' : 'PAUSED'}
                        </div>
                    </div>
                    
                    <p className="text-sm text-gray-600 mt-3 mb-4 min-h-[40px]">
                        {promo.description || "No description provided."}
                    </p>

                    <div className="flex items-center text-xs text-gray-500 mb-4">
                        <Calendar size={14} className="mr-1"/> 
                        {new Date(promo.start_date).toLocaleDateString()} - {new Date(promo.end_date).toLocaleDateString()}
                    </div>

                    {/* Action Buttons */}
                    <div className="flex gap-2 mt-auto pt-3 border-t">
                        {/* Apply/Manage Button */}
                        <button 
                            onClick={() => setSelectedPromoForApply(promo)}
                            className={`flex-1 font-semibold py-2 rounded text-sm flex justify-center items-center gap-2 ${
                                promo.item_count > 0 
                                ? "bg-green-50 text-green-600 hover:bg-green-100" 
                                : "bg-blue-50 text-blue-600 hover:bg-blue-100"
                            }`}
                            title="Manage Items"
                        >
                            <Tag size={16}/> 
                            {promo.item_count > 0 ? `Manage (${promo.item_count})` : "Add Items"}
                        </button>

                        {/* Toggle Status Button */}
                        <button 
                            onClick={() => handleToggleStatus(promo.promotion_id, promo.is_active)}
                            className={`px-3 py-2 font-semibold rounded text-sm flex justify-center items-center ${
                                promo.is_active 
                                ? "bg-orange-50 text-orange-600 hover:bg-orange-100" 
                                : "bg-gray-100 text-gray-600 hover:bg-gray-200"
                            }`}
                            title={promo.is_active ? "Pause Campaign" : "Activate Campaign"}
                        >
                            <Power size={16}/>
                        </button>
                        
                        {/* Delete Button */}
                        <button 
                            onClick={() => handleDelete(promo.promotion_id)}
                            className="px-3 py-2 bg-red-50 text-red-600 font-semibold rounded hover:bg-red-100 text-sm flex justify-center items-center"
                            title="Delete Campaign"
                        >
                            <Trash2 size={16}/>
                        </button>
                    </div>
                </div>
            ))}
        </div>
      )}

      {/* Modals */}
      <AddPromotionModal 
        isOpen={isAddModalOpen} 
        onClose={() => setIsAddModalOpen(false)} 
        onSave={fetchData} 
      />
      
      <ApplyPromoModal
        isOpen={!!selectedPromoForApply}
        onClose={() => setSelectedPromoForApply(null)}
        promotion={selectedPromoForApply}
        allItems={allItems}
        onRefresh={fetchData}
      />
    </div>
  );
};

export default PromotionsManagement;
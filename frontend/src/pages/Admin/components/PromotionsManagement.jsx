import React, { useState, useEffect } from 'react';
import { Plus, Tag, Calendar, Trash2, CheckCircle, Power, XCircle, Megaphone, Save } from 'lucide-react';
import apiClient from '../../../utils/apiClient';
import AddPromotionModal from './AddPromotionModal';
import ApplyPromoModal from './ApplyPromoModal';
import toast from 'react-hot-toast';
import '../AdminTheme.css';

const PromotionsManagement = () => {
  const [promotions, setPromotions] = useState([]);
  const [allItems, setAllItems] = useState([]); 
  const [loading, setLoading] = useState(true);
  const [promoToEdit, setPromoToEdit] = useState(null);
  
  // Announcement State
  const [announcement, setAnnouncement] = useState('');
  const [isSavingAnnouncement, setIsSavingAnnouncement] = useState(false);
  
  // Modal States
  const [isAddModalOpen, setIsAddModalOpen] = useState(false);
  const [selectedPromoForApply, setSelectedPromoForApply] = useState(null); 

  // 1. Fetch Data
  const fetchData = async () => {
    setLoading(true);
    try {
      const [promosRes, itemsRes, annRes] = await Promise.all([
        apiClient('/promotions'),
        apiClient('/items'),
        apiClient('/announcement')
      ]);

      if (promosRes.ok) setPromotions(await promosRes.json());
      if (itemsRes.ok) setAllItems(await itemsRes.json());
      if (annRes.ok) {
        const data = await annRes.json();
        setAnnouncement(data.message || '');
      }

    } catch (err) {
      console.error("Failed to load data", err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => { fetchData(); }, []);

  // --- Handlers ---
  const handleSaveAnnouncement = async () => {
    setIsSavingAnnouncement(true);
    try {
      const res = await apiClient('/announcement', {
        method: 'PUT',
        body: JSON.stringify({ message: announcement })
      });
      if (!res.ok) throw new Error('Failed to update announcement');
      toast.success('Announcement updated!');
    } catch (error) {
      toast.error(error.message);
    } finally {
      setIsSavingAnnouncement(false);
    }
  };

  const handleDelete = async (id) => {
    if (!window.confirm('Are you sure you want to delete this campaign?')) return;
    try {
      const response = await apiClient(`/promotions/${id}`, { method: 'DELETE' });
      if (!response.ok) throw new Error('Failed to delete promotion');
      toast.success('Promotion deleted');
      fetchData(); 
    } catch (error) {
      toast.error(error.message);
    }
  };

  const handleToggleStatus = async (id, currentStatus) => {
    const action = currentStatus ? 'deactivate' : 'activate';
    if (!window.confirm(`Are you sure you want to ${action} this campaign?`)) return;
    try {
      const response = await apiClient(`/promotions/${id}/status`, { method: 'PUT' });
      if (!response.ok) throw new Error('Failed to update status');
      toast.success(`Promotion ${action}d`);
      fetchData(); 
    } catch (error) {
      toast.error(error.message);
    }
  };

  return (
    <div className="w-full">
      
      {/* 1. HEADER ROW */}
      <div className="flex flex-col sm:flex-row justify-between items-center gap-4 mb-6">
        <div>
            <h2 className="admin-page-title mb-1">Promo Management</h2>
            <p className="text-sm text-gray-300">Manage discounts and announcements</p>
        </div>
        
        <button
          onClick={() => { setPromoToEdit(null); setIsAddModalOpen(true); }}
          className="admin-btn admin-btn-primary"
        >
          <Plus size={20} /> Create New Promo
        </button>
      </div>
      
      {/* 2. ANNOUNCEMENT CARD */}
      <div className="admin-card border-l-4" style={{ borderLeftColor: '#F9A825' }}>
        <div className="flex items-center gap-2 mb-3 text-[#3C2A21] font-bold text-lg">
          <Megaphone size={24} className="text-[#F9A825]" />
          <h2>Global Announcement</h2>
        </div>
        <p className="text-sm text-gray-500 mb-4">
          This message will appear at the top of the customer menu.
        </p>
        <div className="flex gap-4">
          <input 
            type="text" 
            value={announcement}
            onChange={(e) => setAnnouncement(e.target.value)}
            placeholder="e.g. Happy Holidays! Enjoy 50% off on all desserts."
            className="flex-1 p-2 rounded border border-[#D1C0B6] bg-white outline-none focus:border-[#F9A825] focus:ring-1 focus:ring-[#F9A825]"
          />
          <button 
            onClick={handleSaveAnnouncement}
            disabled={isSavingAnnouncement}
            className="admin-btn bg-[#0B3D2E] text-white hover:bg-[#082f23] disabled:opacity-50"
          >
            <Save size={18} />
            {isSavingAnnouncement ? 'Saving...' : 'Save'}
          </button>
        </div>
      </div>

      {/* 3. PROMO GRID */}
      {loading ? <p className="text-white text-center p-8">Loading campaigns...</p> : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {promotions.map(promo => (
                <div 
                    key={promo.promotion_id} 
                    className={`admin-card relative border-l-4 p-6 flex flex-col h-full ${promo.is_active ? 'border-l-[#F9A825]' : 'border-l-gray-400'}`}
                >
                    {/* Card Header */}
                    <div className="flex justify-between items-start mb-2">
                        <div>
                            <h3 className={`text-lg font-bold ${promo.is_active ? 'text-[#3C2A21]' : 'text-gray-500'}`}>
                                {promo.name}
                            </h3>
                            <span className={`inline-block text-xs font-bold px-2 py-1 rounded mt-1 ${promo.is_active ? 'bg-[#F9A825] text-white' : 'bg-gray-200 text-gray-500'}`}>
                                {promo.discount_percentage}% OFF
                            </span>
                        </div>
                        
                        <div className={`flex items-center gap-1 text-xs font-bold px-2 py-1 rounded-full ${promo.is_active ? 'bg-green-100 text-green-700' : 'bg-gray-200 text-gray-500'}`}>
                            {promo.is_active ? <CheckCircle size={14}/> : <XCircle size={14}/>}
                            {promo.is_active ? 'ACTIVE' : 'PAUSED'}
                        </div>
                    </div>
                    
                    {/* Description */}
                    <p className="text-sm mt-3 mb-4 flex-1" style={{ color: '#503C30' }}>
                        {promo.description || "No description provided."}
                    </p>

                    {/* Date */}
                    <div className="flex items-center text-xs mb-4 text-gray-500 font-medium">
                        <Calendar size={14} className="mr-1"/> 
                        {new Date(promo.start_date).toLocaleDateString()} - {new Date(promo.end_date).toLocaleDateString()}
                    </div>

                    {/* Actions */}
                    <div className="flex gap-2 pt-3 border-t border-[#D1C0B6]">
                        <button 
                            onClick={async () => {
                                const itemsRes = await apiClient('/items');
                                if (itemsRes.ok) setAllItems(await itemsRes.json());
                                setSelectedPromoForApply(promo);
                            }}
                            className={`flex-1 font-bold py-2 rounded text-sm flex justify-center items-center gap-2 transition-colors ${
                                promo.item_count > 0 
                                ? "bg-[#0B3D2E] text-white hover:bg-[#082f23]" 
                                : "bg-[#F9A825] text-white hover:bg-[#c47b04]"
                            }`}
                        >
                            <Tag size={16}/> 
                            {promo.item_count > 0 ? `Manage (${promo.item_count})` : "Add Items"}
                        </button>

                        <button 
                            onClick={() => handleToggleStatus(promo.promotion_id, promo.is_active)}
                            className={`px-3 py-2 font-semibold rounded text-sm flex justify-center items-center border transition-colors ${
                                promo.is_active 
                                ? "border-[#F9A825] text-[#F9A825] hover:bg-[#fff8e1]" 
                                : "bg-gray-200 text-gray-600 border-transparent hover:bg-gray-300"
                            }`}
                            title={promo.is_active ? "Pause Campaign" : "Activate Campaign"}
                        >
                            <Power size={16}/>
                        </button>
                        
                        <button 
                            onClick={() => handleDelete(promo.promotion_id)}
                            className="px-3 py-2 bg-red-100 text-red-600 font-semibold rounded hover:bg-red-200 text-sm flex justify-center items-center"
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
        onClose={() => { setIsAddModalOpen(false); setPromoToEdit(null); }} 
        onSave={fetchData}
        promotionToEdit={promoToEdit} 
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
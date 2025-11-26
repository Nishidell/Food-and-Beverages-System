import React, { useState, useEffect } from 'react';
import { Users, CheckCircle, XCircle, Clock } from 'lucide-react';
import toast from 'react-hot-toast';
import apiClient from '../../utils/apiClient';
import InternalNavBar from './components/InternalNavBar';
import './KitchenTheme.css'; 

const pageTitleStyle = {
  fontSize: '1.875rem', // 30px
  fontWeight: 'bold',
  marginBottom: '24px',
  textAlign: 'center',
  color: '#F9A825', // Make the title white
};

const TableManager = () => {
  const [tables, setTables] = useState([]);
  const [loading, setLoading] = useState(true);

  const fetchTables = async () => {
    try {
      const response = await apiClient('/tables');
      if (response.ok) {
        setTables(await response.json());
      }
    } catch (error) {
      toast.error("Failed to load tables");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchTables();
    // Optional: Auto-refresh every 30 seconds to see updates from other staff
    const interval = setInterval(fetchTables, 30000);
    return () => clearInterval(interval);
  }, []);

  const handleToggleStatus = async (table) => {
    // Logic: If Available -> Set to Occupied. If Occupied -> Set to Available.
    const newStatus = table.status === 'Available' ? 'Occupied' : 'Available';
    
    if (!window.confirm(`Set Table ${table.table_number} to ${newStatus}?`)) return;

    try {
        const res = await apiClient(`/tables/${table.table_id}/status`, {
            method: 'PUT',
            body: JSON.stringify({ status: newStatus })
        });
        
        if (!res.ok) throw new Error("Failed to update");
        
        toast.success(`Table ${table.table_number} is now ${newStatus}`);
        fetchTables(); // Refresh UI
    } catch (error) {
        toast.error(error.message);
    }
  };

  return (
    <div className="flex flex-col h-screen" style={{ backgroundColor: '#523a2eff' }}>
      <InternalNavBar />
      
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <h1 style={pageTitleStyle}>Manage Table Availability</h1>

        {loading ? <p>Loading...</p> : (
            <div className="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-5 gap-6">
                {tables.map((table) => (
                    <div 
                        key={table.table_id}
                        onClick={() => handleToggleStatus(table)}
                        className={`relative p-6 rounded-xl shadow-lg border-4 cursor-pointer transition-transform hover:scale-105 flex flex-col items-center justify-center h-40
                            ${table.status === 'Available' 
                                ? 'bg-green-50 border-green-500' 
                                : 'bg-red-50 border-red-500'
                            }`}
                    >
                        <span className="absolute top-3 right-3 font-bold text-xl text-gray-400">#{table.table_number}</span>
                        
                        {table.status === 'Available' ? (
                            <CheckCircle size={40} className="text-green-500 mb-2" />
                        ) : (
                            <XCircle size={40} className="text-red-500 mb-2" />
                        )}
                        
                        <h3 className={`text-lg font-bold ${table.status === 'Available' ? 'text-green-700' : 'text-red-700'}`}>
                            {table.status}
                        </h3>
                        
                        <div className="flex items-center gap-1 text-gray-500 text-sm mt-1">
                            <Users size={14} />
                            <span>{table.capacity} Seats</span>
                        </div>
                    </div>
                ))}
            </div>
        )}
      </div>
    </div>
  );
};

export default TableManager;
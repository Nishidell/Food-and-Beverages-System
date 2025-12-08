import React, { useState, useEffect } from 'react';
import { Edit, Trash2, Users, Plus } from 'lucide-react'; // Added Plus icon
import toast from 'react-hot-toast';
import apiClient from '../../../utils/apiClient';
import TableModal from './TableModal';
import '../AdminTheme.css'; 

const TableManagement = () => {
  const [tables, setTables] = useState([]);
  const [loading, setLoading] = useState(true);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [editingTable, setEditingTable] = useState(null);

  const fetchTables = async () => {
    setLoading(true);
    try {
      const response = await apiClient('/tables');
      if (response.ok) {
        setTables(await response.json());
      }
    } catch (error) {
      toast.error("Failed to fetch tables");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => { fetchTables(); }, []);

  const handleDelete = async (id) => {
    if (!window.confirm("Delete this table?")) return;
    try {
        const res = await apiClient(`/admin/tables/${id}`, { method: 'DELETE' });
        if (res.ok) {
            toast.success("Table deleted");
            fetchTables();
        }
    } catch (err) {
        toast.error("Failed to delete");
    }
  };

  const openAddModal = () => {
    setEditingTable(null);
    setIsModalOpen(true);
  };

  return (
    <div className="w-full">
      {/* 1. HEADER ROW (Title Left, Button Right) */}
      <div className="flex flex-col sm:flex-row justify-between items-center gap-4 mb-6 px-6">
        <div>
           <h2 className="admin-page-title mb-1">Table Management</h2>
           <p className="text-sm text-gray-300">Total Tables: {tables.length}</p>
        </div>
        
        <button 
            onClick={openAddModal} 
            className="admin-btn admin-btn-primary flex items-center gap-2"
        >
          <Plus size={20} /> Add New Table
        </button>
      </div>

      {/* 2. TABLE CONTAINER */}
      <div className="admin-table-container">
        <table className="admin-table">
          <thead>
            <tr>
              <th>Table Number</th>
              <th>Capacity</th>
              <th>Status</th>
              <th className="text-center">Actions</th>
            </tr>
          </thead>
          <tbody>
            {loading ? (
                <tr><td colSpan="4" className="text-center p-8 text-gray-500">Loading tables...</td></tr>
            ) : tables.length === 0 ? (
                <tr><td colSpan="4" className="text-center p-8 text-gray-500">No tables found.</td></tr>
            ) : (
                tables.map((table) => (
                  <tr key={table.table_id}>
                    <td className="font-bold text-lg">Table {table.table_number}</td>
                    <td>
                        <div className="flex items-center gap-2">
                            <Users size={18} className="text-gray-400"/> 
                            <span className="font-medium">{table.capacity} Seats</span>
                        </div>
                    </td>
                    <td>
                        <span className={`status-badge ${
                            table.status?.toLowerCase() === 'available' ? 'bg-green-100 text-green-800' : 
                            table.status?.toLowerCase() === 'occupied' ? 'bg-red-100 text-red-800' :
                            'bg-yellow-100 text-yellow-800'
                        }`}>
                            {table.status}
                        </span>
                    </td>
                    <td className="text-center">
                      <div className="flex justify-center gap-3">
                        <button 
                            onClick={() => { setEditingTable(table); setIsModalOpen(true); }} 
                            className="p-2 text-blue-600 hover:bg-blue-50 rounded transition-colors"
                            title="Edit"
                        >
                          <Edit size={18} />
                        </button>
                        <button 
                            onClick={() => handleDelete(table.table_id)} 
                            className="p-2 text-red-600 hover:bg-red-50 rounded transition-colors"
                            title="Delete"
                        >
                          <Trash2 size={18} />
                        </button>
                      </div>
                    </td>
                  </tr>
                ))
            )}
          </tbody>
        </table>
      </div>

      <TableModal 
        isOpen={isModalOpen}
        onClose={() => setIsModalOpen(false)}
        onSave={fetchTables}
        tableToEdit={editingTable}
      />
    </div>
  );
};

export default TableManagement;
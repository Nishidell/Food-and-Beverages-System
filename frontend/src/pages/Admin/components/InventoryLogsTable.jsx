import React, { useState, useEffect } from 'react';
import toast from 'react-hot-toast';
import { Filter } from 'lucide-react';
import { useAuth } from '../../../context/AuthContext'; 
import apiClient from '../../../utils/apiClient';
import '../AdminTheme.css';

const InventoryLogsTable = () => {
  const [logs, setLogs] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [filterSource, setFilterSource] = useState('All');
  const { token } = useAuth();

  useEffect(() => {
    const fetchLogs = async () => {
      setLoading(true);
      try {
        const response = await apiClient('/inventory/logs');
        if (!response.ok) throw new Error('Failed to fetch inventory logs.');
        const data = await response.json();
        setLogs(data);
      } catch (err) {
        if (err.message !== 'Session expired') {
          setError(err.message);
          toast.error(err.message);
        }
      } finally {
        setLoading(false);
      }
    };
    if (token) fetchLogs();
  }, [token]);

  const getActionStyle = (action) => {
    if (action.includes('ADD') || action.includes('RESTOCK')) return { color: '#059669', backgroundColor: '#D1FAE5' };
    if (action.includes('SUBTRACT') || action.includes('WASTE')) return { color: '#DC2626', backgroundColor: '#FEE2E2' };
    return { color: '#4B5563', backgroundColor: '#E5E7EB' };
  };

  const filteredLogs = logs.filter(log => {
    if (filterSource === 'All') return true;
    const isSystemLog = log.staff_name === 'System (Order)';
    return filterSource === 'System' ? isSystemLog : !isSystemLog;
  });

  if (loading) return <div className="p-8 text-center text-white text-lg">Loading...</div>;
  if (error) return <div className="p-8 text-center text-red-500">Error: {error}</div>;

  return (
    <div className="w-full">
      
      {/* HEADER & FILTER */}
      <div className="flex flex-col sm:flex-row justify-between items-center gap-4 mb-6">
        <div>
            {/* ✅ UPDATED: Use Theme Class */}
            <h2 className="admin-page-title">Inventory Logs</h2>
            <p className="text-sm text-gray-300">Recent Activity: {filteredLogs.length} entries</p>
        </div>
        
        {/* Filter Dropdown */}
        <div className="relative">
            <select 
                value={filterSource}
                onChange={(e) => setFilterSource(e.target.value)}
                className="appearance-none px-6 py-3 pr-10 rounded-lg font-bold shadow-lg outline-none cursor-pointer transition-transform hover:scale-105"
                style={{ backgroundColor: '#F9A825', color: '#3C2A21', border: 'none' }}
            >
                <option value="All">All Sources</option>
                <option value="Staff">Staff Actions</option>
                <option value="System">System Actions</option>
            </select>
            <div className="absolute right-3 top-1/2 transform -translate-y-1/2 pointer-events-none text-[#3C2A21]">
                <Filter size={18} />
            </div>
        </div>
      </div>

      {/* TABLE */}
      <div className="admin-table-container">
        <table className="admin-table">
          <thead>
            <tr>
              <th>Date</th>
              <th>Ingredient</th>
              <th>Staff Member</th>
              <th>Action</th>
              <th>Qty</th>
              <th>New Stock</th>
              <th>Reason</th>
            </tr>
          </thead>
          <tbody>
            {filteredLogs.map((log) => (
              <tr key={log.log_id}>
                <td>{new Date(log.timestamp).toLocaleString()}</td>
                <td className="font-medium">{log.ingredient_name}</td>
                <td>{log.staff_name}</td>
                <td>
                  <span className="status-badge" style={getActionStyle(log.action_type)}>
                    {log.action_type.replace('_', ' ').toLowerCase()}
                  </span>
                </td>
                <td style={{
                     fontWeight: 'bold',
                     color: (log.action_type.includes('ADD') || log.action_type.includes('RESTOCK') || log.action_type === 'INITIAL') ? '#059669' : '#DC2626'
                }}>
                  {(log.action_type.includes('ADD') || log.action_type.includes('RESTOCK') || log.action_type === 'INITIAL') ? '+' : '-'}{log.quantity_change}
                </td>
                <td className="font-bold">{log.new_stock_level}</td>
                <td>{log.reason || 'N/A'}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default InventoryLogsTable;
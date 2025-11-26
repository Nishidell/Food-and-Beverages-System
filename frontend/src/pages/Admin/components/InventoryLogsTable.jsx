import React, { useState, useEffect } from 'react';
import toast from 'react-hot-toast';
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
    let color = '#374151'; 
    let bgColor = '#F3F4F6';

    if (action.includes('ADD') || action.includes('RESTOCK')) {
      color = '#059669'; bgColor = '#D1FAE5';
    } else if (action.includes('SUBTRACT') || action.includes('WASTE')) {
      color = '#DC2626'; bgColor = '#FEE2E2';
    } else if (action.includes('INITIAL')) {
      color = '#4B5563'; bgColor = '#E5E7EB';
    }
    return { color, backgroundColor: bgColor };
  };

  const filteredLogs = logs.filter(log => {
    if (filterSource === 'All') return true;
    const isSystemLog = log.staff_name === 'System (Order)';
    if (filterSource === 'Staff') return !isSystemLog;
    if (filterSource === 'System') return isSystemLog;
    return true;
  });

  if (loading) return <div className="p-8 text-center text-white text-lg">Loading...</div>;
  if (error) return <div className="p-8 text-center text-red-500">Error: {error}</div>;

  return (
    <div className="admin-section-container">
      
      <div className="admin-header-row">
        <div>
          <h2 className="admin-page-title">Inventory Logs</h2>
          <p className="text-sm" style={{ color: '#F9A825' }}>Showing {filteredLogs.length} recent actions</p>
        </div>
        
        <div>
          <label htmlFor="log-filter" className="admin-label" style={{color: '#F9A825'}}>Filter by Source:</label>
          <select 
            id="log-filter"
            className="admin-select"
            style={{ backgroundColor: '#480c1b', color: '#F9A825', borderColor: '#F9A825' }}
            value={filterSource}
            onChange={(e) => setFilterSource(e.target.value)}
          >
            <option value="All">Show All</option>
            <option value="Staff">Staff Actions</option>
            <option value="System">System Actions</option>
          </select>
        </div>
      </div>

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
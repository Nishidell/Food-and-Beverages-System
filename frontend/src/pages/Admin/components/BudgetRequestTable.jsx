import React, { useState, useEffect } from 'react';
import { Plus, Filter, Eye } from 'lucide-react';
import toast from 'react-hot-toast';
import BudgetRequestModal from './BudgetRequestModal';
import { useAuth } from '../../../context/AuthContext';
import apiClient from '../../../utils/apiClient';
import '../AdminTheme.css'; // ✅ Using AdminTheme now

const BudgetRequestsTable = () => {
  const [requests, setRequests] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [filterStatus, setFilterStatus] = useState('All');
  const [isModalOpen, setIsModalOpen] = useState(false);
  
  const { token } = useAuth();

  const fetchRequests = async () => {
    setLoading(true);
    try {
      const response = await apiClient('/budget/budget-requests');
      if (!response.ok) throw new Error('Failed to fetch budget requests.');
      const data = await response.json();
      setRequests(data);
    } catch (err) {
      if (err.message !== 'Session expired') {
        setError(err.message);
        toast.error(err.message);
      }
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (token) {
      fetchRequests();
    }
  }, [token]);

  const handleOpenRequestModal = () => setIsModalOpen(true);
  const handleCloseModal = () => setIsModalOpen(false);

  const handleViewDetails = (request) => {
    const rejectionMsg = request.rejection_reason ? `\n\nRejection Reason: ${request.rejection_reason}` : '';
    alert(`Purpose: ${request.purpose}\nPriority: ${request.priority.toUpperCase()}${rejectionMsg}`);
  };

  const handleSubmitNewRequest = async (formData) => {
    try {
      const response = await apiClient('/budget/budget-requests', {
        method: 'POST',
        body: JSON.stringify(formData),
      });

      if (!response.ok) {
        const errData = await response.json();
        throw new Error(errData.message || 'Failed to submit request.');
      }

      toast.success('Budget request submitted to Accounting!');
      setIsModalOpen(false);
      fetchRequests();
    } catch (err) {
      toast.error(err.message);
    }
  };

  const filteredRequests = requests.filter(req => {
    if (filterStatus === 'All') return true;
    return req.status.toLowerCase() === filterStatus.toLowerCase();
  });

  const formatDate = (dateString) => {
    if (!dateString) return 'N/A';
    return new Date(dateString).toLocaleDateString('en-CA');
  };

  if (loading) return <div className="p-8 text-center text-white text-lg">Loading Budget Requests...</div>;
  if (error) return <div className="p-8 text-center text-red-500">Error: {error}</div>;

  return (
    <div className="w-full">
      {/* HEADER ROW */}
      <div className="flex flex-col sm:flex-row justify-between items-center gap-4 mb-6">
        <div>
          <h2 className="admin-page-title mb-1">Budget Requests</h2>
          <p className="text-sm text-gray-300">Total Requests: {filteredRequests.length}</p>
        </div>

        <div className="flex flex-wrap items-center gap-4 justify-end">
          {/* Filter Dropdown */}
          <div className="relative">
            <select 
              value={filterStatus}
              onChange={(e) => setFilterStatus(e.target.value)}
              className="admin-select-primary appearance-none pr-10" 
              style={{ minWidth: '160px' }}
            >
              <option value="All">All Status</option>
              <option value="Pending">Pending</option>
              <option value="Accepted">Accepted</option>
              <option value="Rejected">Rejected</option>
            </select>
            <div className="absolute right-3 top-1/2 transform -translate-y-1/2 pointer-events-none text-[#3C2A21]">
              <Filter size={18} />
            </div>
          </div>

          {/* Add Request Button */}
          <button 
            onClick={handleOpenRequestModal} 
            className="bg-[#F9A825] text-black font-bold py-2 px-6 rounded hover:bg-[#c47b04] transition-colors flex items-center gap-2"
          >
            <Plus size={20} /> Request Budget
          </button>
        </div>
      </div>

      {/* TABLE CONTAINER */}
      <div className="admin-table-container">
        <table className="admin-table">
          <thead>
            <tr>
              <th>Date</th>
              <th>Request Title</th>
              <th>Amount</th>
              <th>Status</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            {filteredRequests.map((req) => (
              <tr key={req.id}>
                <td>{formatDate(req.date)}</td>
                <td className="font-medium">{req.title}</td>
                <td style={{ color: '#059669', fontWeight: 'bold' }}>
                  ₱{parseFloat(req.requested_amount).toLocaleString('en-PH', { minimumFractionDigits: 2 })}
                </td>
                <td>
                  <span className={`inline-flex items-center px-3 py-1 rounded-full text-xs font-bold uppercase border 
                    ${req.status === 'accepted' ? 'bg-[#D1FAE5] text-[#059669] border-green-200' : 
                      req.status === 'rejected' ? 'bg-[#FEE2E2] text-[#DC2626] border-red-200' : 
                      'bg-yellow-100 text-yellow-700 border-yellow-200'}`}>
                    {req.status}
                  </span>
                </td>
                <td>
                  <button 
                    onClick={() => handleViewDetails(req)} 
                    className="p-2 text-blue-600 hover:bg-blue-100 rounded transition-colors" 
                    title="View Details"
                  >
                    <Eye size={18} />
                  </button>
                </td>
              </tr>
            ))}
            {filteredRequests.length === 0 && (
              <tr>
                <td colSpan="5" className="text-center p-8 text-gray-500">No requests found for F&B.</td>
              </tr>
            )}
          </tbody>
        </table>
      </div>

      {/* RENDER THE MODAL */}
      <BudgetRequestModal 
        isOpen={isModalOpen} 
        onClose={handleCloseModal} 
        onSubmit={handleSubmitNewRequest} 
      />
    </div>
  );
};

export default BudgetRequestsTable;
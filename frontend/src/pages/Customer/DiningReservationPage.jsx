import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Calendar, Clock, Users, CheckCircle, ArrowRight } from 'lucide-react';
import { useAuth } from '../../context/AuthContext';
import apiClient from '../../utils/apiClient';
import toast from 'react-hot-toast';

const DiningReservationPage = () => {
  const { token } = useAuth(); // We need to make sure they are logged in!
  const navigate = useNavigate();
  
  const [formData, setFormData] = useState({
    reservation_date: '',
    reservation_time: '18:00', // Default to 6:00 PM
    party_size: 2,
    special_requests: ''
  });

  const [loading, setLoading] = useState(false);
  const [successData, setSuccessData] = useState(null); 

  const [availableTables, setAvailableTables] = useState([]);
  const [showTableModal, setShowTableModal] = useState(false);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({ ...prev, [name]: value }));
  };

  // STEP 1: Search for tables instead of booking immediately
  const handleFindTableSubmit = async (e) => {
    e.preventDefault();
    if (!token) {
      toast.error("Please log in to make a dining reservation.");
      return;
    }
    if (!formData.reservation_date) {
      toast.error("Please select a date.");
      return;
    }

    setLoading(true);
    try {
      const response = await apiClient('/reservations/available-tables', {
        method: 'POST',
        body: JSON.stringify({
          date: formData.reservation_date,
          time: formData.reservation_time,
          party_size: formData.party_size
        }),
      });
      
      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.message || 'Failed to search for tables.');
      }

      if (data.length === 0) {
        toast.error("No tables available for this time slot. Please try another time.");
      } else {
        setAvailableTables(data);
        setShowTableModal(true); // Open the picker!
      }
      
    } catch (err) {
      toast.error(err.message);
    } finally {
      setLoading(false);
    }
  };

  // STEP 2: Finalize booking when they click a specific table
  const handleSelectTableAndBook = async (tableId) => {
    setLoading(true);
    try {
      // Attach the specific table_id to our form payload
      const finalPayload = { ...formData, table_id: tableId };

      const response = await apiClient('/reservations/book', {
        method: 'POST',
        body: JSON.stringify(finalPayload),
      });
      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.message || 'Failed to book table.');
      }

      setSuccessData(data);
      setShowTableModal(false); // Close modal
      toast.success("Table Confirmed!");
      
    } catch (err) {
      toast.error(err.message);
    } finally {
      setLoading(false);
    }
  };

  // --- UI RENDER ---

  // If the booking is successful, show a beautiful confirmation screen instead of the form
  if (successData) {
    return (
      <div className="min-h-screen bg-[#FFF8E7] flex flex-col items-center justify-center p-6">
        <CheckCircle size={80} className="text-green-600 mb-6" />
        <h1 className="text-4xl font-bold text-[#480c1b] mb-4">You're All Set!</h1>
        <p className="text-lg text-gray-700 text-center max-w-md mb-8">
          Your table has been automatically assigned and your reservation is confirmed. We just sent a confirmation email to your inbox!
        </p>
        <button 
          onClick={() => window.location.reload()} 
          className="bg-[#F9A825] text-[#480c1b] font-bold py-3 px-8 rounded hover:bg-[#c47b04] transition-colors"
        >
          Book Another Table
        </button>
      </div>
    );
  }

  // Standard Booking UI
  return (
    <div className="min-h-screen bg-[#FFF8E7] flex flex-col relative">
      
      {/* Hero Header Section */}
      <div className="h-96 bg-[#480c1b] w-full flex flex-col items-center justify-center text-center px-4 relative">
        
        {/* Top Navigation Bar */}
        <div className="absolute top-6 w-full max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 flex justify-between items-center left-0 right-0">

          <button 
            onClick={() => navigate('https://thecelestiahotel.vercel.app/')} 
            className="bg-[#F9A825] text-[#480c1b] px-5 py-2 rounded-md font-bold hover:bg-white transition-colors shadow-lg"
          >
            CRS Portal
          </button>

          <button 
            onClick={() => navigate('/')} 
            className="flex items-center gap-2 text-[#F9A825] hover:text-white transition-colors font-bold"
          >
            <span className="hidden sm:inline">Explore Menu</span>
            <ArrowRight size={24} /> 
          </button>
        </div>

        <h1 className="text-5xl md:text-6xl font-serif text-[#F9A825] mb-4">Dining at Celestia</h1>
        <p className="text-white text-lg md:text-xl max-w-2xl">
          Experience the dancing flames of the grill. Reserve your unforgettable dining experience tonight.
        </p>
      </div>

      {/* The "Okada" Floating Booking Bar */}
      <div className="w-full max-w-5xl mx-auto -mt-16 px-4 relative z-10">
        <div className="bg-white rounded-lg shadow-2xl p-6 md:p-8 border-t-4 border-[#F9A825]">
          
         <form onSubmit={handleFindTableSubmit} className="flex flex-col md:flex-row items-end gap-6">
            
            {/* Party Size */}
            <div className="w-full md:w-1/4">
              <label className="block text-sm font-bold text-[#480c1b] mb-2 flex items-center gap-2">
                <Users size={16} /> Party Size
              </label>
              <select
                name="party_size"
                value={formData.party_size}
                onChange={handleChange}
                className="w-full border-b-2 border-gray-300 py-2 focus:border-[#F9A825] outline-none bg-transparent"
              >
                {[1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map(num => (
                  <option key={num} value={num}>{num} {num === 1 ? 'Person' : 'People'}</option>
                ))}
              </select>
            </div>

            {/* Date */}
            <div className="w-full md:w-1/4">
              <label className="block text-sm font-bold text-[#480c1b] mb-2 flex items-center gap-2">
                <Calendar size={16} /> Date
              </label>
              <input
                type="date"
                name="reservation_date"
                value={formData.reservation_date}
                onChange={handleChange}
                required
                // Prevent booking in the past
                min={new Date().toISOString().split("T")[0]} 
                className="w-full border-b-2 border-gray-300 py-2 focus:border-[#F9A825] outline-none bg-transparent"
              />
            </div>

            {/* Time */}
            <div className="w-full md:w-1/4">
              <label className="block text-sm font-bold text-[#480c1b] mb-2 flex items-center gap-2">
                <Clock size={16} /> Time
              </label>
              <input
                type="time"
                name="reservation_time"
                value={formData.reservation_time}
                onChange={handleChange}
                required
                className="w-full border-b-2 border-gray-300 py-2 focus:border-[#F9A825] outline-none bg-transparent"
              />
            </div>

            {/* Submit Button */}
            <div className="w-full md:w-1/4">
              <button
                type="submit"
                disabled={loading}
                className="w-full bg-[#480c1b] text-[#F9A825] font-bold py-3 px-4 rounded hover:bg-[#2d0711] transition-colors disabled:opacity-50"
              >
                {loading ? 'Searching...' : 'FIND A TABLE'}
              </button>
            </div>

          </form>

          {/* Optional Special Requests & Notify Me */}
          <div className="mt-8 pt-6 border-t border-gray-100 flex flex-col md:flex-row items-end gap-4">
            <div className="flex-1 w-full">
              <label className="block text-sm font-bold text-gray-500 mb-2">
                Special Requests (Optional)
              </label>
              <input
                type="text"
                name="special_requests"
                value={formData.special_requests}
                onChange={handleChange}
                placeholder="Anniversary, allergies, high chair needed..."
                className="w-full border border-gray-200 rounded p-3 text-sm focus:border-[#F9A825] outline-none"
              />
            </div>
          </div>

          {/* ================= TABLE SELECTION MODAL ================= */}
      {showTableModal && (
        <div className="fixed inset-0 bg-black bg-opacity-70 flex items-center justify-center z-50 p-4 animate-fadeIn">
          <div className="bg-white rounded-lg shadow-2xl max-w-3xl w-full overflow-hidden flex flex-col max-h-[80vh]">
            
            {/* Modal Header */}
            <div className="bg-[#480c1b] p-6 text-white flex justify-between items-center">
              <div>
                <h2 className="text-2xl font-serif text-[#F9A825]">Select Your Table</h2>
                <p className="text-sm opacity-80 mt-1">
                  Showing available tables for {formData.party_size} Pax on {formData.reservation_date} at {formData.reservation_time}
                </p>
              </div>
              <button 
                onClick={() => setShowTableModal(false)}
                className="text-white hover:text-[#F9A825] text-3xl font-light transition-colors"
              >×</button>
            </div>

            {/* Modal Body - Table Grid */}
            <div className="p-6 overflow-y-auto bg-[#FFF8E7] flex-1">
              <div className="grid grid-cols-2 md:grid-cols-3 gap-4">
                {availableTables.map(table => (
                  <button
                    key={table.table_id}
                    onClick={() => handleSelectTableAndBook(table.table_id)}
                    disabled={loading}
                    className="flex flex-col items-center justify-center p-6 bg-white border-2 border-green-500 rounded-lg hover:bg-green-50 hover:-translate-y-1 transition-all shadow cursor-pointer group disabled:opacity-50"
                  >
                    <div className="w-12 h-12 rounded-full border-4 border-green-500 mb-3 flex items-center justify-center group-hover:scale-110 transition-transform">
                      <span className="font-bold text-green-600">{table.seating_capacity}</span>
                    </div>
                    <h3 className="font-bold text-gray-800 text-lg">Table {table.table_number}</h3>
                    <p className="text-xs text-gray-500 uppercase tracking-wider mt-1">Available</p>
                    
                    <div className="mt-4 bg-green-600 text-white text-xs font-bold py-1 px-4 rounded-full opacity-0 group-hover:opacity-100 transition-opacity">
                      Select & Book
                    </div>
                  </button>
                ))}
              </div>
            </div>
            
          </div>
        </div>
      )}

        </div>
      </div>

    </div>
  );
};

export default DiningReservationPage;
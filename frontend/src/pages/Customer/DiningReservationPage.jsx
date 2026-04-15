import React, { useState } from 'react';
import { Calendar, Clock, Users, CheckCircle } from 'lucide-react';
import { useAuth } from '../../context/AuthContext';
import apiClient from '../../utils/apiClient';
import toast from 'react-hot-toast';

const DiningReservationPage = () => {
  const { token } = useAuth(); // We need to make sure they are logged in!
  
  const [formData, setFormData] = useState({
    reservation_date: '',
    reservation_time: '18:00', // Default to 6:00 PM
    party_size: 2,
    special_requests: ''
  });

  const [loading, setLoading] = useState(false);
  const [successData, setSuccessData] = useState(null); // Holds data when booking succeeds

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({ ...prev, [name]: value }));
  };

  const handleBookingSubmit = async (e) => {
    e.preventDefault();
    
    if (!token) {
      toast.error("Please log in to make a dining reservation.");
      return;
    }

    setLoading(true);
    try {
      // NOTE: Adjust this URL to match your server.js route!
      const response = await apiClient('/reservations/book', {
        method: 'POST',
        body: JSON.stringify(formData),
      });

      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.message || 'Failed to book table.');
      }

      // It worked! Show the success screen
      setSuccessData(data);
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
      <div className="h-96 bg-[#480c1b] w-full flex flex-col items-center justify-center text-center px-4">
        <h1 className="text-5xl md:text-6xl font-serif text-[#F9A825] mb-4">Enbu at Celestia</h1>
        <p className="text-white text-lg md:text-xl max-w-2xl">
          Experience the dancing flames of the grill. Reserve your unforgettable dining experience tonight.
        </p>
      </div>

      {/* The "Okada" Floating Booking Bar */}
      <div className="w-full max-w-5xl mx-auto -mt-16 px-4 relative z-10">
        <div className="bg-white rounded-lg shadow-2xl p-6 md:p-8 border-t-4 border-[#F9A825]">
          
          <form onSubmit={handleBookingSubmit} className="flex flex-col md:flex-row items-end gap-6">
            
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

          {/* Optional Special Requests */}
          <div className="mt-8 pt-6 border-t border-gray-100">
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
      </div>

    </div>
  );
};

export default DiningReservationPage;
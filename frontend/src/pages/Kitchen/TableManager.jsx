import React, { useState, useEffect } from 'react';
import { Users, CheckCircle, XCircle, Clock } from 'lucide-react';
import toast from 'react-hot-toast';
import apiClient from '../../utils/apiClient';
import InternalNavBar from './components/InternalNavBar'; // Adjust path if needed
import './KitchenTheme.css';

// 1. Import Socket Hook
import { useSocket } from '../../context/SocketContext';

const pageTitleStyle = {
  fontSize: '1.875rem', 
  fontWeight: 'bold',
  marginBottom: '24px',
  textAlign: 'center',
  color: '#F9A825', 
};

const TableManager = () => {
  const [tables, setTables] = useState([]);
  const [loading, setLoading] = useState(true);
  
  // Modal States
  const [showSeatModal, setShowSeatModal] = useState(false);
  const [selectedTable, setSelectedTable] = useState(null);
  const [guestName, setGuestName] = useState('');

  // 2. Get Socket Instance
  const { socket } = useSocket();

  const fetchTables = async (isBackground = false) => {
    try {
      if (!isBackground) setLoading(true);
      const response = await apiClient('/tables');
      if (response.ok) {
        setTables(await response.json());
      }
    } catch (error) {
      toast.error("Failed to load tables");
    } finally {
      if (!isBackground) setLoading(false);
    }
  };

  useEffect(() => {
    fetchTables();
    
    // 3. Replaced Polling with Sockets
    if (socket) {
        // Listen for specific table updates
        socket.on('table-update', (data) => {
            console.log("📡 Table update received:", data);
            setTables(prevTables => prevTables.map(table => {
                if (table.table_id === parseInt(data.table_id)) {
                    return { ...table, status: data.status };
                }
                return table;
            }));
        });

        // Backup: Listen for new orders
        socket.on('new-order', () => {
             fetchTables(true);
        });
    }

    return () => {
        if(socket) {
            socket.off('table-update');
            socket.off('new-order');
        }
    };
  }, [socket]);

  // Handle clicking a table card
  const handleTableClick = async (table) => {
      if (table.status === 'Available') {
          // If available, trigger the Seat Guest workflow
          setSelectedTable(table);
          setGuestName(''); // Clear old input
          setShowSeatModal(true);
      } else {
          // MANUAL OVERRIDE: If occupied, allow Hostess to force clear it
          // (Normally, the Cashier settling the bill does this automatically)
          if (!window.confirm(`Table ${table.table_number} is Occupied. Manually force it to Available?`)) return;

          try {
              const res = await apiClient(`/tables/${table.table_id}/status`, {
                  method: 'PUT',
                  body: JSON.stringify({ status: 'Available' })
              });
              if (!res.ok) throw new Error("Failed to update");
              
              toast.success(`Table ${table.table_number} manually cleared`);
              setTables(prev => prev.map(t => 
                  t.table_id === table.table_id ? { ...t, status: 'Available' } : t
              ));
          } catch (error) {
              toast.error(error.message);
          }
      }
  };

  // The new API call to seat the guest and open the Tab
  const handleSeatGuest = async () => {
      try {
          const res = await apiClient(`/tables/${selectedTable.table_id}/seat`, {
              method: 'POST',
              body: JSON.stringify({ guest_name: guestName.trim() })
          });
          
          if (!res.ok) {
              const err = await res.json();
              throw new Error(err.message || "Failed to seat guest");
          }
          
          toast.success(`Guest seated at Table ${selectedTable.table_number}! Tab opened.`);
          setShowSeatModal(false);
          
          // Optimistic local update (Socket will also catch this)
          setTables(prev => prev.map(t => 
              t.table_id === selectedTable.table_id ? { ...t, status: 'Occupied' } : t
          ));
      } catch (error) {
          toast.error(error.message);
      }
  };

  return (
    <>
        <div className="flex flex-col min-h-screen" style={{ backgroundColor: '#523a2eff' }}>
        <InternalNavBar />
        
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8 w-full">
            <h1 style={pageTitleStyle}>Manage Table Availability</h1>

            {loading ? <p className="text-white text-center mt-10">Loading...</p> : (
                <div className="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-5 gap-6">
                    {tables.map((table) => (
                        <div 
                            key={table.table_id}
                            onClick={() => handleTableClick(table)}
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

        {/* 🪑 SEAT GUEST MODAL */}
        {showSeatModal && (
            <div 
                className="fixed inset-0 flex items-center justify-center z-50 animate-fadeIn" 
                style={{ backgroundColor: 'rgba(0, 0, 0, 0.6)' }} 
            >
                <div className="bg-white rounded-lg p-6 w-full max-w-sm shadow-2xl relative border-t-4 border-amber-500">
                    
                    <button 
                        onClick={() => setShowSeatModal(false)}
                        className="absolute top-3 right-3 text-gray-400 hover:text-gray-600 font-bold"
                    >
                        ✕
                    </button>
                    
                    <div className="flex flex-col items-center text-center mb-6">
                        <div className="bg-amber-100 p-4 rounded-full mb-3 text-3xl">
                            🍽️
                        </div>
                        <h3 className="text-xl font-bold text-gray-800">Seat Guest at Table #{selectedTable?.table_number}</h3>
                        <p className="text-sm text-gray-500 mt-2">
                            This will mark the table as occupied and open a new order tab for the Waiter and Cashier.
                        </p>
                    </div>

                    <div className="mb-6">
                        <label className="block text-sm font-bold text-gray-700 mb-2 text-left">
                            Guest Name (Optional)
                        </label>
                        <input 
                            type="text" 
                            value={guestName}
                            onChange={(e) => setGuestName(e.target.value)}
                            placeholder="e.g. Chavez Family"
                            className="w-full p-3 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-amber-500"
                            autoFocus
                        />
                    </div>
                    
                    <div className="flex gap-3">
                        <button 
                            onClick={() => setShowSeatModal(false)}
                            className="flex-1 py-3 rounded-lg font-bold border border-gray-300 text-gray-700 hover:bg-gray-100 transition-colors"
                        >
                            Cancel
                        </button>
                        <button 
                            onClick={handleSeatGuest}
                            className="flex-1 py-3 rounded-lg font-bold bg-amber-600 text-white hover:bg-amber-700 shadow-md transition-colors"
                        >
                            Seat & Open Tab
                        </button>
                    </div>
                </div>
            </div>
        )}
    </>
  );
};

export default TableManager;
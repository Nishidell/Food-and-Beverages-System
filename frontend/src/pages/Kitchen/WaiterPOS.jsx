import React, { useState, useEffect } from 'react';
import InternalNavBar from './components/InternalNavBar'; // Adjust path
import apiClient from '../../utils/apiClient';
import toast from 'react-hot-toast';

function WaiterPOS() {
    // State for the Left Panel (The Menu)
    const [menuItems, setMenuItems] = useState([]);
    const [categories, setCategories] = useState(['All']);
    const [selectedCategory, setSelectedCategory] = useState('All');

    // State for the Right Panel (The Cart)
    const [activeTabs, setActiveTabs] = useState([]);
    const [selectedTabId, setSelectedTabId] = useState('');
    const [cart, setCart] = useState([]);

    useEffect(() => {
        // Fetch Menu Items (Adjust the endpoint if needed!)
        const fetchMenu = async () => {
            try {
                const response = await apiClient('/menu'); // Change if your endpoint is different
                if (response.ok) {
                    const data = await response.json();
                    setMenuItems(data);
                    
                    // Extract unique categories for the filter tabs
                    const uniqueCategories = ['All', ...new Set(data.map(item => item.category || 'Uncategorized'))];
                    setCategories(uniqueCategories);
                }
            } catch (error) {
                console.error("Error loading menu", error);
            }
        };

        // Fetch the open tables (We reuse the Cashier's unpaid endpoint!)
        const fetchTabs = async () => {
            try {
                const response = await apiClient('/orders/unpaid');
                if (response.ok) {
                    const data = await response.json();
                    // We only want Dine-In tables for the Waiter
                    const dineInTabs = data.filter(tab => tab.table_number !== null);
                    setActiveTabs(dineInTabs);
                }
            } catch (error) {
                console.error("Error loading tabs", error);
            }
        };

        fetchMenu();
        fetchTabs();
    }, []);

    // ... (We will add the addToCart, removeFromCart, and sendToKitchen functions next)

    return (
        <div className="bg-amber-50 min-h-screen">
            <InternalNavBar />
            
            <div className="max-w-7xl mx-auto p-4 flex gap-6 mt-4" style={{ height: 'calc(100vh - 100px)' }}>
                
                {/* LEFT PANEL: The Menu Selection */}
                <div className="w-2/3 bg-white rounded-lg shadow-md border border-amber-200 flex flex-col overflow-hidden">
                    <div className="p-4 bg-amber-800 text-white font-bold text-lg flex gap-2 overflow-x-auto">
                        {/* Category Filter Buttons */}
                        {categories.map(cat => (
                            <button 
                                key={cat}
                                onClick={() => setSelectedCategory(cat)}
                                className={`px-4 py-1 rounded-full text-sm font-medium whitespace-nowrap transition-colors ${selectedCategory === cat ? 'bg-white text-amber-900' : 'bg-amber-700 hover:bg-amber-600 text-white'}`}
                            >
                                {cat}
                            </button>
                        ))}
                    </div>

                    <div className="flex-1 overflow-y-auto p-4 grid grid-cols-3 gap-4 auto-rows-max">
                        {/* The Food Buttons */}
                        {menuItems
                            .filter(item => selectedCategory === 'All' || item.category === selectedCategory)
                            .map(item => (
                                <div 
                                    key={item.id} // Adjust to your actual ID field name
                                    onClick={() => console.log("Added to cart:", item.name)}
                                    className="border-2 border-gray-200 rounded-lg p-3 cursor-pointer hover:border-amber-500 hover:bg-amber-50 transition-all flex flex-col justify-between h-32 active:scale-95"
                                >
                                    <span className="font-bold text-gray-800 line-clamp-2">{item.name}</span>
                                    <span className="text-amber-700 font-bold mt-2">₱{parseFloat(item.price).toFixed(2)}</span>
                                </div>
                            ))
                        }
                    </div>
                </div>

                {/* RIGHT PANEL: The Active Ticket (Cart) */}
                <div className="w-1/3 bg-white rounded-lg shadow-md border border-amber-200 flex flex-col overflow-hidden">
                    <div className="p-4 bg-gray-100 border-b border-gray-200">
                        <label className="block text-xs font-bold text-gray-600 uppercase mb-1">Select Open Table</label>
                        <select 
                            value={selectedTabId}
                            onChange={(e) => setSelectedTabId(e.target.value)}
                            className="w-full p-2 border border-gray-300 rounded font-bold text-gray-800 focus:outline-none focus:ring-2 focus:ring-amber-500"
                        >
                            <option value="" disabled>-- Choose a Table --</option>
                            {activeTabs.map(tab => (
                                <option key={tab.order_id} value={tab.order_id}>
                                    Table {tab.table_number} ({tab.first_name})
                                </option>
                            ))}
                        </select>
                    </div>

                    <div className="flex-1 overflow-y-auto p-4 bg-gray-50 flex flex-col gap-2">
                        {cart.length === 0 ? (
                            <p className="text-center text-gray-400 mt-10 italic">Cart is empty.<br/>Tap items on the left to add.</p>
                        ) : (
                            cart.map((cartItem, idx) => (
                                <div key={idx} className="bg-white p-3 rounded border border-gray-200 shadow-sm flex justify-between items-center">
                                    {/* Cart item details will go here */}
                                    <span>{cartItem.name}</span>
                                    <span>x{cartItem.quantity}</span>
                                </div>
                            ))
                        )}
                    </div>

                    <div className="p-4 border-t border-gray-200 bg-white">
                        <button 
                            disabled={!selectedTabId || cart.length === 0}
                            onClick={() => console.log("Sending to Kitchen...")}
                            className={`w-full py-4 rounded font-bold text-xl transition-all shadow-md ${(!selectedTabId || cart.length === 0) ? 'bg-gray-300 text-gray-500 cursor-not-allowed shadow-none' : 'bg-amber-600 hover:bg-amber-700 text-white transform hover:-translate-y-1'}`}
                        >
                            Send to Kitchen
                        </button>
                    </div>
                </div>

            </div>
        </div>
    );
}

export default WaiterPOS;
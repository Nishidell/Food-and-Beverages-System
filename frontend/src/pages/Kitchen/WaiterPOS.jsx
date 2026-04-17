import React, { useState, useEffect } from 'react';
import InternalNavBar from './components/InternalNavBar'; 
import apiClient from '../../utils/apiClient';
import toast from 'react-hot-toast';
import { Trash2 } from 'lucide-react';
import CategoryTabs from '../Customer/components/CategoryTabs';
import FoodGrid from '../Customer/components/FoodGrid';

function WaiterPOS() {
    // Menu State
    const [menuItems, setMenuItems] = useState([]);
    const [categories, setCategories] = useState([]);
    const [selectedCategory, setSelectedCategory] = useState(0); // 0 = All Items
    
    // Cart & Table State
    const [activeTabs, setActiveTabs] = useState([]);
    const [selectedTabId, setSelectedTabId] = useState('');
    const [cart, setCart] = useState([]);

    useEffect(() => {

        const fetchMenu = async () => {
            try {
                // ⚠️ Double check: is your backend route actually '/menu'? 
                // If it's something else like '/items', change it here!
                const response = await apiClient('/items'); 
                if (response.ok) {
                    const data = await response.json();
                    console.log("🥩 Menu Data from Database:", data); 
                    setMenuItems(data);
                } else {
                    console.error("Failed to fetch menu. Check endpoint name.");
                }
            } catch (error) { console.error(error); }
        };

        // Fetch Categories
        const fetchCategories = async () => {
            try {
                const response = await apiClient('/categories'); 
                if (response.ok) {
                    setCategories(await response.json());
                }
            } catch (error) { console.error(error); }
        };

        const fetchTabs = async () => {
            try {
                const response = await apiClient('/orders/unpaid');
                if (response.ok) {
                    const data = await response.json();
                    setActiveTabs(data.filter(tab => tab.table_number !== null));
                }
            } catch (error) { console.error(error); }
        };

        fetchMenu();
        fetchCategories();
        fetchTabs();
    }, []);

    // The function that FoodGrid will call when a Waiter taps a food item
    const handleAddToCart = (item) => {
        setCart(prevCart => {
            const existing = prevCart.find(cartItem => cartItem.item_id === item.item_id);
            if (existing) {
                return prevCart.map(cartItem => 
                    cartItem.item_id === item.item_id 
                        ? { ...cartItem, quantity: cartItem.quantity + 1, subtotal: (cartItem.quantity + 1) * cartItem.price }
                        : cartItem
                );
            }
            return [...prevCart, { ...item, quantity: 1, subtotal: item.price }];
        });
    };

    const handleRemoveFromCart = (itemIdToRemove) => {
    setCart(prevCart => prevCart.filter(item => item.item_id !== itemIdToRemove));
};

    const handleSendToKitchen = async () => {
    try {
        // 1. Package the cart data for the backend
        const orderPayload = {
            items: cart.map(item => ({
                item_id: item.item_id,
                quantity: item.quantity,
                price: item.price
            }))
        };

        // 2. Send the request to your backend
        // ⚠️ IMPORTANT: Check your backend router! 
        // You might need to change `/orders/${selectedTabId}/items` to match your actual API route.
        const response = await apiClient(`/orders/${selectedTabId}/items`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(orderPayload)
        });

        if (response.ok) {
            toast.success("Order sent to kitchen!");
            setCart([]); // Clear the cart after sending
            setSelectedTabId(''); // Optional: unselect the table
        } else {
            toast.error("Failed to send order to kitchen.");
            console.error("Backend error:", await response.text());
        }
    } catch (error) {
        console.error("Network error:", error);
        toast.error("Network error occurred.");
    }
};

    // Filter items based on selected category tab
    const displayedItems = selectedCategory === 0 
        ? menuItems 
        : selectedCategory === 'bestseller'
            ? [...menuItems].sort((a, b) => (b.total_sold || 0) - (a.total_sold || 0)).slice(0, 10)
            : menuItems.filter(item => Number(item.category_id) === Number(selectedCategory));

    return (
        <div className="bg-amber-50 min-h-screen">
            <InternalNavBar />
            
            <div className="max-w-[1400px] mx-auto p-4 flex flex-col md:flex-row gap-6 mt-4 h-auto md:h-[calc(100vh-100px)]">
                
                {/* LEFT PANEL: Reusing your Customer UI! */}
               <div className="w-full md:w-7/12 bg-white rounded-lg shadow-md border border-amber-200 flex flex-col overflow-hidden h-[60vh] md:h-full">
                    
                    {/* Your exact Category Tabs component */}
                    <div className="pt-4 px-4 bg-white border-b border-gray-200">
                        <CategoryTabs 
                            categories={categories}
                            selectedCategory={selectedCategory}
                            onSelectCategory={setSelectedCategory}
                            theme="kitchen"
                        />
                    </div>

                    {/* Your exact Food Grid component */}
                    <div className="flex-1 overflow-y-auto p-4 bg-gray-50">
                        <FoodGrid 
                            items={displayedItems}
                            onAddToCart={handleAddToCart}
                            theme="kitchen"
                            isPOS={true} 
                        />
                    </div>
                </div>

                {/* RIGHT PANEL: The Active Ticket (Cart) */}
              <div className="w-full md:w-5/12 bg-white rounded-lg shadow-md border border-amber-200 flex flex-col overflow-hidden h-[50vh] md:h-full">
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
                                <div key={idx} className="bg-white p-3 rounded border border-gray-200 shadow-sm flex flex-col xl:flex-row justify-between xl:items-center gap-2">
                                    <div>
                                        <p className="font-bold text-gray-800">{cartItem.item_name}</p>
                                        <p className="text-sm text-amber-700">₱{parseFloat(cartItem.price).toFixed(2)} x {cartItem.quantity}</p>
                                    </div>
                                   
                        <div className="flex items-center gap-3">
                                <span className="font-bold text-lg">₱{parseFloat(cartItem.subtotal).toFixed(2)}</span>
                                <button 
                                    onClick={() => handleRemoveFromCart(cartItem.item_id)}
                                    className="text-red-400 hover:text-red-600 hover:bg-red-50 p-1.5 rounded transition-colors"
                                    title="Remove from cart"
                                >
                                    <Trash2 size={18} />
                                </button>
                          </div>
                                   
                    </div>
                            ))
                        )}
                  </div>

                    {/* Cart Totals & Submit */}
                    <div className="p-4 border-t border-gray-200 bg-white">
                        <div className="flex justify-between mb-4 font-bold text-xl">
                            <span>Total:</span>
                            <span>₱{cart.reduce((sum, item) => sum + parseFloat(item.subtotal), 0).toFixed(2)}</span>
                        </div>
                        <button 
                            disabled={!selectedTabId || cart.length === 0}
                            onClick={handleSendToKitchen}
                            className={`w-full py-4 rounded font-bold text-xl transition-all shadow-md ${(!selectedTabId || cart.length === 0) ? 'bg-gray-300 text-gray-500 cursor-not-allowed shadow-none' : 'bg-amber-600 hover:bg-amber-700 text-white transform hover:-translate-y-1'}`}
                        >
                            Send Order to Kitchen
                        </button>
                    </div>
                </div>

            </div>
        </div>
    );
}

export default WaiterPOS;
import React, { useState, useEffect } from 'react';
import InternalNavBar from './components/InternalNavBar'; // Adjust path if needed
import apiClient from '../../utils/apiClient'; // Adjust path if needed
import toast from 'react-hot-toast';

function CashierDashboard() {
    const [unpaidTabs, setUnpaidTabs] = useState([]);
    const [selectedTab, setSelectedTab] = useState(null);
    const [loading, setLoading] = useState(true);

    const [orderDetails, setOrderDetails] = useState(null);
    const [paymentMethod, setPaymentMethod] = useState('');

    const handleTabClick = async (tab) => {
        setSelectedTab(tab);
        setOrderDetails(null); // Clear the old receipt
        setPaymentMethod('');  // Reset the payment buttons
        
        try {
            console.log(`Fetching receipt for Order #${tab.order_id}...`);
            
            // ⚠️ CRITICAL CHECK: Make sure these are BACKTICKS ( ` ), not single quotes ( ' )!
            const response = await apiClient(`/orders/${tab.order_id}`);
            
            if (response.ok) {
                const data = await response.json();
                console.log("Success! Receipt data:", data);
                setOrderDetails(data);
            } else {
                const errorData = await response.json();
                console.error("Backend rejected the request:", errorData);
                toast.error(`Error: ${errorData.message || 'Failed to load receipt'}`);
            }
        } catch (error) {
            console.error("Network or Code Error:", error);
            toast.error("Failed to connect to server");
        }
    };

    // Fetch the unpaid tabs when the page loads
    useEffect(() => {
        const fetchUnpaidTabs = async () => {
            try {
                const response = await apiClient('/orders/unpaid');
                if (!response.ok) throw new Error('Failed to fetch tabs');
                
                const data = await response.json();
                setUnpaidTabs(data);
            } catch (error) {
                console.error("Error:", error);
                toast.error("Failed to load active tabs");
            } finally {
                setLoading(false);
            }
        };

        fetchUnpaidTabs();
    }, []);

    return (
        <div className="bg-amber-50 min-h-screen">
            <InternalNavBar />
            
            <div className="max-w-7xl mx-auto p-4 flex gap-6 mt-4" style={{ height: 'calc(100vh - 100px)' }}>
                
                {/* LEFT PANEL: The Active Tabs List */}
                <div className="w-1/3 bg-white rounded-lg shadow-md flex flex-col overflow-hidden border border-amber-200">
                    <div className="p-4 bg-amber-800 text-white font-bold text-lg">
                        Active Unpaid Tabs ({unpaidTabs.length})
                    </div>
                    
                    <div className="flex-1 overflow-y-auto p-2">
                        {loading ? (
                            <p className="text-center text-gray-500 mt-10">Loading tabs...</p>
                        ) : unpaidTabs.length === 0 ? (
                            <p className="text-center text-gray-500 mt-10">No active tabs waiting for payment.</p>
                        ) : (
                            unpaidTabs.map(tab => (
                                <div 
                                    key={tab.order_id}
                                    onClick={() => handleTabClick(tab)} // ✅ CHANGED
                                    className={`p-4 mb-2 rounded border cursor-pointer...`}
                                >
                                    <div className="flex justify-between items-center mb-1">
                                        <span className="font-bold text-lg text-gray-800">Order #{tab.order_id}</span>
                                        <span className="text-xs bg-amber-200 text-amber-800 px-2 py-1 rounded-full font-bold">
                                            {tab.formatted_location}
                                        </span>
                                    </div>
                                    <p className="text-gray-600 font-medium">{tab.first_name} {tab.last_name}</p>
                                    <p className="text-amber-700 font-bold mt-2">₱{parseFloat(tab.total_amount).toFixed(2)}</p>
                                </div>
                            ))
                        )}
                    </div>
                </div>

                {/* RIGHT PANEL: The Receipt & Settlement Area */}
                <div className="w-2/3 bg-white rounded-lg shadow-md border border-amber-200 p-6 flex flex-col">
                    {!selectedTab ? (
                        <div className="flex-1 flex flex-col items-center justify-center text-gray-400">
                            <span className="text-6xl mb-4">🧾</span>
                            <h2 className="text-2xl font-bold text-gray-500">Select a Tab to Process Payment</h2>
                            <p>Click on an active order from the list on the left.</p>
                        </div>
                    ) : (
                        <div className="flex-1 flex flex-col">
                            <h2 className="text-2xl font-bold border-b pb-2 mb-4">Settle Bill: {selectedTab.formatted_location}</h2>
                            <p><strong>Guest:</strong> {selectedTab.first_name} {selectedTab.last_name}</p>
                            <p><strong>Order ID:</strong> #{selectedTab.order_id}</p>
                            
                            {/* The Itemized Receipt */}
                            {!orderDetails ? (
                                <p className="text-center mt-10 text-gray-500 animate-pulse">Loading receipt details...</p>
                            ) : (
                                <div className="flex-1 flex flex-col h-full">
                                    <div className="bg-gray-50 border border-gray-200 p-4 rounded mb-4 flex-1 overflow-y-auto">
                                        <table className="w-full text-left text-sm">
                                            <thead>
                                                <tr className="border-b text-gray-500">
                                                    <th className="pb-2 w-16">Qty</th>
                                                    <th className="pb-2">Item</th>
                                                    <th className="pb-2 text-right">Price</th>
                                                    <th className="pb-2 text-right">Total</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                {orderDetails.items?.map((item, idx) => (
                                                    <tr key={idx} className="border-b border-dashed last:border-0 text-gray-800 font-medium">
                                                        <td className="py-3">{item.quantity}</td>
                                                        <td className="py-3">{item.item_name}</td>
                                                        <td className="py-3 text-right text-gray-500">₱{parseFloat(item.price).toFixed(2)}</td>
                                                        <td className="py-3 text-right">₱{parseFloat(item.subtotal).toFixed(2)}</td>
                                                    </tr>
                                                ))}
                                            </tbody>
                                        </table>
                                    </div>

                                    {/* The Financial Totals */}
                                    <div className="flex flex-col items-end mb-6 space-y-1">
                                        <p className="text-gray-500 text-sm">Subtotal: ₱{parseFloat(selectedTab.items_total).toFixed(2)}</p>
                                        <p className="text-gray-500 text-sm">Service Charge (10%): ₱{parseFloat(selectedTab.service_charge_amount).toFixed(2)}</p>
                                        <p className="text-gray-500 text-sm">VAT (12%): ₱{parseFloat(selectedTab.vat_amount).toFixed(2)}</p>
                                        <p className="text-3xl font-bold text-gray-900 mt-2 border-t pt-2 border-gray-300">
                                            Total: ₱{parseFloat(selectedTab.total_amount).toFixed(2)}
                                        </p>
                                    </div>

                                    {/* Payment Method Selection */}
                                    <div className="mb-6">
                                        <h3 className="font-bold mb-3 text-gray-800 uppercase text-xs tracking-wider">Select Payment Method:</h3>
                                        <div className="flex gap-3">
                                            {['Room Charge', 'Credit Card', 'Cash'].map(method => (
                                                <button
                                                    key={method}
                                                    onClick={() => setPaymentMethod(method)}
                                                    className={`flex-1 py-3 rounded font-bold border-2 transition-all ${paymentMethod === method ? 'border-amber-600 bg-amber-50 text-amber-800 scale-[1.02]' : 'border-gray-200 text-gray-500 hover:border-amber-300 hover:bg-amber-50/50'}`}
                                                >
                                                    {method}
                                                </button>
                                            ))}
                                        </div>
                                    </div>

                                    {/* The Final Action Button */}
                                    <button
                                        disabled={!paymentMethod}
                                        onClick={() => console.log("Ready to settle bill!")}
                                        className={`w-full py-4 rounded font-bold text-xl transition-all ${paymentMethod ? 'bg-green-600 hover:bg-green-700 text-white shadow-lg transform hover:-translate-y-1' : 'bg-gray-300 text-gray-500 cursor-not-allowed'}`}
                                    >
                                        Settle Bill & Close Tab
                                    </button>
                                </div>
                            )}
                        </div>
                    )}
                </div>

            </div>
        </div>
    );
}

export default CashierDashboard;
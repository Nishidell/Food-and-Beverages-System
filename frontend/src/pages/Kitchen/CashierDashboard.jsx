import React, { useState, useEffect } from 'react';
import InternalNavBar from './components/InternalNavBar';
import apiClient from '../../utils/apiClient'; 
import PrintableReceipt from './components/PrintableReceipt'; 
import toast from 'react-hot-toast';

function CashierDashboard() {
    const [unpaidTabs, setUnpaidTabs] = useState([]);
    const [selectedTab, setSelectedTab] = useState(null);
    const [loading, setLoading] = useState(true);
    const [orderDetails, setOrderDetails] = useState(null);
    const [paymentMethod, setPaymentMethod] = useState('');
    const [showSettleModal, setShowSettleModal] = useState(false);
    const [amountTendered, setAmountTendered] = useState('');

    //Discount and change calculation states
    const [discountType, setDiscountType] = useState('None'); // 'None', 'Senior/PWD', 'Medal of Valor'
    const [paxCount, setPaxCount] = useState(1); // How many people are sharing the meal
    const [discountId, setDiscountId] = useState(''); // To store the ID number

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

    // Handle clicking a tab on the left
    const handleTabClick = async (tab) => {
        setSelectedTab(tab);
        setOrderDetails(null); // Clear old receipt
        setPaymentMethod('');  // Reset payment buttons
        
        try {
            const response = await apiClient(`/orders/${tab.order_id}`);
            if (response.ok) {
                const data = await response.json();
                setOrderDetails(data);
            } else {
                const errorData = await response.json();
                toast.error(`Error: ${errorData.message || 'Failed to load receipt'}`);
            }
        } catch (error) {
            console.error("Network Error:", error);
            toast.error("Failed to connect to server");
        }
    };

    // Handle instant printing
    const handlePrintBill = () => {
        window.print();
        toast.success(`Guest summary for ${selectedTab?.formatted_location} printed!`);
    };


    //Dynamic math calculation
    let displaySubtotal = orderDetails ? parseFloat(orderDetails.items_total) : (selectedTab ? parseFloat(selectedTab.total_amount) : 0);
    let displayServiceCharge = orderDetails ? parseFloat(orderDetails.service_charge_amount) : 0;
    let displayVat = orderDetails ? parseFloat(orderDetails.vat_amount) : 0;
    let displayTotal = orderDetails ? parseFloat(orderDetails.total_price) : (selectedTab ? parseFloat(selectedTab.total_amount) : 0);
    let discountAmount = 0;

    if (orderDetails && discountType !== 'None') {
        const originalBaseFood = parseFloat(orderDetails.items_total);
        const pax = Math.max(1, parseInt(paxCount) || 1); // Protect against dividing by 0

        // 1. Prorate the meal (Separate the Senior's share from the rest)
        const seniorShareBase = originalBaseFood / pax;
        const nonDiscountedBase = originalBaseFood - seniorShareBase;

        // 2. Apply the 20% discount directly to the base share
        const discountedSeniorShareBase = seniorShareBase * 0.80;
        discountAmount = seniorShareBase * 0.20; // This is just for the receipt display

        const newFoodBase = nonDiscountedBase + discountedSeniorShareBase;

        // 3. Service charge remains based on the ORIGINAL food amount (Legal Rule)
        displayServiceCharge = originalBaseFood * 0.10; 

        // 4. VAT is only applied to the non-discounted food + the service charge
        displayVat = (nonDiscountedBase + displayServiceCharge) * 0.12;

        // 5. Final Total
        displayTotal = newFoodBase + displayServiceCharge + displayVat;
    }

   // Handle taking the money and closing the tab
    const handleSettleBill = async () => {
        // Fallback to whichever total is currently rendering correctly
       const billTotal = displayTotal; // Uses our new dynamic math!
        let changeToGive = 0;

        // Validation for Cash payments
        if (paymentMethod === 'Cash') {
            const tendered = parseFloat(amountTendered);
            if (isNaN(tendered) || tendered < billTotal) {
                toast.error("Invalid amount! Customer has not given enough cash.");
                return; // Stop the function from submitting
            }
            changeToGive = tendered - billTotal;
        }

        try {
            const response = await apiClient(`/orders/${selectedTab.order_id}/settle`, {
                method: 'POST',
                body: JSON.stringify({
                    payment_method: paymentMethod,
                    amount: billTotal,
                    change_amount: changeToGive,
                    discount_type: discountType,
                    discount_id: discountType !== 'None' ? discountId : null,
                    discount_amount: discountType !== 'None' ? discountAmount : 0
                })
            });

            if (response.ok) {
                toast.success(`Bill for Order #${selectedTab.order_id} settled!`);
                setShowSettleModal(false); 
                
                // Clean up the UI
                setUnpaidTabs(prev => prev.filter(tab => tab.order_id !== selectedTab.order_id));
                setSelectedTab(null);
                setOrderDetails(null);
                setPaymentMethod('');
                setAmountTendered('');
                setDiscountType('None');
                setPaxCount(1);
                setDiscountId('');
            } else {
                const errorData = await response.json();
                toast.error(`Error: ${errorData.message}`);
            }
        } catch (error) {
            console.error(error);
            toast.error("Network error while settling bill.");
        }
    };

    return (
        <>
            {/* 🖨️ THE INVISIBLE RECEIPT (Only shows up on the print screen) */}
            <PrintableReceipt 
            tab={selectedTab} 
            details={orderDetails} 
            discountType={discountType}
            paxCount={paxCount}
            discountAmount={discountAmount}
            displaySubtotal={displaySubtotal}
            displayServiceCharge={displayServiceCharge}
            displayVat={displayVat}
            displayTotal={displayTotal}
             />

            {/* 💻 THE MAIN DASHBOARD (Hidden during printing) */}
            <div className="bg-amber-50 min-h-screen">
                <InternalNavBar />
                
                <div className="max-w-7xl mx-auto p-4 flex gap-6 mt-4" style={{ height: 'calc(100vh - 100px)' }}>
                    
                    {/* ================= LEFT PANEL ================= */}
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
                                        onClick={() => handleTabClick(tab)}
                                        className={`p-4 mb-2 rounded border cursor-pointer transition-colors ${selectedTab?.order_id === tab.order_id ? 'bg-amber-100 border-amber-400 border-l-4' : 'bg-gray-50 border-gray-200 hover:bg-amber-50'}`}
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

                    {/* ================= RIGHT PANEL ================= */}
                    <div className="w-2/3 bg-white rounded-lg shadow-md border border-amber-200 p-6 flex flex-col">
                        
                        {!selectedTab ? (
                            // State 1: No tab selected
                            <div className="flex-1 flex flex-col items-center justify-center text-gray-400">
                                <span className="text-6xl mb-4">🧾</span>
                                <h2 className="text-2xl font-bold text-gray-500">Select a Tab to Process Payment</h2>
                                <p>Click on an active order from the list on the left.</p>
                            </div>
                        ) : (
                            // State 2: Tab is selected
                            <div className="flex-1 flex flex-col h-full">
                                <h2 className="text-2xl font-bold border-b pb-2 mb-4">Settle Bill: {selectedTab.formatted_location}</h2>
                                <p><strong>Guest:</strong> {selectedTab.first_name} {selectedTab.last_name}</p>
                                <p><strong>Order ID:</strong> #{selectedTab.order_id}</p>
                                
                                {!orderDetails ? (
                                    // State 2A: Waiting for API to return receipt data
                                    <p className="text-center mt-10 text-gray-500 animate-pulse">Loading receipt details...</p>
                                ) : (
                                    // State 2B: Receipt loaded, show tables and buttons
                                    <>
                                           <div className="bg-gray-50 border border-gray-200 p-4 rounded mt-4 mb-4 flex-1 overflow-y-auto min-h-[200px]">
                                                {/* ================= 1. THE ITEMS TABLE ================= */}
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
                                                        {orderDetails.items && orderDetails.items.length > 0 ? (
                                                            orderDetails.items.map((item, idx) => (
                                                                <tr key={idx} className="border-b border-dashed last:border-0 text-gray-800 font-medium">
                                                                    <td className="py-3">{item.quantity}</td>
                                                                    <td className="py-3">{item.item_name}</td>
                                                                    <td className="py-3 text-right text-gray-500">₱{parseFloat(item.price || 0).toFixed(2)}</td>
                                                                    <td className="py-3 text-right">₱{parseFloat(item.subtotal || 0).toFixed(2)}</td>
                                                                </tr>
                                                            ))
                                                        ) : (
                                                            <tr>
                                                                <td colSpan="4" className="py-4 text-center text-red-500 font-bold bg-red-50 rounded">
                                                                    No active items found! (The database returned 0 items for Order #{selectedTab?.order_id})
                                                                </td>
                                                            </tr>
                                                        )}
                                                    </tbody>
                                                </table>

                                                {/* ================= 2. NEW DYNAMIC TOTALS ================= */}
                                                <div className="flex flex-col items-end mb-6 space-y-1 w-full border-t border-gray-200 pt-4 mt-4">
                                                    <p className="text-gray-500 text-sm">Base Subtotal: ₱{displaySubtotal.toFixed(2)}</p>
                                                    
                                                    {/* Show the discount line if active */}
                                                    {discountType !== 'None' && (
                                                        <p className="text-red-600 text-sm font-bold bg-red-50 px-2 py-1 rounded">
                                                            Discount (20% off 1/{paxCount} share): -₱{discountAmount.toFixed(2)}
                                                        </p>
                                                    )}
                                                    
                                                    <p className="text-gray-500 text-sm">Service Charge (10%): ₱{displayServiceCharge.toFixed(2)}</p>
                                                    <p className="text-gray-500 text-sm">VAT (12%): ₱{displayVat.toFixed(2)}</p>
                                                    
                                                    <h3 className="text-3xl font-bold text-gray-900 mt-2 border-t pt-2 border-gray-300 mb-6">
                                                        Total: ₱{displayTotal.toFixed(2)}
                                                    </h3>
                                                </div>

                                                {/* ================= 3. SPECIAL DISCOUNT SECTION ================= */}
                                                <div className="mb-2 bg-blue-50 p-3 rounded border border-blue-200 w-full text-left">
                                                    <label className="text-xs text-blue-800 uppercase tracking-wider font-bold block mb-2">Apply Special Discount</label>
                                                    
                                                    <div className="grid grid-cols-2 gap-2 mb-2">
                                                        <div>
                                                            <label className="text-xs text-gray-600 block mb-1">Customer Type</label>
                                                            <select 
                                                                value={discountType}
                                                                onChange={(e) => setDiscountType(e.target.value)}
                                                                className="w-full p-2 border border-gray-300 rounded text-sm outline-none focus:border-blue-500"
                                                            >
                                                                <option value="None">Regular (No Discount)</option>
                                                                <option value="Senior/PWD">Senior Citizen / PWD</option>
                                                                <option value="Medal of Valor">Medal of Valor</option>
                                                            </select>
                                                        </div>
                                                        
                                                        <div>
                                                            <label className="text-xs text-gray-600 block mb-1">Total Pax (People sharing)</label>
                                                            <input 
                                                                type="number"
                                                                min="1"
                                                                value={paxCount}
                                                                onChange={(e) => setPaxCount(Math.max(1, parseInt(e.target.value) || 1))}
                                                                disabled={discountType === 'None'}
                                                                className="w-full p-2 border border-gray-300 rounded text-sm outline-none disabled:bg-gray-100 disabled:text-gray-400"
                                                            />
                                                        </div>
                                                    </div>

                                                    {discountType !== 'None' && (
                                                        <div>
                                                            <label className="text-xs text-gray-600 block mb-1">ID Number (Required)</label>
                                                            <input 
                                                                type="text"
                                                                value={discountId}
                                                                onChange={(e) => setDiscountId(e.target.value)}
                                                                placeholder="Enter Senior/PWD/Valor ID..."
                                                                className="w-full p-2 border border-gray-300 rounded text-sm outline-none focus:border-blue-500"
                                                            />
                                                        </div>
                                                    )}
                                                </div>
                                            </div>
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

                                        <button
                                            onClick={handlePrintBill}
                                            className="w-full py-3 mb-3 rounded font-bold text-lg border-2 border-amber-600 text-amber-700 hover:bg-amber-50 transition-all flex items-center justify-center gap-2"
                                        >
                                            Print Bill for Guest
                                        </button>

                                        <button
                                            disabled={!paymentMethod}
                                            onClick={() => setShowSettleModal(true)}
                                            className={`w-full py-4 rounded font-bold text-xl transition-all ${paymentMethod ? 'bg-green-600 hover:bg-green-700 text-white shadow-lg transform hover:-translate-y-1' : 'bg-gray-300 text-gray-500 cursor-not-allowed'}`}
                                        >
                                            Settle Bill & Close Tab
                                        </button>
                                    </>
                                )}
                            </div>
                        )}
                    </div>
                </div>
            </div>

            {/* ================= MODALS (Rendered completely outside the layout!) ================= */}
            {showSettleModal && (
                <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 animate-fadeIn" style={{backgroundColor: 'rgba(0,0,0,0.6)'}}>
                    <div className="bg-white rounded-lg p-6 w-full max-w-sm shadow-2xl relative border-t-4 border-green-500">
                        <button 
                            onClick={() => setShowSettleModal(false)}
                            className="absolute top-3 right-3 text-gray-400 hover:text-gray-600 font-bold"
                        >✕</button>
                        
                        <div className="flex flex-col items-center text-center mb-6">
                            <div className="bg-green-100 p-4 rounded-full mb-3 text-3xl">💰</div>
                            <h3 className="text-xl font-bold text-gray-800">Settle Bill?</h3>
                            <p className="text-sm text-gray-500 mt-2">
                                You are about to close the tab for <span className="font-bold text-gray-800">{selectedTab?.formatted_location}</span>.
                            </p>
                            <div className="mt-3 bg-gray-50 p-2 rounded w-full border border-gray-200">
                                <p className="text-xs text-gray-500 uppercase tracking-wider">Payment Method</p>
                                <p className="font-bold text-amber-600">{paymentMethod}</p>
                            </div>
                            {/* Cash Change Calculator UI */}
                            {paymentMethod === 'Cash' && (
                                <div className="mt-3 w-full text-left">
                                    <label className="text-xs text-gray-500 uppercase tracking-wider block mb-1">Amount Tendered (₱)</label>
                                    <input
                                        type="number"
                                        value={amountTendered}
                                        onChange={(e) => setAmountTendered(e.target.value)}
                                        className="w-full p-2 border border-gray-300 rounded font-bold text-lg text-gray-800 outline-none focus:border-amber-500 focus:ring-1 focus:ring-amber-500"
                                        placeholder="Enter amount given..."
                                        autoFocus
                                    />
                                    
                                    {/* Only show change if they've typed enough money */}
                                   {amountTendered && parseFloat(amountTendered) >= displayTotal && (
                                        <div className="mt-3 bg-green-50 p-3 rounded border border-green-200 text-center animate-fadeIn">
                                            <p className="text-xs text-green-700 uppercase tracking-wider font-bold">Change Due to Guest</p>
                                            <p className="font-bold text-3xl text-green-600">
                                               ₱{(parseFloat(amountTendered) - displayTotal).toFixed(2)}
                                            </p>
                                        </div>
                                    )}
                                </div>
                            )}
                        </div>
                        
                        <div className="flex gap-3">
                            <button 
                                onClick={() => setShowSettleModal(false)}
                                className="flex-1 py-2 rounded-lg font-bold border border-gray-300 text-gray-700 hover:bg-gray-100 transition-colors"
                            >Cancel</button>
                            <button 
                                onClick={handleSettleBill}
                                className="flex-1 py-2 rounded-lg font-bold bg-green-600 text-white hover:bg-green-700 shadow-md transition-colors"
                            >Yes, Settle Tab</button>
                        </div>
                    </div>
                </div>
            )}
        </>
    );
}

export default CashierDashboard;
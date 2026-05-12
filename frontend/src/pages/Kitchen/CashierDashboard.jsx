import React, { useState, useEffect } from 'react';
import InternalNavBar from './components/InternalNavBar';
import apiClient from '../../utils/apiClient'; 
import PrintableReceipt from './components/PrintableReceipt'; 
import toast from 'react-hot-toast';
import { FaPrint, FaReceipt, FaMoneyBillWave } from 'react-icons/fa';
import { useSocket } from '../../context/SocketContext';

function CashierDashboard() {
    const [unpaidTabs, setUnpaidTabs] = useState([]);
    const [selectedTab, setSelectedTab] = useState(null);
    const [loading, setLoading] = useState(true);
    const [orderDetails, setOrderDetails] = useState(null);
    const [paymentMethod, setPaymentMethod] = useState('');
    const [showSettleModal, setShowSettleModal] = useState(false);

    const [amountTendered, setAmountTendered] = useState('');
    const [roomNumber, setRoomNumber] = useState('');

   // --- UPDATED DISCOUNT STATES (Option B: Array Approach) ---
    const [paxCount, setPaxCount] = useState(1); // Total people at the table
    const [appliedDiscounts, setAppliedDiscounts] = useState([]); // The Array of IDs
    
    // Temporary states for the input form before they click "Add"
    const [tempDiscountType, setTempDiscountType] = useState('Senior/PWD');
    const [tempDiscountId, setTempDiscountId] = useState('');

    const { socket } = useSocket();

    // Fetch the unpaid tabs when the page loads
   // ✅ Pull the fetch function OUTSIDE the useEffect so sockets can trigger it
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

    // ✅ Upgraded useEffect with Socket Listeners
    useEffect(() => {
        fetchUnpaidTabs(); // Run once on load

        if (socket) {
            socket.on('new-order', fetchUnpaidTabs);
            socket.on('order-status-updated', fetchUnpaidTabs);
        }

        return () => {
            if (socket) {
                socket.off('new-order', fetchUnpaidTabs);
                socket.off('order-status-updated', fetchUnpaidTabs);
            }
        };
    }, [socket]);
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

    // Add a discount to the list
    const handleAddDiscount = () => {
        if (!tempDiscountId.trim()) {
            toast.error("Please enter an ID number.");
            return;
        }
        if (appliedDiscounts.length >= paxCount) {
            toast.error("You cannot add more discounts than the total Pax count.");
            return;
        }
        
        setAppliedDiscounts(prev => [...prev, { 
            type: tempDiscountType, 
            id_number: tempDiscountId.trim() 
        }]);
        setTempDiscountId(''); // Clear the input box after adding
    };

    // Remove a discount from the list
    const handleRemoveDiscount = (indexToRemove) => {
        setAppliedDiscounts(prev => prev.filter((_, idx) => idx !== indexToRemove));
    };


    //Dynamic math calculation
    let displaySubtotal = orderDetails ? parseFloat(orderDetails.items_total) : (selectedTab ? parseFloat(selectedTab.total_amount) : 0);
    let displayServiceCharge = orderDetails ? parseFloat(orderDetails.service_charge_amount) : 0;
    let displayVat = orderDetails ? parseFloat(orderDetails.vat_amount) : 0;
    let displayTotal = orderDetails ? parseFloat(orderDetails.total_price) : (selectedTab ? parseFloat(selectedTab.total_amount) : 0);
    let discountAmount = 0;
    
    if (orderDetails && appliedDiscounts.length > 0) {
        const originalBaseFood = parseFloat(orderDetails.original_items_total || orderDetails.items_total);
        const pax = Math.max(1, parseInt(paxCount) || 1); 
        displaySubtotal = originalBaseFood; 

        const eligibleCount = appliedDiscounts.length; // How many IDs did we scan?
        
        // 1. Prorate the meal (Find the share for ONE person)
        const shareBase = originalBaseFood / pax;
        
        // 2. Separate the total eligible share from the non-eligible share
        const nonDiscountedBase = originalBaseFood - (shareBase * eligibleCount);
        const discountedShareBase = (shareBase * 0.80) * eligibleCount;
        
        // 3. Calculate total discount amount
        discountAmount = (shareBase * 0.20) * eligibleCount; 
        const newFoodBase = nonDiscountedBase + discountedShareBase;

        // 4. Tax/Service Math
        displayServiceCharge = originalBaseFood * 0.10;
        displayVat = (nonDiscountedBase + displayServiceCharge) * 0.12; // VAT is exempt on the discounted portion
        displayTotal = newFoodBase + displayServiceCharge + displayVat;
    }

   // Handle taking the money and closing the tab
    const handleSettleBill = async () => {
        console.log("DEBUG: Current selectedTab data:", selectedTab);
    const billTotal = displayTotal; 
    let changeToGive = 0;

    const roomIdToSend = selectedTab?.room_id || selectedTab?.room_num;

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
                appliedDiscounts: appliedDiscounts,
                room_id: selectedTab.room_id 
            })
        });

            if (response.ok)
                 {
                toast.success(`Bill for Order #${selectedTab.order_id} settled!`);
                setShowSettleModal(false); 
                
                // Clean up the UI
                setUnpaidTabs(prev => prev.filter(tab => tab.order_id !== selectedTab.order_id));
                setSelectedTab(null);
                setOrderDetails(null);
                setPaymentMethod('');
                setAmountTendered('');
                // Reset the new states:
                setPaxCount(1);
                setAppliedDiscounts([]);
                setTempDiscountId('');
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
            {/* THE INVISIBLE RECEIPT (Only shows up on the print screen) */}
            <PrintableReceipt 
            tab={selectedTab} 
            details={orderDetails} 
            appliedDiscounts={appliedDiscounts}
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
                                <FaReceipt className="text-6xl mb-4 text-gray-300" />
                                <h2 className="text-2xl font-bold text-gray-500">Select a Tab to Process Payment</h2>
                                <p>Click on an active order from the list on the left.</p>
                            </div>
                        ) : (
                            // State 2: Tab is selected
                            <div className="flex-1 flex flex-col h-full">
                                <div className="flex justify-between items-center border-b border-gray-200 pb-3 mb-4">
                                    <div className="flex items-center gap-4 text-sm md:text-base">
                                        <h2 className="text-xl font-bold text-gray-800">Settle: {selectedTab.formatted_location}</h2>
                                        <span className="text-gray-300">|</span>
                                        <p className="text-gray-600"><span className="font-bold text-gray-700">Guest:</span> {selectedTab.first_name} {selectedTab.last_name}</p>
                                        <span className="text-gray-300">|</span>
                                        <p className="text-gray-600"><span className="font-bold text-gray-700">Order ID:</span> #{selectedTab.order_id}</p>
                                    </div>
                                    
                                    <button
                                        onClick={handlePrintBill}
                                        className="flex items-center justify-center p-2 rounded bg-amber-100 text-amber-700 hover:bg-amber-200 hover:shadow transition-all"
                                        title="Print Bill for Guest"
                                    >
                                        <FaPrint size={20} />
                                    </button>
                                </div>
                                
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
                                                                    No active items found!
                                                                </td>
                                                            </tr>
                                                        )}
                                                    </tbody>
                                                </table>
                                                
                                               {/* ================= FIXED MATH & DISCOUNT FOOTER ================= */}
                                            <div className="flex gap-4 mb-4 mt-2">
                                                
                                                {/* LEFT SIDE: SPECIAL DISCOUNT (List UI) */}
                                                <div className="w-1/2 bg-blue-50 p-3 rounded border border-blue-200 flex flex-col gap-3">
                                                    <div className="flex justify-between items-center border-b border-blue-200 pb-2">
                                                        <label className="text-xs text-blue-800 uppercase tracking-wider font-bold">Apply Discounts</label>
                                                        <div className="flex items-center gap-2 text-xs font-bold text-blue-800">
                                                            <span>Total Pax:</span>
                                                            <input 
                                                                type="number" min="1" value={paxCount}
                                                                onChange={(e) => {
                                                                    setPaxCount(Math.max(1, parseInt(e.target.value) || 1));
                                                                    // If they lower pax below the discount count, trim the array!
                                                                    if (e.target.value < appliedDiscounts.length) setAppliedDiscounts([]);
                                                                }}
                                                                className="w-12 p-1 border border-blue-300 rounded text-center"
                                                            />
                                                        </div>
                                                    </div>

                                                    {/* The Input Form */}
                                                    <div className="flex flex-col gap-2">
                                                        <select 
                                                            value={tempDiscountType}
                                                            onChange={(e) => setTempDiscountType(e.target.value)}
                                                            className="w-full p-2 border border-gray-300 rounded text-sm outline-none focus:border-blue-500 bg-white"
                                                        >
                                                            <option value="Senior/PWD">Senior Citizen / PWD</option>
                                                            <option value="Medal of Valor">Medal of Valor</option>
                                                        </select>
                                                        <div className="flex gap-2">
                                                            <input 
                                                                type="text"
                                                                value={tempDiscountId}
                                                                onChange={(e) => setTempDiscountId(e.target.value)}
                                                                placeholder="ID Number..."
                                                                className="flex-1 p-2 border border-gray-300 rounded text-sm outline-none focus:border-blue-500"
                                                            />
                                                            <button 
                                                                onClick={handleAddDiscount}
                                                                className="bg-blue-600 hover:bg-blue-700 text-white font-bold px-3 py-1 rounded text-sm transition-colors disabled:opacity-50"
                                                                disabled={appliedDiscounts.length >= paxCount}
                                                            >
                                                                Add
                                                            </button>
                                                        </div>
                                                    </div>

                                                    {/* The Applied List */}
                                                    {appliedDiscounts.length > 0 && (
                                                        <div className="mt-1 flex flex-col gap-1 max-h-[80px] overflow-y-auto">
                                                            {appliedDiscounts.map((disc, idx) => (
                                                                <div key={idx} className="flex justify-between items-center bg-white p-1.5 rounded border border-blue-100 text-xs shadow-sm">
                                                                    <span className="truncate pr-2"><strong className="text-blue-800">{disc.type}:</strong> {disc.id_number}</span>
                                                                    <button onClick={() => handleRemoveDiscount(idx)} className="text-red-500 hover:text-red-700 font-bold px-1">✕</button>
                                                                </div>
                                                            ))}
                                                        </div>
                                                    )}
                                                </div>

                                                {/* RIGHT SIDE: DYNAMIC TOTALS */}
                                                <div className="w-1/2 bg-gray-50 p-3 rounded border border-gray-200 flex flex-col items-end justify-end space-y-1">
                                                    <p className="text-gray-500 text-sm flex justify-between w-full max-w-[250px]">
                                                        <span>Base Subtotal:</span> <span>₱{displaySubtotal.toFixed(2)}</span>
                                                    </p>
                                                    
                                                    {appliedDiscounts.length > 0 && (
                                                         <p className="text-red-600 text-sm font-bold bg-red-50 px-2 py-1 rounded flex justify-between w-full max-w-[250px] border border-red-100">
                                                            <span>Discount ({appliedDiscounts.length}/{paxCount}):</span>
                                                            <span>-₱{discountAmount.toFixed(2)}</span>
                                                        </p>
                                                    )}
                                                    
                                                    <p className="text-gray-500 text-sm flex justify-between w-full max-w-[250px]">
                                                        <span>Service (10%):</span> <span>₱{displayServiceCharge.toFixed(2)}</span>
                                                    </p>
                                                    <p className="text-gray-500 text-sm flex justify-between w-full max-w-[250px]">
                                                        <span>VAT (12%):</span> <span>₱{displayVat.toFixed(2)}</span>
                                                    </p>
                                                    
                                                    <div className="w-full max-w-[250px] border-t border-gray-300 mt-1 pt-1 flex justify-between items-end">
                                                        <span className="text-sm font-bold text-gray-700 uppercase tracking-wider mb-1">Total Due</span>
                                                        <span className="text-2xl font-bold text-gray-900">₱{displayTotal.toFixed(2)}</span>
                                                    </div>
                                                </div>
                                            </div>
                                            </div>
                                        {/* ================= CHECKOUT BUTTON ================= */}
                                        <div className="mt-4 pt-4 border-t border-gray-200">
                                            <button
                                                onClick={() => setShowSettleModal(true)}
                                                className="w-full py-4 rounded font-bold text-xl bg-green-600 hover:bg-green-700 text-white shadow-lg transform hover:-translate-y-1 transition-all"
                                            >
                                                Proceed to Payment
                                            </button>
                                        </div>
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
                        <div className="bg-white rounded-lg p-6 w-full max-w-md shadow-2xl relative border-t-4 border-green-500">
                        <button 
                            onClick={() => setShowSettleModal(false)}
                            className="absolute top-3 right-3 text-gray-400 hover:text-gray-600 font-bold"
                        >✕</button>
                        
                        <div className="flex flex-col items-center text-center mb-4">
                            <div className="bg-green-100 p-4 rounded-full mb-3 text-green-600">
                                <FaMoneyBillWave size={32} />
                            </div>
                            <h3 className="text-2xl font-bold text-gray-800">Process Payment</h3>
                            <p className="text-gray-500 mt-2 border-b pb-4 w-full">
                                Total Due for <span className="font-bold text-gray-800">{selectedTab?.formatted_location}</span>: 
                                <span className="text-xl font-bold text-green-600 ml-2">₱{displayTotal.toFixed(2)}</span>
                            </p>
                        </div>

                        {/* --- PAYMENT METHOD SELECTOR --- */}
                        <div className="mb-6 w-full text-left">
                            <h3 className="font-bold mb-3 text-gray-800 uppercase text-xs tracking-wider">Select Payment Method:</h3>
                            <div className="grid grid-cols-2 gap-2">
                                {['Credit Card', 'Cash', 'Charge to Deposit'].map(method => (
                                    <button
                                        key={method}
                                        onClick={() => setPaymentMethod(method)}
                                        className={`flex-1 py-3 text-sm rounded font-bold border-2 transition-all ${paymentMethod === method ? 'border-amber-600 bg-amber-50 text-amber-800 shadow-inner' : 'border-gray-200 text-gray-500 hover:border-amber-300 hover:bg-amber-50/50'}`}
                                    >
                                        {method}
                                    </button>
                                ))}
                            </div>
                        </div>
                        
                        {/* --- CASH CALCULATOR (Only shows if Cash is selected) --- */}
                        {paymentMethod === 'Cash' && (
                            <div className="mb-6 w-full text-left bg-gray-50 p-4 rounded border border-gray-200">
                                <label className="text-xs text-gray-500 uppercase tracking-wider block mb-2 font-bold">Amount Tendered (₱)</label>
                                <input
                                    type="number"
                                    value={amountTendered}
                                    onChange={(e) => setAmountTendered(e.target.value)}
                                    className="w-full p-3 border border-gray-300 rounded font-bold text-xl text-gray-800 outline-none focus:border-amber-500 focus:ring-2 focus:ring-amber-200"
                                    placeholder="Enter amount given..."
                                    autoFocus
                                />
                                
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

                        {/* --- DEPOSIT CALCULATOR (Only shows if Charge to Deposit is selected) --- */}
                        {paymentMethod === 'Charge to Deposit' && (
                        <div className="mb-6 w-full text-left bg-blue-50 p-4 rounded border border-blue-200">
                            <p className="text-sm text-blue-800 font-bold">
                                Confirming deduction for {selectedTab.formatted_location}
                            </p>
                            <p className="text-xs text-blue-600 mt-2">
                                The system will automatically find the active guest reservation for this room and deduct ₱{displayTotal.toFixed(2)}.
                            </p>
                        </div>
                         )}
                        
                        {/* --- ACTION BUTTONS --- */}
                        <div className="flex gap-3 mt-4">
                            <button 
                                onClick={() => setShowSettleModal(false)}
                                className="flex-1 py-3 rounded-lg font-bold border border-gray-300 text-gray-700 hover:bg-gray-100 transition-colors"
                            >Cancel</button>
                            <button 
                            onClick={handleSettleBill}
                            disabled={
                                !paymentMethod || 
                                (paymentMethod === 'Cash' && (!amountTendered || parseFloat(amountTendered) < displayTotal))
                            }
                            className={`flex-1 py-3 rounded-lg font-bold shadow-md transition-colors ${
                                !paymentMethod || 
                                (paymentMethod === 'Cash' && (!amountTendered || parseFloat(amountTendered) < displayTotal))
                                ? 'bg-gray-300 text-gray-500 cursor-not-allowed' : 'bg-green-600 text-white hover:bg-green-700'
                            }`}
                        >Confirm Payment</button>
                        </div>
                    </div>
                    </div>
                </div>
            )}
        </>
    );
}

export default CashierDashboard;
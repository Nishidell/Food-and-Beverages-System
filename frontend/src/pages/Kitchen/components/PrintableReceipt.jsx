import React from 'react';

const PrintableReceipt = ({ tab, details, appliedDiscounts, paxCount, discountAmount, displaySubtotal, displayServiceCharge, displayVat, displayTotal }) => {
    if (!tab || !details) return null;

    return (
        <>
            {/* 🛡️ THE BULLETPROOF "HOISTING" CSS */}
            <style>
                {`
                    /* Hide the receipt on the computer screen */
                    @media screen {
                        #printable-receipt { display: none !important; }
                    }
                    
                    /* The magic print rules */
                    @media print {
                        /* 1. Make EVERYTHING on the page invisible */
                        body * {
                            visibility: hidden;
                        }
                        
                        /* 2. Make ONLY the receipt and its contents visible */
                        #printable-receipt, #printable-receipt * {
                            visibility: visible;
                        }
                        
                        /* 3. Rip the receipt out of the normal layout and pin it to the top-left of the paper */
                        #printable-receipt {
                            position: absolute;
                            left: 0;
                            top: 0;
                            width: 100%;
                            display: block !important;
                            margin: 0;
                            padding: 20px;
                        }
                    }
                `}
            </style>

            {/* Added the specific ID here so our CSS can target it perfectly */}
            <div id="printable-receipt" className="text-black max-w-md mx-auto" style={{ fontFamily: 'monospace' }}>
                
                {/* Header */}
                <div className="text-center mb-6 border-b-2 border-dashed border-gray-300 pb-4">
                    <h1 className="text-3xl font-bold mb-1" style={{ color: 'black' }}>CELESTIA HOTEL</h1>
                    <p className="text-sm">Food & Beverage Service</p>
                    <p className="text-sm mt-2 font-bold">GUEST SUMMARY</p>
                </div>

                {/* Guest Info */}
                <div className="mb-6 text-sm">
                    <div className="flex justify-between">
                        <span>Order #: {tab.order_id}</span>
                        <span>Date: {new Date().toLocaleDateString()}</span>
                    </div>
                    <div className="flex justify-between mt-1">
                        <span>Guest: {tab.first_name} {tab.last_name}</span>
                        <span>Location: {tab.formatted_location}</span>
                    </div>
                </div>

                {/* Itemized List */}
                <table className="w-full text-sm mb-6">
                    <thead>
                        <tr className="border-b border-gray-300">
                            <th className="text-left pb-1 w-12">Qty</th>
                            <th className="text-left pb-1">Item</th>
                            <th className="text-right pb-1">Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        {details.items?.map((item, idx) => (
                            <tr key={idx}>
                                <td className="py-2 align-top">{item.quantity}</td>
                                <td className="py-2 pr-2">{item.item_name}</td>
                                <td className="py-2 text-right align-top">₱{parseFloat(item.subtotal).toFixed(2)}</td>
                            </tr>
                        ))}
                    </tbody>
                </table>

                {/* Totals */}
                <div className="border-t-2 border-dashed border-gray-300 pt-4 text-sm flex flex-col gap-1">
                    <div className="flex justify-between">
                        <span>Base Subtotal</span>
                        <span>₱{displaySubtotal?.toFixed(2)}</span>
                    </div>

                   {/* DYNAMIC DISCOUNT LINE */}
                    {appliedDiscounts && appliedDiscounts.length > 0 && (
                        <div className="flex flex-col">
                            <div className="flex justify-between font-bold" style={{ color: '#d97706' }}>
                                <span>Discount ({appliedDiscounts.length}/{paxCount})</span>
                                <span>-₱{discountAmount?.toFixed(2)}</span>
                            </div>
                            {/* The Audit Trail: List the IDs on the physical paper */}
                            <div className="text-xs text-gray-600 pl-2 mb-1" style={{ color: '#555' }}>
                                {appliedDiscounts.map((disc, idx) => (
                                    <div key={idx}>• {disc.type}: {disc.id_number}</div>
                                ))}
                            </div>
                        </div>
                    )}
                    
                    <div className="flex justify-between mt-1">
                        <span>Service Charge (10%)</span>
                        <span>₱{displayServiceCharge?.toFixed(2)}</span>
                    </div>
                    <div className="flex justify-between">
                        <span>VAT (12%)</span>
                        <span>₱{displayVat?.toFixed(2)}</span>
                    </div>
                    
                    <div className="flex justify-between text-lg font-bold mt-2 pt-2 border-t border-gray-400">
                        <span>GRAND TOTAL</span>
                        <span>₱{displayTotal?.toFixed(2)}</span>
                    </div>
                </div>

                {/* Footer */}
                <div className="text-center mt-10 text-xs text-gray-500 flex flex-col items-center">
                    <p>*** PRE-PAYMENT BILL ***</p>
                    <p className="mt-2">Thank you for dining with us!</p>
                    <p>Please present this summary to your server.</p>
                    
                    {/* ✅ UPGRADED: Dynamic QR Code targeting the specific order */}
                    <div className="mt-6 mb-2 flex flex-col items-center">
                        <p className="font-bold text-black mb-2 text-[10px] uppercase tracking-wider">Scan to Rate Your Food!</p>
                        <img 
                            src={`https://api.qrserver.com/v1/create-qr-code/?size=100x100&data=${encodeURIComponent(window.location.origin + '/guest-rating/' + tab.order_id)}`} 
                            alt="QR Code" 
                            className="w-24 h-24 mb-1" 
                        />
                        <p className="text-[10px]">We value your feedback</p>
                    </div>
                </div>
            </div>
        </>
    );
};

export default PrintableReceipt;
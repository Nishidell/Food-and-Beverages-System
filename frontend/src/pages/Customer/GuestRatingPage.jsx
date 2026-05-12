import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { Star, CheckCircle, Utensils, MessageSquare } from 'lucide-react';
import toast from 'react-hot-toast';
import apiClient from '../../utils/apiClient';
import './CustomerTheme.css';

const GuestRatingPage = () => {
    const { orderId } = useParams();
    const navigate = useNavigate();

    const [order, setOrder] = useState(null);
    const [loading, setLoading] = useState(true);
    const [ratings, setRatings] = useState({}); // Stores { item_id: { value, comment } }
    const [isSubmitting, setIsSubmitting] = useState(false);
    const [isFinished, setIsFinished] = useState(false);

    // 1. Fetch Order Items on Load
    useEffect(() => {
        const fetchOrderItems = async () => {
            try {
                // Uses the existing GET /orders/:id route [cite: 368]
                const res = await apiClient(`/orders/${orderId}`);
                if (!res.ok) throw new Error('Order not found');
                
                const data = await res.json();
                setOrder(data);
                
                // Initialize empty ratings for each item
                const initialRatings = {};
                data.items.forEach(item => {
                    // ✅ Use order_detail_id to ensure every row is independent
                    initialRatings[item.order_detail_id] = { 
                        item_id: item.item_id, // Keep this for the actual submission
                        value: 0, 
                        comment: '' 
                    };
                });
                setRatings(initialRatings);
            } catch (err) {
                toast.error("Invalid or expired rating link.");
                navigate('/');
            } finally {
                setLoading(false);
            }
        };
        fetchOrderItems();
    }, [orderId, navigate]);

    // 2. Handle Star Clicking
    const handleSetStar = (itemId, value) => {
        setRatings(prev => ({
            ...prev,
            [itemId]: { ...prev[itemId], value }
        }));
    };

    // 3. Handle Comment Input
    const handleSetComment = (itemId, comment) => {
        setRatings(prev => ({
            ...prev,
            [itemId]: { ...prev[itemId], comment }
        }));
    };

    // 4. Submit All Ratings
    const handleSubmitAll = async () => {
        const itemsToSubmit = Object.entries(ratings)
            .filter(([_, data]) => data.value > 0)
            .map(([itemId, data]) => ({
                item_id: parseInt(itemId),
                rating_value: data.value,
                review_text: data.comment,
                order_id: parseInt(orderId) // Link it to the specific walk-in order
            }));

        if (itemsToSubmit.length === 0) {
            toast.error("Please rate at least one item.");
            return;
        }

        setIsSubmitting(true);
        try {
            // Submit each rating to the existing /ratings POST route [cite: 852]
            await Promise.all(itemsToSubmit.map(ratingData => 
                apiClient('/ratings', {
                    method: 'POST',
                    body: JSON.stringify(ratingData)
                })
            ));

            toast.success("Thank you for your feedback!");
            setIsFinished(true);
        } catch (err) {
            toast.error("Failed to save feedback.");
        } finally {
            setIsSubmitting(false);
        }
    };

    if (loading) return <div className="min-h-screen bg-[#0B3D2E] flex items-center justify-center text-[#F9A825]">Loading order details...</div>;

    if (isFinished) {
        return (
            <div className="min-h-screen bg-[#0B3D2E] flex flex-col items-center justify-center p-6 text-center">
                <div className="bg-[#FFF8E1] p-10 rounded-3xl shadow-2xl max-w-sm w-full border-b-8 border-[#F9A825]">
                    <CheckCircle size={80} className="text-green-600 mx-auto mb-4" />
                    <h2 className="text-2xl font-bold text-[#0B3D2E] mb-2">Thank You!</h2>
                    <p className="text-gray-600 mb-6">Your feedback helps us serve you better. We hope to see you again at Celestia Hotel!</p>
                    <button onClick={() => navigate('/')} className="w-full py-3 bg-[#0B3D2E] text-[#FFF8E1] font-bold rounded-xl">Back to Menu</button>
                </div>
            </div>
        );
    }

    return (
        <div className="min-h-screen bg-[#0B3D2E] pb-10">
            <header className="bg-[#0B3D2E] py-6 text-center border-b border-[#FFF8E1]/10">
                <h1 className="text-2xl font-black text-[#F9A825] tracking-widest uppercase">Celestia Hotel</h1>
                <p className="text-[#FFF8E1]/60 text-xs mt-1">Guest Feedback for Order #{orderId}</p>
            </header>

            <main className="max-w-xl mx-auto px-4 mt-8">
                <div className="space-y-6">
                    {order.items.map((item) => (
                        <div key={item.item_id} className="bg-[#FFF8E1] rounded-2xl p-6 shadow-xl border-l-4 border-[#F9A825]">
                            <div className="flex items-center gap-3 mb-4">
                                <div className="bg-[#0B3D2E]/10 p-2 rounded-lg text-[#0B3D2E]"><Utensils size={20}/></div>
                                <h3 className="font-bold text-[#0B3D2E] text-lg">{item.item_name}</h3>
                            </div>

                            {/* Stars Section [cite: 858, 860] */}
                            <div className="flex gap-2 mb-4 justify-center">
                                {[1, 2, 3, 4, 5].map((star) => (
                                    <button key={star} onClick={() => handleSetStar(item.item_id, star)} className="transition-transform active:scale-90">
                                        <Star 
                                            size={32} 
                                            fill={ratings[item.item_id]?.value >= star ? "#F9A825" : "none"} 
                                            color={ratings[item.item_id]?.value >= star ? "#F9A825" : "#D1C0B6"} 
                                            strokeWidth={1.5}
                                        />
                                    </button>
                                ))}
                            </div>

                            {/* Optional Comment Section [cite: 863] */}
                            <div className="relative">
                                <MessageSquare size={14} className="absolute left-3 top-3 text-gray-400" />
                                <textarea
                                    className="w-full pl-9 p-3 border border-gray-200 rounded-xl text-sm bg-white resize-none outline-none focus:ring-2 focus:ring-[#F9A825]"
                                    rows="2"
                                    placeholder="Write a quick note... (optional)"
                                    value={ratings[item.item_id]?.comment}
                                    onChange={(e) => handleSetComment(item.item_id, e.target.value)}
                                ></textarea>
                            </div>
                        </div>
                    ))}
                </div>

                <div className="mt-10">
                    <button 
                        onClick={handleSubmitAll}
                        disabled={isSubmitting}
                        className="w-full py-4 bg-[#F9A825] text-[#3C2A21] font-black rounded-2xl shadow-xl hover:bg-[#e0961f] transition-all disabled:bg-gray-400 text-lg uppercase tracking-wider"
                    >
                        {isSubmitting ? 'Submitting...' : 'Submit All Feedback'}
                    </button>
                </div>
            </main>
        </div>
    );
};

export default GuestRatingPage;
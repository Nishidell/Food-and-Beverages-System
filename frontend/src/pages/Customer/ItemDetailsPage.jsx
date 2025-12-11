import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { ArrowLeft, Star, Minus, Plus, ShoppingCart, User } from 'lucide-react';
import { useAuth } from '../../context/AuthContext';
import { useCart } from '../../context/CartContext';
import apiClient from '../../utils/apiClient';
import toast from 'react-hot-toast';
import './CustomerTheme.css';

const ItemDetailsPage = () => {
  const { id } = useParams();
  const navigate = useNavigate();
  const { user } = useAuth();
  const { addToCart } = useCart();

  const [item, setItem] = useState(null);
  const [reviews, setReviews] = useState([]);
  const [loading, setLoading] = useState(true);
  const [quantity, setQuantity] = useState(1);
  const [adding, setAdding] = useState(false);

  // Helper for images
  const getImageUrl = (imagePath) => {
    if (!imagePath) return 'https://via.placeholder.com/400x300.png?text=No+Image';
    if (imagePath.startsWith('http')) return imagePath;
    const BASE_URL = window.location.hostname === 'localhost' 
        ? 'http://localhost:21917' 
        : 'https://food-and-beverages-system.onrender.com';
    return `${BASE_URL}${imagePath}`;
  };

  useEffect(() => {
    const fetchDetails = async () => {
      try {
        setLoading(true);
        // 1. Fetch Item Details
        const itemRes = await apiClient(`/items/${id}`);
        if (!itemRes.ok) throw new Error('Item not found');
        const itemData = await itemRes.json();
        setItem(itemData);

        // 2. Fetch Reviews for this item
        const reviewRes = await apiClient(`/ratings/${id}`);
        if (reviewRes.ok) {
            const reviewData = await reviewRes.json();
            setReviews(reviewData.reviews || []);
        }

      } catch (error) {
        toast.error(error.message);
        navigate('/');
      } finally {
        setLoading(false);
      }
    };
    fetchDetails();
  }, [id, navigate]);

  const handleAddToCart = () => {
    if (!user) {
        if(window.confirm("You need to login to order. Go to login page?")) {
            navigate('/login');
        }
        return;
    }

    setAdding(true);
    // Simulate slight delay for effect
    setTimeout(() => {
        // Calculate promo price if active
        let finalPrice = item.price;
        if (item.is_promo) {
             const discount = parseFloat(item.promo_discount_percentage) / 100;
             finalPrice = parseFloat(item.price) * (1 - discount);
        }

        addToCart({
            ...item,
            price: finalPrice, // Use processed price
            quantity: quantity
        });
        toast.success(`Added ${quantity}x ${item.item_name} to cart`);
        setAdding(false);
    }, 500);
  };

  if (loading) return <div className="min-h-screen bg-[#0B3D2E] flex items-center justify-center text-[#F9A825]">Loading...</div>;
  if (!item) return null;

  // Calculate Price Display
  const isPromo = item.is_promo;
  const originalPrice = parseFloat(item.price);
  const discount = isPromo ? parseFloat(item.promo_discount_percentage) / 100 : 0;
  const displayPrice = isPromo ? originalPrice * (1 - discount) : originalPrice;

  return (
    <div className="min-h-screen bg-[#0B3D2E] pb-20">
      
      {/* 1. Header (Simple Back Button) */}
      <div className="max-w-6xl mx-auto pt-6 px-4 mb-6">
        <button 
            onClick={() => navigate('/')}
            className="flex items-center gap-2 text-[#FFF8E1] hover:text-[#F9A825] transition-colors font-bold"
        >
            <ArrowLeft size={24} /> Back to Menu
        </button>
      </div>

      <div className="max-w-6xl mx-auto px-4 grid grid-cols-1 md:grid-cols-2 gap-8">
        
        {/* 2. LEFT COLUMN: Image */}
        <div className="bg-white rounded-2xl p-2 shadow-xl h-fit">
            <img 
                src={getImageUrl(item.image_url)} 
                alt={item.item_name}
                className="w-full h-[400px] object-cover rounded-xl"
            />
        </div>

        {/* 3. RIGHT COLUMN: Details (Cream Card) */}
        <div className="bg-[#FFF8E1] rounded-2xl p-8 shadow-xl h-fit border-l-8 border-[#F9A825]">
            
            {/* Title */}
            <h1 className="text-4xl font-bold text-[#0B3D2E] mb-2">{item.item_name}</h1>
            
            {/* Stats Row */}
            <div className="flex items-center gap-4 mb-6 text-sm text-gray-600 border-b border-[#0B3D2E]/10 pb-4">
                <div className="flex items-center gap-1 text-[#F9A825] font-bold">
                    <span className="text-lg underline decoration-1 underline-offset-4">{item.average_rating}</span>
                    <div className="flex">
                        {[...Array(5)].map((_, i) => (
                             <Star key={i} size={14} fill={i < Math.round(item.average_rating) ? "#F9A825" : "#ddd"} color="none" />
                        ))}
                    </div>
                </div>
                <div className="w-[1px] h-4 bg-gray-400"></div>
                <div className="flex gap-1">
                    <span className="font-bold text-[#0B3D2E] underline decoration-1 underline-offset-4">{item.total_reviews}</span>
                    <span>Ratings</span>
                </div>
                <div className="w-[1px] h-4 bg-gray-400"></div>
                <div className="flex gap-1">
                    <span className="font-bold text-[#0B3D2E]">{item.total_sold}</span>
                    <span className="text-gray-500">Sold</span>
                </div>
            </div>

            {/* Price */}
            <div className="mb-6">
                {isPromo ? (
                    <div className="flex items-end gap-3">
                        <span className="text-4xl font-bold text-[#F9A825]">₱{displayPrice.toFixed(2)}</span>
                        <span className="text-xl text-gray-400 line-through mb-1">₱{originalPrice.toFixed(2)}</span>
                        <span className="bg-red-500 text-white text-xs font-bold px-2 py-1 rounded-full mb-2">
                            {item.promo_discount_percentage}% OFF
                        </span>
                    </div>
                ) : (
                    <span className="text-4xl font-bold text-[#F9A825]">₱{displayPrice.toFixed(2)}</span>
                )}
            </div>

            {/* Description */}
            <div className="mb-8">
                <h3 className="text-sm font-bold text-gray-400 uppercase tracking-wide mb-2">Description</h3>
                <p className="text-[#0B3D2E] leading-relaxed text-lg">
                    {item.description || "No description available for this delicious item."}
                </p>
            </div>

            {/* Actions Row */}
            <div className="flex flex-col sm:flex-row gap-4">
                {/* Quantity Selector */}
                <div className="flex items-center border-2 border-[#0B3D2E]/10 rounded-xl bg-white w-fit">
                    <button 
                        onClick={() => setQuantity(q => Math.max(1, q - 1))}
                        className="p-4 text-[#0B3D2E] hover:bg-gray-100 rounded-l-xl transition-colors"
                    >
                        <Minus size={20} />
                    </button>
                    <span className="w-12 text-center font-bold text-xl text-[#0B3D2E]">{quantity}</span>
                    <button 
                        onClick={() => setQuantity(q => q + 1)}
                        className="p-4 text-[#0B3D2E] hover:bg-gray-100 rounded-r-xl transition-colors"
                    >
                        <Plus size={20} />
                    </button>
                </div>

                {/* Add Button */}
                {item.is_available ? (
                    <button 
                        onClick={handleAddToCart}
                        disabled={adding}
                        className="flex-1 bg-[#0B3D2E] text-white font-bold py-4 px-8 rounded-xl hover:bg-[#082a20] transition-transform active:scale-95 flex items-center justify-center gap-2 shadow-lg"
                    >
                        <ShoppingCart size={24} />
                        {adding ? 'Adding...' : 'Add To Cart'}
                    </button>
                ) : (
                    <button disabled className="flex-1 bg-gray-300 text-gray-500 font-bold py-4 px-8 rounded-xl cursor-not-allowed">
                        Currently Unavailable
                    </button>
                )}
            </div>
        </div>
      </div>

      {/* 4. REVIEWS SECTION (Bottom) */}
      <div className="max-w-6xl mx-auto px-4 mt-12">
        <div className="bg-white rounded-2xl p-8 shadow-xl">
            <h2 className="text-2xl font-bold text-[#0B3D2E] mb-6">Product Ratings</h2>
            
            {reviews.length === 0 ? (
                <p className="text-gray-500 italic">No reviews yet.</p>
            ) : (
                <div className="space-y-6">
                    {reviews.map((review) => (
                        <div key={review.rating_id} className="border-b border-gray-100 last:border-0 pb-6 last:pb-0">
                            <div className="flex items-center gap-3 mb-2">
                                <div className="w-10 h-10 rounded-full bg-[#FFF8E1] flex items-center justify-center text-[#F9A825] font-bold">
                                    <User size={20} />
                                </div>
                                <div>
                                    <p className="text-sm font-bold text-[#0B3D2E]">{review.customer_name || 'Customer'}</p>
                                    <div className="flex items-center gap-2">
                                        <div className="flex">
                                            {[...Array(5)].map((_, i) => (
                                                <Star key={i} size={12} fill={i < review.rating_value ? "#F9A825" : "#ddd"} color="none" />
                                            ))}
                                        </div>
                                        <span className="text-xs text-gray-400">
                                            {new Date(review.created_at).toLocaleDateString()}
                                        </span>
                                    </div>
                                </div>
                            </div>
                            {review.review_text && (
                                <p className="text-gray-600 mt-2 ml-14">{review.review_text}</p>
                            )}
                        </div>
                    ))}
                </div>
            )}
        </div>
      </div>

    </div>
  );
};

export default ItemDetailsPage;
import React from 'react';
import { useNavigate } from 'react-router-dom';
import { Star } from 'lucide-react'; 
import { useAuth } from '../../../context/AuthContext';
import '../CustomerTheme.css';

// ✅ UPGRADED: Smart URL Helper with Backslash Fix
const FALLBACK_IMAGE = 'https://placehold.co/400x300/e2e8f0/1e293b?text=No+Image';

const getImageUrl = (imagePath) => {
  if (!imagePath) return FALLBACK_IMAGE;
  if (imagePath.startsWith('http')) return imagePath; 
  
  // Convert Windows backslashes to web forward slashes
  const normalizedPath = imagePath.replace(/\\/g, '/');
  
  // Dynamically grab your real backend URL
  let apiUrl = import.meta.env.VITE_API_URL || 'http://localhost:21917/api';
  const baseUrl = apiUrl.replace(/\/api\/?$/, ''); 
      
  const cleanPath = normalizedPath.startsWith('/') ? normalizedPath : `/${normalizedPath}`;    
  return `${baseUrl}${cleanPath}`;
};

const FoodGrid = ({ items, onAddToCart, onImageClick, layoutStyle, theme = "customer", isPOS = false }) => {
  const navigate = useNavigate();
  const { user } = useAuth();

  if (!items || items.length === 0) {
    return <p className="no-items-message">No items match your search.</p>;
  }

  // Helper to calculate promo prices
  const getPromoPrice = (item) => {
    if (!item.is_promo || !item.promo_discount_percentage || !item.promo_expiry_date) {
      return { isActive: false, displayPrice: item.price };
    }
    const today = new Date();
    today.setHours(0, 0, 0, 0); 
    const expiryDate = new Date(item.promo_expiry_date);
    if (expiryDate < today) {
      return { isActive: false, displayPrice: item.price };
    }
    
    const discount = parseFloat(item.promo_discount_percentage) / 100;
    const discountedPrice = parseFloat(item.price) * (1 - discount);
    
    return {
      isActive: true,
      displayPrice: discountedPrice,
      originalPrice: item.price,
      discountPercent: item.promo_discount_percentage,
    };
  };

  return (
    <div 
        className={`menu-grid-layout ${theme === 'customer' ? 'customer-theme' : 'kitchen-theme'}`} 
        style={layoutStyle}
    >
      {items.map((item) => {
        const { isActive, displayPrice, originalPrice, discountPercent } = getPromoPrice(item);
        const itemForCart = { ...item, price: displayPrice };
        const rating = parseFloat(item.average_rating || 0);
        const reviewCount = item.total_reviews || 0;

        if (isPOS) {
            return (
                <div 
                    key={item.item_id}
                    onClick={() => { if (item.is_available) onAddToCart(itemForCart); }}
                    className={`relative rounded-xl overflow-hidden border-2 cursor-pointer transition-all active:scale-95 flex flex-col h-58 shadow-sm 
                        ${!item.is_available ? 'opacity-50 grayscale border-gray-300' : 'border-gray-200 hover:border-amber-500 hover:shadow-md bg-white'}`}
                >
                    {/* Top Half: The Image */}
                    <div className="h-32 w-full bg-gray-100 overflow-hidden flex justify-center items-center border-b border-gray-100">
                    {/* ✅ UPGRADED: POS Image with Loop Breaker */}
                    <img 
                        src={getImageUrl(item.image_url)} 
                        alt={item.item_name} 
                        className="w-full h-full object-cover rounded-t-lg"
                        onError={(e) => { 
                            if (e.target.src !== FALLBACK_IMAGE) {
                              e.target.src = FALLBACK_IMAGE; 
                            }
                        }} 
                    />

                    {isActive && (
                    <div className="absolute top-1 left-1 bg-red-500 text-white text-[10px] font-bold px-1.5 py-0.5 rounded shadow-sm z-10">
                        {discountPercent}% OFF
                    </div>
                   )}
                   </div>
                    
                    {/* Bottom Half: Name & Price */}
                    <div className="p-2 flex-1 flex flex-col justify-center items-center">
                        <span className="font-bold text-xs text-gray-800 text-center leading-tight line-clamp-1 w-full truncate">
                            {item.item_name}
                        </span>
                        
                        <div className="mt-0.5 flex flex-wrap justify-center items-center gap-x-1">
                            {isActive && (
                                <span className="text-[10px] text-gray-400 line-through">
                                    ₱{parseFloat(originalPrice).toFixed(2)}
                                </span>
                            )}
                            <span className="text-xs font-bold text-amber-700">
                                ₱{parseFloat(displayPrice).toFixed(2)}
                            </span>
                        </div>
                    </div>

                    {/* Sold Out Overlay */}
                    {!item.is_available && (
                        <div className="absolute inset-0 flex items-center justify-center bg-white/40">
                            <span className="bg-red-600 text-white text-[10px] uppercase tracking-wider font-bold px-2 py-1 rounded">Sold Out</span>
                        </div>
                    )}
                </div>
            );
        }

        return (
          <div 
            key={item.item_id} 
            className={`food-card ${!item.is_available ? 'unavailable' : ''} cursor-pointer hover:shadow-xl transition-shadow`}
            onClick={() => {
                if (isPOS) {
                    if (item.is_available) onAddToCart(itemForCart);
                } else {
                    navigate(`/item/${item.item_id}`);
                }
            }}
          >
           
          <div className="card-image-container relative" onClick={() => onImageClick(getImageUrl(item.image_url))}>
            {isActive && (
                <div className="absolute top-2 left-2 bg-red-500 text-white text-xs font-bold px-2 py-1 rounded shadow-md z-10">
                    {discountPercent}% OFF
                </div>
            )}
            {/* ✅ UPGRADED: Customer Image with Loop Breaker */}
            <img 
                src={getImageUrl(item.image_url)} 
                alt={item.item_name} 
                className="card-image" 
                onError={(e) => { 
                    if (e.target.src !== FALLBACK_IMAGE) {
                      e.target.src = FALLBACK_IMAGE; 
                    }
                }} 
            />
          </div>
             
          <div className="card-content">
              <h3 className="item-name mb-1">{item.item_name}</h3>
              <div className="card-footer mt-auto">

             <div className="price-container flex items-center gap-2">
            {isActive && (
                <span className="text-sm text-gray-400 line-through">
                    ₱{parseFloat(originalPrice).toFixed(2)}
                </span>
            )}
            <span className="price-text text-green-700">₱{parseFloat(displayPrice).toFixed(2)}</span>
            </div>
                {item.is_available ? (
                  <button 
                    onClick={(e) => {
                        e.stopPropagation(); 
                        
                        if (isPOS) {
                            onAddToCart(itemForCart);
                        } else if (!user) {
                            if(window.confirm("You need to login to order. Go to login page?")) {
                                navigate('/login');
                            }
                        } else {
                            onAddToCart(itemForCart);
                        }
                    }} 
                    className="btn-add-cart"
                  >
                    Add
                  </button>
                ) : (
                  <button disabled className="btn-unavailable">Unavailable</button>
                )}
              </div>
            </div>
          </div>
        );
      })}
    </div>
  );
};

export default FoodGrid;
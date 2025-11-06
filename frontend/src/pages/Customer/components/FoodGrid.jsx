import React from 'react';

// Temporary color objects
const primaryColor = {
  backgroundColor: '#0B3D2E'
};

const secondaryColor = {
  backgroundColor: '#fff2e0'
};

const FoodGrid = ({ items, onAddToCart, onImageClick }) => {
  if (!items || items.length === 0) {
    return <p className="text-center mt-12 text-gray-500">No items match your search.</p>;
  }

  // Helper function to check if promo is active
  const getPromoPrice = (item) => {
    // Check for all required promo fields
    if (!item.is_promo || !item.promo_discount_percentage || !item.promo_expiry_date) {
      return { isActive: false, displayPrice: item.price };
    }

    // Check if the expiry date has passed
    const today = new Date();
    today.setHours(0, 0, 0, 0); // Set to start of today
    const expiryDate = new Date(item.promo_expiry_date);

    if (expiryDate < today) {
      return { isActive: false, displayPrice: item.price };
    }

    // If active, calculate the new price
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
    <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8 mt-8">
      {items.map((item) => {
        
        const { isActive, displayPrice, originalPrice, discountPercent } = getPromoPrice(item);
        
        // Create a *new item object* with the correct price to add to the cart
        const itemForCart = {
          ...item,
          price: displayPrice // Overwrite price with the discounted price
        };
        
        // The card is now dimmer if it's unavailable, but has no text overlay
        const cardOpacity = !item.is_available ? 'opacity-80' : '';

        return (
          <div
            key={item.item_id}
            className={`rounded-lg shadow-lg overflow-hidden flex flex-col ${cardOpacity}`}
            style={secondaryColor}
          >
            <div className="relative">
              <img
                src={
                  item.image_url
                    ? `http://localhost:3000${item.image_url}`
                    : 'https://via.placeholder.com/400x300.png?text=No+Image'
                }
                alt={item.item_name}
                className="w-full h-56 object-cover cursor-pointer"
                onClick={() =>
                  onImageClick(
                    item.image_url ? `http://localhost:3000${item.image_url}` : null
                  )
                }
              />
              
              {/* Promo Badge */}
              {isActive && (
                <span className="absolute top-0 left-0 bg-red-600 text-white font-bold text-xs py-1 px-3 rounded-br-lg">
                  {discountPercent}% OFF
                </span>
              )}
            </div>

            {/* All text inside padded area */}
            <div className="p-6 flex-1 flex flex-col">
              <h3 className="text-2xl font-bold text-gray-800 mb-4">{item.item_name}</h3>
              <p className="text-lg text-green-900 mb-2">
                {item.description || 'No description available.'}
              </p>

              <div className="mt-auto flex justify-between items-center">
                
                {/* Price Display Logic */}
                {isActive ? (
                  <div className="flex flex-row items-baseline gap-2">
                    <p className="text-2xl font-semibold text-green-700">
                      ₱{parseFloat(displayPrice).toFixed(2)}
                    </p>
                    <p className="text-lg font-normal text-gray-500 line-through">
                      ₱{parseFloat(originalPrice).toFixed(2)}
                    </p>
                  </div>
                ) : (
                  <p className="text-2xl font-semibold text-gray-900">
                    ₱{parseFloat(displayPrice).toFixed(2)}
                  </p>
                )}
                
                {/* --- CONDITIONAL ADD BUTTON --- */}
                {item.is_available ? (
                  <button
                    onClick={() => onAddToCart(itemForCart)}
                    style={primaryColor}
                    className="text-white font-bold py-2 px-6 rounded-full hover:bg-orange-600 transition-transform transform hover:scale-105"
                  >
                    Add
                  </button>
                ) : (
                  <button
                    disabled
                    style={{ ...primaryColor, opacity: 0.5 }} // <-- THIS IS THE CHANGED LINE
                    className="text-white font-bold py-2 px-6 rounded-full cursor-not-allowed"
                  >
                    Unavailable
                  </button>
                )}
                {/* --- END OF CONDITIONAL BUTTON --- */}

              </div>
            </div>
          </div>
        );
      })}
    </div>
  );
};

export default FoodGrid;
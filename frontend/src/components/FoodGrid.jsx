import React from 'react';

const FoodGrid = ({ items, onAddToCart }) => {
  if (!items || items.length === 0) {
    return <p className="text-center mt-8">Loading menu...</p>;
  }

  return (
    <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6 mt-8">
      {items.map((item) => (
        <div key={item.item_id} className="bg-white rounded-lg shadow-md overflow-hidden">
          {/* ... img, h3, p tags ... */}
          <div className="p-4">
            <h3 className="text-lg font-semibold">{item.name}</h3>
            <p className="text-gray-500 text-sm mt-1 h-10 overflow-hidden">{item.description}</p>
            <div className="flex justify-between items-center mt-4">
              <span className="font-bold text-lg">${parseFloat(item.price).toFixed(2)}</span>
              {/* Add the onClick handler here */}
              <button
                onClick={() => {console.log('Adding item:', item); onAddToCart(item)}}
                className="bg-orange-500 text-white font-bold py-2 px-4 rounded hover:bg-orange-600 transition-colors"
              >
                Add
              </button>
            </div>
          </div>
        </div>
      ))}
    </div>
  );
};

export default FoodGrid;
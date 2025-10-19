import React from "react";

const FoodGrid = ({ addToCart, activeCategory }) => {
  const menuItems = [
    { id: 1, name: "Buffalo Wings", price: 360, image: "/images/wings.jpg", category: "Appetizers" },
    { id: 2, name: "Crispy Calamari", price: 420, image: "/images/calamari.jpg", category: "Appetizers" },
    { id: 3, name: "Caesar Salad", price: 380, image: "/images/salad.jpg", category: "Main Course" },
    { id: 4, name: "Chocolate Cake", price: 250, image: "/images/cake.jpg", category: "Desserts" },
    { id: 5, name: "Mango Shake", price: 180, image: "/images/shake.jpg", category: "Drinks" },
  ];

  // Filter items by active category
  const filteredItems =
    activeCategory === "All"
      ? menuItems
      : menuItems.filter((item) => item.category === activeCategory);

  return (
    <div>
      {filteredItems.length === 0 ? (
        <p className="text-center text-gray-500 mt-8">
          No items found in this category.
        </p>
      ) : (
        <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
          {filteredItems.map((item) => (
            <div
              key={item.id}
              className="bg-white rounded-lg shadow p-3 hover:shadow-md transition"
            >
              <img
                src={item.image}
                alt={item.name}
                className="rounded-lg w-full h-32 object-cover"
              />
              <h3 className="mt-2 font-semibold">{item.name}</h3>
              <p className="text-sm">₱{item.price}</p>
              <button
                onClick={() => addToCart(item)}
                className="mt-2 bg-green-800 text-white text-sm py-1 px-3 rounded hover:bg-green-900"
              >
                Add to Order
              </button>
            </div>
          ))}
        </div>
      )}
    </div>
  );
};

export default FoodGrid;

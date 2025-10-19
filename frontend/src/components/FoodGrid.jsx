import React from "react";

const MenuGrid = ({ addToCart }) => {
  const menuItems = [
    { id: 1, name: "Buffalo Wings", price: 360, image: "/images/wings.jpg" },
    { id: 2, name: "Crispy Calamari", price: 420, image: "/images/calamari.jpg" },
    { id: 3, name: "Caesar Salad", price: 380, image: "/images/salad.jpg" },
  ];

  return (
    <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
      {menuItems.map((item) => (
        <div key={item.id} className="bg-white rounded-lg shadow p-3">
          <img
            src={item.image}
            alt={item.name}
            className="rounded-lg w-full h-32 object-cover"
          />
          <h3 className="mt-2 font-semibold">{item.name}</h3>
          <p className="text-sm">₱{item.price}</p>
          <button
            onClick={() => addToCart(item)}
            className="mt-2 bg-green-800 text-white text-sm py-1 px-3 rounded"
          >
            Add to Order
          </button>
        </div>
      ))}
    </div>
  );
};

export default MenuGrid;


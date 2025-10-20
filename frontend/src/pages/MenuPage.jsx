import React from 'react';
import { useState, useEffect } from 'react';
import HeaderBar from '../components/HeaderBar';
import PromoBanner from '../components/PromoBanner';
import CategoryTabs from '../components/CategoryTabs';
import FoodGrid from '../components/FoodGrid';
import CartPanel from '../components/CartPanel';

function MenuPage() {
  const [items, setItems] = useState([]);
  const [error, setError] = useState(null);
  const [cartItems, setCartItems] = useState([]);

  useEffect(() => {
    const fetchItems = async () => {
      try {
        const response = await fetch('http://localhost:3000/api/items');
        if (!response.ok) {
          throw new Error('Failed to fetch data from the server.');
        }
        const data = await response.json();
        setItems(data);
      } catch (err) {
        setError(err.message);
        console.error("Error fetching items:", err);
      }
    };

    fetchItems();
  }, []);

  const handleAddToCart = (clickedItem) => {
    setCartItems((prevItems) => {
      const isItemInCart = prevItems.find((item) => item.item_id === clickedItem.item_id);
      if (isItemInCart) {
        return prevItems.map((item) =>
          item.item_id === clickedItem.item_id
            ? { ...item, quantity: item.quantity + 1 }
            : item
        );
      }
      return [...prevItems, { ...clickedItem, quantity: 1 }];
    });
  };

  const handleUpdateQuantity = (itemId, newQuantity) => {
    if (newQuantity <= 0) {
      setCartItems((prevItems) => prevItems.filter((item) => item.item_id !== itemId));
    } else {
      setCartItems((prevItems) =>
        prevItems.map((item) =>
          item.item_id === itemId ? { ...item, quantity: newQuantity } : item
        )
      );
    }
  };

  const handlePlaceOrder = async () => {
    // Prevent placing an empty order
    if (cartItems.length === 0) {
      alert("Your cart is empty!");
      return;
    }

    // Calculate the final total price on the frontend
    const totalPrice = cartItems.reduce(
      (total, item) => total + item.price * item.quantity,
      0
    );

    // Format the data for the backend
    const orderData = {
      // We'll hardcode a customer_id for now. Later, this would come from user login.
      customer_id: 1, 
      total_price: totalPrice,
      items: cartItems.map(item => ({
        item_id: item.item_id,
        quantity: item.quantity,
        price: item.price
      }))
    };

    try {
      const response = await fetch('http://localhost:3000/api/orders', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(orderData),
      });

      if (!response.ok) {
        // If the server response is not OK, throw an error
        const errorData = await response.json();
        throw new Error(errorData.message || 'Failed to place order.');
      }

      // If the order is placed successfully
      alert('Order placed successfully!');
      setCartItems([]); // Clear the cart

    } catch (err) {
      console.error('Error placing order:', err);
      alert(`Error: ${err.message}`);
    }
  };

  return (
    <div className="bg-gray-100 min-h-screen">
      <HeaderBar />
      <main className="container mx-auto px-4 py-8">
        <div className="grid grid-cols-12 gap-8">
          {/* --- THIS IS THE LINE THAT WAS FIXED --- */}
          <div className="col-span-12 lg:col-span-8">
            <PromoBanner />
            <CategoryTabs />
            {error && <p className="text-red-500">Error: {error}</p>}
            <FoodGrid items={items} onAddToCart={handleAddToCart} />
          </div>

          <div className="col-span-12 lg:col-span-4">
           <CartPanel 
            cartItems={cartItems} 
            onUpdateQuantity={handleUpdateQuantity} 
            onPlaceOrder={handlePlaceOrder} 
/>
          </div>
        </div>
      </main>
    </div>
  );
}

export default MenuPage;
import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../../context/AuthContext';
import HeaderBar from './components/HeaderBar';
import PromoBanner from './components/PromoBanner';
import CategoryTabs from './components/CategoryTabs';
import FoodGrid from './components/FoodGrid';
import CartPanel from './components/CartPanel';
import ImageModal from './components/ImageModal';
import PaymentModal from './components/PaymentModal';
import ReceiptModal from './components/ReceiptModal';
import NotificationPanel from './components/NotificationPanel';
import toast from 'react-hot-toast';
import apiClient from '../../utils/apiClient';
import './CustomerTheme.css';

function MenuPage() {
  const [items, setItems] = useState([]);
  const [categories, setCategories] = useState([]);
  const [error, setError] = useState(null);
  const [cartItems, setCartItems] = useState([]);
  const [selectedCategory, setSelectedCategory] = useState(0);
  const [searchTerm, setSearchTerm] = useState('');
  const [isCartOpen, setIsCartOpen] = useState(false);
  const [selectedImage, setSelectedImage] = useState(null);
  const [orderType, setOrderType] = useState('Dine-in');
  const [deliveryLocation, setDeliveryLocation] = useState('');
  
  // ✅ NEW: State for Auto-Detected Room
  const [activeRoom, setActiveRoom] = useState(null);
  const [isFetchingRoom, setIsFetchingRoom] = useState(false);

  const [isPlacingOrder, setIsPlacingOrder] = useState(false);
  const [sortOption, setSortOption] = useState('a-z');

  const [isPaymentModalOpen, setIsPaymentModalOpen] = useState(false);
  const [isReceiptModalOpen, setIsReceiptModalOpen] = useState(false);
  const [pendingOrderTotal, setPendingOrderTotal] = useState(0); 
  const [receiptDetails, setReceiptDetails] = useState(null);
  
  const [notifications, setNotifications] = useState([]);
  const [isNotificationPanelOpen, setIsNotificationPanelOpen] = useState(false);
  const [unreadNotificationCount, setUnreadNotificationCount] = useState(0);

  const { user, token, isAuthenticated } = useAuth();
  const navigate = useNavigate();

  const cartCount = cartItems.reduce((total, item) => total + item.quantity, 0);

  const handleUpdateItemInstruction = (itemId, newInstruction) => {
    setCartItems(prevItems =>
        prevItems.map(item =>
        item.item_id === itemId ? { ...item, instructions: newInstruction } : item
        )
    );
  };

  // ✅ LOGIC: Auto-fetch Room when "Room Dining" is selected
  useEffect(() => { 
      setDeliveryLocation(''); 
      
      if (orderType === 'Room Dining') {
          const fetchMyRoom = async () => {
              setIsFetchingRoom(true);
              try {
                  const res = await apiClient('/rooms/my-active-room');
                  if (res.ok) {
                      const data = await res.json();
                      setActiveRoom(data.room); // { room_id, room_num, room_name }
                      setDeliveryLocation(data.room.room_id); // Auto-set location ID
                      toast.success(`Welcome! We found your room: ${data.room.room_num}`);
                  } else {
                      // If 404 (No active booking), reset
                      setActiveRoom(null);
                      toast.error("No active room reservation found.");
                  }
              } catch (err) {
                  console.error("Room fetch error:", err);
              } finally {
                  setIsFetchingRoom(false);
              }
          };
          fetchMyRoom();
      } else {
          setActiveRoom(null); // Reset if switching back to Dine-in
      }

  }, [orderType]);

  useEffect(() => {
    const fetchItems = async () => {
      try {
        const [itemsResponse, categoriesResponse] = await Promise.all([
          apiClient('/items'),
          apiClient('/categories')
        ]);

        if (!itemsResponse.ok) throw new Error('Failed to fetch menu items.');
        if (!categoriesResponse.ok) throw new Error('Failed to fetch categories.');

        const itemsData = await itemsResponse.json();
        const categoriesData = await categoriesResponse.json();
        
        setItems(itemsData);
        setCategories(categoriesData);
        toast.success('Menu loaded successfully.');
      } catch (err) {
        setError(err.message);
        console.error("Error fetching data:", err);
          toast.error('Failed to load menu or categories.');
      }
    };
    fetchItems();
  }, []);

  useEffect(() => {
    if (!isAuthenticated) return;

    const POLLING_INTERVAL = 10000; 

    const fetchNotifications = async () => {
      if (isNotificationPanelOpen)
        return;

      try {
        const res = await apiClient('/notifications');
        if (!res.ok) {
          console.error('Failed to poll for notifications');
          return;
        }
        
        const data = await res.json(); 
        setNotifications(data.notifications || []);
        setUnreadNotificationCount(data.unreadCount || 0);

      } catch (err) {
        if (err.message !== 'Session expired') {
          console.error('Polling error:', err);
        }
      }
    };

    fetchNotifications();
    const intervalId = setInterval(fetchNotifications, POLLING_INTERVAL);
    return () => clearInterval(intervalId);

  }, [isAuthenticated, isNotificationPanelOpen]); 

  const handleSearchChange = (e) => setSearchTerm(e.target.value);
  const toggleCart = () => setIsCartOpen(!isCartOpen);
  
  const toggleNotificationPanel = () => {
    const panelWillBeOpen = !isNotificationPanelOpen;
    setIsNotificationPanelOpen(panelWillBeOpen);

    if (panelWillBeOpen) {
      setUnreadNotificationCount(0);
      apiClient('/notifications/mark-read', { method: 'PUT' }).catch(err => console.error(err));
    }
  };

  const handleSelectCategory = (category) => setSelectedCategory(category);
  
  const handleAddToCart = (clickedItem) => {
    setCartItems(prevItems => {
      const isItemInCart = prevItems.find(item => item.item_id === clickedItem.item_id);
      if (isItemInCart) {
         toast('Increased item quantity.', { icon: '➕' });
        return prevItems.map(item =>
          item.item_id === clickedItem.item_id
            ? { ...item, quantity: item.quantity + 1 }
            : item
        );
      }
        toast.success('Added to cart!');
      return [...prevItems, { ...clickedItem, quantity: 1 }];
    });
  };

  const handleRemoveItem = (itemIdToRemove) => {
    setCartItems(prevItems => prevItems.filter(item => item.item_id !== itemIdToRemove));
     toast('Item removed from cart.', { icon: '🗑️' });
  };

  const handleUpdateQuantity = (itemId, newQuantity) => {
    if (newQuantity <= 0) {
      handleRemoveItem(itemId);
        toast('Item removed (0 quantity).', { icon: '⚠️' });
    } else {
      setCartItems(prevItems =>
        prevItems.map(item =>
          item.item_id === itemId ? { ...item, quantity: newQuantity } : item
        )
      );
       toast('Quantity updated.', { icon: '🔄' });
    }
  };

  const handleProceedToPayment = (data) => {
    if (!isAuthenticated) {
      toast.error("You must be logged in to place an order.");
      navigate('/login');
      return;
    }
    
    // Auto-room Logic: If activeRoom exists, prioritize it
    if (activeRoom) {
         setDeliveryLocation(activeRoom.room_id);
    } else {
        // Fallback for Dine-in
        if (data?.table_id) setDeliveryLocation(data.table_id);
        else if (data?.room_id) setDeliveryLocation(data.room_id);
    }
    
    const subtotal = cartItems.reduce((sum, item) => sum + (item.price * item.quantity), 0);
    const serviceCharge = subtotal * 0.10;
    const vatAmount = (subtotal + serviceCharge) * 0.12;
    const grandTotal = subtotal + serviceCharge + vatAmount;

    setPendingOrderTotal(grandTotal); 
    setIsPaymentModalOpen(true);
    setIsCartOpen(false);
  };

  const handleConfirmPayment = async (paymentInfo) => {
    setIsPaymentModalOpen(false);
    setTimeout(() => {
      setIsPlacingOrder(true);
      toast.loading('Creating checkout...');
    }, 0);

    let tableIdToSend = null;
    let roomIdToSend = null;

    if (orderType === 'Dine-in') {
        tableIdToSend = deliveryLocation; 
    } else if (orderType === 'Room Dining') {
        roomIdToSend = deliveryLocation; // This is now set automatically from activeRoom
    }

    const checkoutData = {
      cart_items: cartItems.map(item => ({
        item_id: item.item_id,
        quantity: item.quantity,
        instructions: item.instructions || '' 
      })),
      
      table_id: tableIdToSend, 
      room_id: roomIdToSend,

      special_instructions: cartItems
        .filter(item => item.instructions)
        .map(item => `${item.item_name}: ${item.instructions}`)
        .join('; ') || null
    };

    try {
      toast.dismiss();
      toast.loading('Creating PayMongo checkout...');

      const paymentResponse = await apiClient('/payments/checkout', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(checkoutData)
      });

      const paymentResult = await paymentResponse.json();
      
      if (!paymentResponse.ok) {
        throw new Error(paymentResult.message || 'Failed to create checkout.');
      }

      toast.dismiss();
      toast.success('Redirecting to PayMongo...');

      if (paymentResult.checkout_url) {
        setCartItems([]);
        window.location.href = paymentResult.checkout_url;
      } else {
        throw new Error("Missing checkout URL from PayMongo.");
      }

    } catch (err) {
      console.error('Checkout Error:', err);
      toast.dismiss();
      if (err.message !== 'Session expired') {
        toast.error(`Error: ${err.message}`);
      }
      setIsPlacingOrder(false);
    }
  };

  const handleCloseReceipt = () => {
    setIsReceiptModalOpen(false);
    setReceiptDetails(null);
  };

  const handleDeleteNotification = async (notificationId) => {
    try {
      const res = await apiClient(`/notifications/${notificationId}`, { method: 'DELETE' });
      if (!res.ok) throw new Error('Failed to delete notification');
      setNotifications(prev => prev.filter(n => n.notification_id !== notificationId));
      toast.success('Notification cleared.');
    } catch (err) {
      if (err.message !== 'Session expired') toast.error(err.message);
    }
  };

  const handleClearAllNotifications = async () => {
    if (!window.confirm('Are you sure you want to clear all notifications?')) return;
    try {
      const res = await apiClient('/notifications/clear-all', { method: 'DELETE' });
      if (!res.ok) throw new Error('Failed to clear notifications');
      setNotifications([]);
      setUnreadNotificationCount(0); 
      toast.success('All notifications cleared.');
    } catch (err) {
      if (err.message !== 'Session expired') toast.error(err.message);
    }
  };

  const getProcessedItems = () => {
    let result = items
      .filter(item => selectedCategory === 0 || item.category_id === selectedCategory)
      .filter(item => item.item_name.toLowerCase().includes(searchTerm.toLowerCase()));

    switch (sortOption) {
      case 'a-z': result.sort((a, b) => a.item_name.localeCompare(b.item_name)); break;
      case 'z-a': result.sort((a, b) => b.item_name.localeCompare(a.item_name)); break;
      case 'price-low': result.sort((a, b) => parseFloat(a.price) - parseFloat(b.price)); break;
      case 'price-high': result.sort((a, b) => parseFloat(b.price) - parseFloat(a.price)); break;
      case 'rating-high': result.sort((a, b) => {
            const ratingA = parseFloat(a.average_rating || 0);
            const ratingB = parseFloat(b.average_rating || 0);
            if (ratingB !== ratingA) return ratingB - ratingA;
            return (b.total_reviews || 0) - (a.total_reviews || 0);
        });
        break;
      case 'recent': result.sort((a, b) => b.item_id - a.item_id); break;
      default: break;
    }
    return result;
  };

  const finalItems = getProcessedItems();

  return (
    <div className="customer-page-container">
      <HeaderBar
        cartCount={cartCount}
        onCartToggle={toggleCart}
        searchTerm={searchTerm}
        onSearchChange={handleSearchChange}
        notificationCount={unreadNotificationCount}
        onNotificationToggle={toggleNotificationPanel}
      />

      <main className="container mx-auto px-4">
        <PromoBanner />
        <CategoryTabs
          categories={categories}
          selectedCategory={selectedCategory}
          onSelectCategory={handleSelectCategory}
          sortOption={sortOption}
          onSortChange={setSortOption}
        />
        <FoodGrid
          items={finalItems}
          onAddToCart={handleAddToCart}
          onImageClick={(imageUrl) => setSelectedImage(imageUrl)}
        />
      </main>

      <CartPanel
        cartItems={cartItems}
        onUpdateQuantity={handleUpdateQuantity}
        onUpdateItemInstruction={handleUpdateItemInstruction}
        onPlaceOrder={handleProceedToPayment}
        isOpen={isCartOpen}
        onClose={toggleCart}
        orderType={orderType}
        setOrderType={setOrderType}
        onRemoveItem={handleRemoveItem}
        deliveryLocation={deliveryLocation}
        setDeliveryLocation={setDeliveryLocation}
        isPlacingOrder={isPlacingOrder}
        // ✅ NEW PROPS for Room
        activeRoom={activeRoom}
        isFetchingRoom={isFetchingRoom}
      />

      <PaymentModal
        isOpen={isPaymentModalOpen}
        onClose={() => setIsPaymentModalOpen(false)}
        totalAmount={pendingOrderTotal} 
        onConfirmPayment={handleConfirmPayment}
        deliveryLocation={deliveryLocation}
        orderType={orderType}
        cartItems={cartItems}
      />

      <ReceiptModal
        isOpen={isReceiptModalOpen}
        onClose={handleCloseReceipt}
        orderDetails={receiptDetails}
      />

      <NotificationPanel
        isOpen={isNotificationPanelOpen}
        onClose={toggleNotificationPanel}
        notifications={notifications}
        onDeleteOne={handleDeleteNotification}
        onClearAll={handleClearAllNotifications}
      />

      <ImageModal imageUrl={selectedImage} onClose={() => setSelectedImage(null)} />
    </div>
  );
}

export default MenuPage;
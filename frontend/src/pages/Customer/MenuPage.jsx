import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../../context/AuthContext';
import { useCart } from '../../context/CartContext';
import HeaderBar from './components/HeaderBar';
import PromoBanner from './components/PromoBanner';
import CategoryTabs from './components/CategoryTabs';
import FoodGrid from './components/FoodGrid';
import CartPanel from './components/CartPanel';
import ImageModal from './components/ImageModal';
import NotificationPanel from './components/NotificationPanel';
import toast from 'react-hot-toast';
import apiClient from '../../utils/apiClient';
import './CustomerTheme.css';

function MenuPage() {
  // --- Data State ---
  const [items, setItems] = useState([]);
  const [categories, setCategories] = useState([]);
  const [notifications, setNotifications] = useState([]);
  
  // --- UI State ---
  const [selectedCategory, setSelectedCategory] = useState(0);
  const [searchTerm, setSearchTerm] = useState('');
  const [sortOption, setSortOption] = useState('a-z');
  const [isCartOpen, setIsCartOpen] = useState(false);
  const [selectedImage, setSelectedImage] = useState(null);
  const [isNotificationPanelOpen, setIsNotificationPanelOpen] = useState(false);
  const [unreadNotificationCount, setUnreadNotificationCount] = useState(0);

  // --- Hooks ---
  const { isAuthenticated } = useAuth();
  const { addToCart, cartCount } = useCart(); // ✅ Get Cart Actions directly
  const navigate = useNavigate();

  // 1. Fetch Menu Data
  useEffect(() => {
    const fetchItems = async () => {
      try {
        const [itemsResponse, categoriesResponse] = await Promise.all([
          apiClient('/items'),
          apiClient('/categories')
        ]);

        if (!itemsResponse.ok) throw new Error('Failed to fetch menu items.');
        if (!categoriesResponse.ok) throw new Error('Failed to fetch categories.');

        setItems(await itemsResponse.json());
        setCategories(await categoriesResponse.json());
      } catch (err) {
        console.error("Error fetching data:", err);
        toast.error('Failed to load menu.');
      }
    };
    fetchItems();
  }, []);

  // 2. Poll Notifications (Only if logged in)
  useEffect(() => {
    if (!isAuthenticated) return;

    const fetchNotifications = async () => {
      if (isNotificationPanelOpen) return;
      try {
        const res = await apiClient('/notifications');
        if (res.ok) {
           const data = await res.json(); 
           setNotifications(data.notifications || []);
           setUnreadNotificationCount(data.unreadCount || 0);
        }
      } catch (err) {
        // Silent fail for polling
      }
    };

    fetchNotifications();
    const intervalId = setInterval(fetchNotifications, 10000);
    return () => clearInterval(intervalId);
  }, [isAuthenticated, isNotificationPanelOpen]); 

  // --- Handlers ---
  const handleSearchChange = (e) => setSearchTerm(e.target.value);
  const toggleCart = () => setIsCartOpen(!isCartOpen);
  const handleSelectCategory = (category) => setSelectedCategory(category);
  
  const toggleNotificationPanel = () => {
    const panelWillBeOpen = !isNotificationPanelOpen;
    setIsNotificationPanelOpen(panelWillBeOpen);
    if (panelWillBeOpen) {
      setUnreadNotificationCount(0);
      apiClient('/notifications/mark-read', { method: 'PUT' }).catch(console.error);
    }
  };

  const handleDeleteNotification = async (notificationId) => {
    try {
      await apiClient(`/notifications/${notificationId}`, { method: 'DELETE' });
      setNotifications(prev => prev.filter(n => n.notification_id !== notificationId));
      toast.success('Notification cleared.');
    } catch (err) { toast.error('Failed to delete.'); }
  };

  const handleClearAllNotifications = async () => {
    if (!window.confirm('Clear all notifications?')) return;
    try {
      await apiClient('/notifications/clear-all', { method: 'DELETE' });
      setNotifications([]);
      setUnreadNotificationCount(0); 
      toast.success('All cleared.');
    } catch (err) { toast.error('Failed to clear.'); }
  };

  // --- Filtering & Sorting ---
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

  return (
    <div className="customer-page-container">
      {/* 1. Header */}
      <HeaderBar
        cartCount={cartCount} // ✅ From Context
        onCartToggle={toggleCart}
        searchTerm={searchTerm}
        onSearchChange={handleSearchChange}
        notificationCount={unreadNotificationCount}
        onNotificationToggle={toggleNotificationPanel}
      />

      <main className="container mx-auto px-4">
        {/* 2. Banner & Tabs */}
        <PromoBanner />
        <CategoryTabs
          categories={categories}
          selectedCategory={selectedCategory}
          onSelectCategory={handleSelectCategory}
          sortOption={sortOption}
          onSortChange={setSortOption}
        />
        
        {/* 3. Food Grid */}
        <FoodGrid
          items={getProcessedItems()}
          onAddToCart={(item) => {
              addToCart(item); // ✅ From Context
              toast.success('Added to cart!');
          }}
          onImageClick={(imageUrl) => setSelectedImage(imageUrl)}
        />
      </main>

      {/* 4. Panels & Modals */}
      
      {/* ✅ CartPanel is now Autonomous */}
      <CartPanel 
        isOpen={isCartOpen} 
        onClose={toggleCart} 
      />

      <NotificationPanel
        isOpen={isNotificationPanelOpen}
        onClose={toggleNotificationPanel}
        notifications={notifications}
        onDeleteOne={handleDeleteNotification}
        onClearAll={handleClearAllNotifications}
      />

      <ImageModal 
        imageUrl={selectedImage} 
        onClose={() => setSelectedImage(null)} 
      />
    </div>
  );
}

export default MenuPage;
import React from 'react';
import { useState, useEffect } from 'react';
import HeaderBar from '../../components/HeaderBar';
import PromoBanner from '../../components/PromoBanner';
import CategoryTabs from '../../components/CategoryTabs';
import FoodGrid from '../../components/FoodGrid';
import CartPanel from '../../components/CartPanel';
import ImageModal from '../../components/ImageModal';
import PaymentModal from '../../components/PaymentModal'; // --- ADD Import ---
import ReceiptModal from '../../components/ReceiptModal'; // --- ADD Import ---
import toast from 'react-hot-toast';

const primaryColor = { backgroundColor: '#0B3D2E' };

function MenuPage() {
  const [items, setItems] = useState([]);
  const [error, setError] = useState(null);
  const [cartItems, setCartItems] = useState([]);
  const [selectedCategory, setSelectedCategory] = useState('All');
  const [searchTerm, setSearchTerm] = useState('');
  const [isCartOpen, setIsCartOpen] = useState(false);
  const [selectedImage, setSelectedImage] = useState(null);
  const [orderType, setOrderType] = useState('Dine-in');
  const [instructions, setInstructions] = useState('');
  const [deliveryLocation, setDeliveryLocation] = useState('');
  const [isPlacingOrder, setIsPlacingOrder] = useState(false);

  // --- ADD Modal States ---
  const [isPaymentModalOpen, setIsPaymentModalOpen] = useState(false);
  const [isReceiptModalOpen, setIsReceiptModalOpen] = useState(false);
  const [pendingOrderTotal, setPendingOrderTotal] = useState(0); // Store total for payment modal
  const [receiptDetails, setReceiptDetails] = useState(null); // Store details for receipt

  const cartCount = cartItems.reduce((total, item) => total + item.quantity, 0);
  const categories = ['All', ...new Set(items.map(item => item.category))];

  useEffect(() => { setDeliveryLocation(''); }, [orderType]);
  useEffect(() => {
    const fetchItems = async () => { /* ... (fetch items logic remains the same) ... */
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

  const handleSearchChange = (event) => { setSearchTerm(event.target.value); };
  const toggleCart = () => { setIsCartOpen(!isCartOpen); };
  const handleSelectCategory = (category) => { setSelectedCategory(category); };
  const handleAddToCart = (clickedItem) => { /* ... (logic remains the same) ... */
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
  const handleRemoveItem = (itemIdToRemove) => { /* ... (logic remains the same) ... */
    setCartItems(prevItems => prevItems.filter(item => item.item_id !== itemIdToRemove));
   };
  const handleUpdateQuantity = (itemId, newQuantity) => { /* ... (logic remains the same) ... */
      if (newQuantity <= 0) {
      handleRemoveItem(itemId);
    } else {
      setCartItems((prevItems) =>
        prevItems.map((item) =>
          item.item_id === itemId ? { ...item, quantity: newQuantity } : item
        )
      );
    }
   };

  // --- MODIFIED: This function now just opens the Payment Modal ---
  const handleProceedToPayment = (grandTotal) => {
    if (cartItems.length === 0 || !deliveryLocation) {
      toast.error("Please add items and enter table/room number first.");
      return;
    }
    setPendingOrderTotal(grandTotal); // Store the total
    setIsPaymentModalOpen(true);     // Open payment modal
    setIsCartOpen(false);            // Close cart panel
  };

  // --- NEW: Function called by PaymentModal on confirm ---
  const handleConfirmPayment = async (totalAmount, paymentInfo) => {
    setIsPaymentModalOpen(false); // Close payment modal
    setIsPlacingOrder(true);      // Set loading state
    toast.loading('Placing your order...');

    const orderData = {
      customer_id: 1, // Hardcoded customer_id - Replace with actual logged-in user ID later
      total_price: totalAmount, // Use the amount confirmed in the modal
      order_type: orderType,
      instructions: instructions,
      delivery_location: deliveryLocation,
      items: cartItems.map(item => ({
        item_id: item.item_id,
        quantity: item.quantity,
        price: item.price
      }))
    };

    try {
      // Step 1: Create Order
      const orderResponse = await fetch('http://localhost:3000/api/orders', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(orderData),
      });
      const orderResult = await orderResponse.json();
      if (!orderResponse.ok) throw new Error(orderResult.message || 'Failed to create order.');

      const newOrderId = orderResult.order_id;
      const orderTotal = orderResult.total_amount; // Use amount from backend response
      const orderDate = orderResult.order_date || new Date().toISOString(); // Get date from response or use current
      toast.dismiss();
      toast.loading('Simulating payment confirmation...');

      // Step 2: Simulate Payment
      const paymentResponse = await fetch(`http://localhost:3000/api/payments/${newOrderId}/simulate`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ total_amount: orderTotal }),
      });
      const paymentResult = await paymentResponse.json();
      if (!paymentResponse.ok) throw new Error(paymentResult.message || 'Failed to simulate payment.');

      // Success! Prepare data for receipt and show it
      setReceiptDetails({
        order_id: newOrderId,
        order_date: orderDate,
        order_type: orderType,
        delivery_location: deliveryLocation,
        items: [...cartItems], // Pass a copy of the cart items
        total_amount: orderTotal,
        payment_method: paymentInfo.selectedPaymentMethod // Get method from PaymentModal
      });
      setIsReceiptModalOpen(true); // Open Receipt Modal

      // Clear cart AFTER preparing receipt details
      setCartItems([]);
      setInstructions('');
      setDeliveryLocation('');
      // Keep cart panel closed (already closed when opening payment modal)

      toast.dismiss();
      // Toast success is now handled by Receipt Modal opening

    } catch (err) {
      console.error('Order/Payment Error:', err);
      toast.dismiss();
      toast.error(`Error: ${err.message}`);
    } finally {
      setIsPlacingOrder(false); // Unset loading state regardless of outcome
    }
  };

  // --- NEW: Function to close Receipt Modal ---
  const handleCloseReceipt = () => {
    setIsReceiptModalOpen(false);
    setReceiptDetails(null); // Clear receipt details
  };

  // Filter items (Definition must be before return)
   const filteredItems = items
    .filter(item => selectedCategory === 'All' || item.category === selectedCategory)
    .filter(item => item.item_name.toLowerCase().includes(searchTerm.toLowerCase()));


  return (
    <div className="bg-gray-100 min-h-screen" style={primaryColor}>
      <HeaderBar
        cartCount={cartCount}
        onCartToggle={toggleCart}
        searchTerm={searchTerm}
        onSearchChange={handleSearchChange}
      />
      <main className="container mx-auto px-4 py-8">
        <div>
          <PromoBanner />
          <CategoryTabs
            categories={categories}
            selectedCategory={selectedCategory}
            onSelectCategory={handleSelectCategory}
          />
          <FoodGrid
            items={filteredItems}
            onAddToCart={handleAddToCart}
            onImageClick={(imageUrl) => setSelectedImage(imageUrl)}
          />
        </div>
      </main>

      <CartPanel
        cartItems={cartItems}
        onUpdateQuantity={handleUpdateQuantity}
        // --- MODIFIED: Pass handleProceedToPayment instead of handlePlaceOrder ---
        onPlaceOrder={handleProceedToPayment}
        isOpen={isCartOpen}
        onClose={toggleCart}
        orderType={orderType}
        setOrderType={setOrderType}
        instructions={instructions}
        setInstructions={setInstructions}
        onRemoveItem={handleRemoveItem}
        deliveryLocation={deliveryLocation}
        setDeliveryLocation={setDeliveryLocation}
        isPlacingOrder={isPlacingOrder} // Still pass loading state (useful if needed later)
      />

      {/* --- ADD: Render the Modals --- */}
      <PaymentModal
        isOpen={isPaymentModalOpen}
        onClose={() => setIsPaymentModalOpen(false)} // Simple close action
        totalAmount={pendingOrderTotal}
        onConfirmPayment={handleConfirmPayment} // Pass the handler
        deliveryLocation={deliveryLocation}
        orderType={orderType}
        cartItems={cartItems} // Pass cart items for billing summary
      />

      <ReceiptModal
        isOpen={isReceiptModalOpen}
        onClose={handleCloseReceipt} // Use the new handler to clear details
        orderDetails={receiptDetails} // Pass the stored details
      />
      {/* --- END: Render the Modals --- */}


      <ImageModal imageUrl={selectedImage} onClose={() => setSelectedImage(null)} />
    </div>
  );
}

export default MenuPage;
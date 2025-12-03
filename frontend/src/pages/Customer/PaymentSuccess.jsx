import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { CheckCircle, Loader2 } from "lucide-react"; 
import ReceiptModal from "../../pages/Customer/components/ReceiptModal"; // Double check this path!
import toast from "react-hot-toast";
import apiClient from '../../utils/apiClient'; 

const PaymentSuccess = () => {
  const navigate = useNavigate();
  const [orderDetails, setOrderDetails] = useState(null);
  const [isOpen, setIsOpen] = useState(false);
  const [status, setStatus] = useState("Verifying payment...");
  const [retryCount, setRetryCount] = useState(0);

  useEffect(() => {
    // We clear the cart because the payment was successful
    localStorage.removeItem("cartItems");

    const fetchLatestOrder = async () => {
      try {
        console.log("Fetching orders..."); 

        // 1. Call the API
        const response = await apiClient('/orders/my-orders'); 
        
        // 2. Check if the response is OK
        if (!response.ok) {
            const errorText = await response.text();
            console.error("API Error Response:", errorText); 
            throw new Error(`Server returned ${response.status}: ${errorText}`);
        }
        
        // 3. Parse JSON
        const orders = await response.json();
        console.log("Orders received:", orders); 

        // 4. Check if we found any orders
        if (orders && orders.length > 0) {
          const latest = orders[0]; 

          // -------------------------------------------------
          // ✅ FIX: No time check, no crashing variables.
          // This will show the receipt immediately.
          // -------------------------------------------------
          setOrderDetails(latest);
          setIsOpen(true);
          setStatus("Payment Confirmed!");
          return; // Stop the function here, we are done!
        }

        // Retry Logic (Only runs if NO orders were found in the array)
        if (retryCount < 5) {
          console.log(`Order not found yet. Retrying... (${retryCount + 1}/5)`);
          setTimeout(() => {
            setRetryCount(prev => prev + 1);
          }, 2000); 
        } else {
          setStatus("Order processing is taking longer than usual.");
          toast.error("Payment received. Check 'My Orders'.");
          setTimeout(() => navigate('/'), 4000); 
        }

      } catch (err) {
        console.error("Fetch Error:", err);
        // Retry on network errors
        if (retryCount < 5) {
           setTimeout(() => setRetryCount(prev => prev + 1), 2000);
        }
      }
    };

    fetchLatestOrder();
  }, [retryCount, navigate]);

  const handleClose = () => {
    setIsOpen(false);
    navigate("/"); // Return to menu after closing
  };

  return (
    <div className="min-h-screen flex flex-col justify-center items-center bg-green-50 text-center p-6">
      
      {/* Dynamic Icon based on state */}
      {!isOpen ? (
        <Loader2 className="w-20 h-20 text-green-600 mb-4 animate-spin" />
      ) : (
        <CheckCircle className="w-20 h-20 text-green-600 mb-4 animate-bounce" />
      )}

      <h1 className="text-3xl font-bold text-green-700 mb-2">
        {isOpen ? "Payment Successful 🎉" : "Processing..."}
      </h1>
      
      <p className="text-gray-600 mb-6">{status}</p>

      {/* Show the receipt modal */}
      {isOpen && orderDetails && (
        <ReceiptModal
          isOpen={isOpen}
          onClose={handleClose}
          orderDetails={orderDetails}
        />
      )}
    </div>
  );
};

export default PaymentSuccess;
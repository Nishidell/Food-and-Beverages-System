import React from "react";
import { useNavigate } from "react-router-dom";
import { XCircle } from "lucide-react";

const PaymentCancel = () => {
  const navigate = useNavigate();

  const handleRetryPayment = () => {
    navigate("/");
  };

  return (
    <div className="min-h-screen flex flex-col justify-center items-center bg-red-50 text-center p-6">
      <XCircle className="w-20 h-20 text-red-600 mb-4" />
      <h1 className="text-3xl font-bold text-red-700 mb-2">
        Payment Cancelled ❌
      </h1>
      <p className="text-gray-700 max-w-md">
        It looks like your payment was cancelled or did not go through.
        You can try again anytime from your menu page.
      </p>

      <button
        onClick={handleRetryPayment}
        className="mt-6 px-6 py-3 bg-red-600 text-white font-semibold rounded-lg hover:bg-red-700 transition"
      >
        Return to Menu
      </button>
    </div>
  );
};

export default PaymentCancel;

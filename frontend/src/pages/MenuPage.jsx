import React from 'react';
import HeaderBar from '../components/HeaderBar';
import PromoBanner from '../components/PromoBanner';
import CategoryTabs from '../components/CategoryTabs';
import FoodGrid from '../components/FoodGrid';
import CartPanel from '../components/CartPanel';

function MenuPage() {
  // All the logic for fetching data and managing the cart will go here later
  return (
    <div className="bg-gray-100 min-h-screen">
      <HeaderBar />
      <main className="container mx-auto px-4 py-8">
        <div className="grid grid-cols-12 gap-8">
          {/* Main Content */}
          <div className="col-span-12 lg:col-span-8">
            <PromoBanner />
            <CategoryTabs />
            <FoodGrid />
          </div>

          {/* Cart Panel */}
          <div className="col-span-12 lg:col-span-4">
            <CartPanel />
          </div>
        </div>
      </main>
    </div>
  );
}

export default MenuPage;
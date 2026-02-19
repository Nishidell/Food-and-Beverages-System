import React from 'react';

const MenuSkeleton = () => {
  return (
    <div className="bg-[#FFF8E7] rounded-xl overflow-hidden shadow-lg border border-yellow-600/20 animate-pulse flex flex-col h-full">
      
      {/* 1. Image Placeholder - Slightly darker green (20% opacity) */}
      <div className="w-full h-48 bg-[#022c22]/20"></div>

      {/* 2. Content Container */}
      <div className="p-4 flex flex-col flex-1">
        
        {/* Title Bar - Green (15% opacity) */}
        <div className="h-6 bg-[#022c22]/15 rounded w-3/4 mb-2"></div>
        
        {/* Rating Star Placeholder - Gold tint (to hint at stars) */}
        <div className="h-4 bg-yellow-600/20 rounded w-1/4 mb-4"></div>
        
        {/* Description Lines - Green (10% opacity) */}
        <div className="h-3 bg-[#022c22]/10 rounded w-full mb-2"></div>
        <div className="h-3 bg-[#022c22]/10 rounded w-5/6 mb-4"></div>

        {/* Spacer */}
        <div className="mt-auto"></div>

        {/* Price and Button Row */}
        <div className="flex justify-between items-center mt-4">
          {/* Price Placeholder */}
          <div className="h-6 bg-[#022c22]/15 rounded w-1/3"></div>
          
          {/* Add Button Placeholder - Darker Green to match real button */}
          <div className="h-10 bg-[#022c22]/30 rounded w-24"></div>
        </div>
      </div>
    </div>
  );
};

export default MenuSkeleton;
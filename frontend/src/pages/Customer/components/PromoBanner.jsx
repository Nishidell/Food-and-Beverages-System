import React from "react";
import { motion } from "framer-motion"; // 1. Import 'motion'

// 2. Define the text and styles
const promoText = "🎁 Active Promos: Seafood Week 15% OFF | Happy Hour Wings 20% OFF | Weekend Paella Special 10% OFF | Loyalty Points: 1250 ✨";

const bannerContainerStyle = {
  backgroundColor: '#F6B24B',
  color: '#053a34',
  fontSize: '0.875rem', // 14px
  padding: '4px 0',       // Add padding top/bottom
  overflow: 'hidden',     // This is the "mask" that hides the text
  display: 'flex',        // Use flex for the inner container
  whiteSpace: 'nowrap',   // Prevent text from ever wrapping
};

const scrollingContainerStyle = {
  display: 'flex',        // This container holds the text copies
};

const textSpanStyle = {
  padding: '0 2rem',      // Add spacing between the end and start of the text
};

export default function PromoBanner() {
  return (
    <div style={bannerContainerStyle}>
      {/* 3. This is the 'motion.div' that will scroll */}
      <motion.div
        style={scrollingContainerStyle}
        animate={{ 
          x: ['0%', '-100%']  // Animate from its start (0%) to its end (-100%)
        }}
        transition={{
          x: {
            repeat: Infinity,     // Loop forever
            duration: 30,         // 30 seconds for one full scroll
            ease: 'linear',       // Constant speed, no easing
          },
        }}
      >
        {/* 4. We render the text TWICE for a seamless loop */}
        <span style={textSpanStyle}>
          {promoText}
        </span>
        <span style={textSpanStyle}>
          {promoText}
        </span>
      </motion.div>
    </div>
  );
}
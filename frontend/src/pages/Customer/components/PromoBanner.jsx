import React, { useState, useEffect } from "react";
import { motion } from "framer-motion";
import apiClient from "../../../utils/apiClient"; 

const bannerContainerStyle = {
  backgroundColor: '#F6B24B',
  color: '#053a34',
  fontSize: '0.875rem', 
  padding: '4px 0',       
  overflow: 'hidden',     
  display: 'flex',        
  whiteSpace: 'nowrap',   
};

const scrollingContainerStyle = {
  display: 'flex',        
};

const textSpanStyle = {
  padding: '0 2rem',      
  fontWeight: 'bold',
};

export default function PromoBanner() {
  const [announcement, setAnnouncement] = useState('');
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchAnnouncement = async () => {
      try {
        const res = await apiClient('/announcement');
        if (res.ok) {
          const data = await res.json();
          setAnnouncement(data.message || '');
        }
      } catch (error) {
        console.error("Failed to fetch announcement", error);
      } finally {
        setLoading(false);
      }
    };

    fetchAnnouncement();
  }, []);

  // If loading or no message, do not render the banner
  if (loading || !announcement) return null;

  return (
    <div style={bannerContainerStyle}>
      <motion.div
        style={scrollingContainerStyle}
        animate={{ 
          x: ['0%', '-100%']  
        }}
        transition={{
          x: {
            repeat: Infinity,     
            duration: 30,         
            ease: 'linear',       
          },
        }}
      >
        {/* Render text twice for seamless loop */}
        <span style={textSpanStyle}>
          {announcement}
        </span>
        <span style={textSpanStyle}>
          {announcement}
        </span>
      </motion.div>
    </div>
  );
}
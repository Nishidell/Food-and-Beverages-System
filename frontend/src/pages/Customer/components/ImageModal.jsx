

import React from 'react';
import { X } from 'lucide-react';

const ImageModal = ({ imageUrl, onClose }) => {
  if (!imageUrl) {
    return null;
  }

  return (
    <div className="fixed inset-0 bg-black/80 z-50 flex justify-center items-center" onClick={onClose}>
      <div className="relative">
        <button onClick={onClose} className="absolute -top-4 -right-4 bg-white rounded-full p-1 text-gray-800 hover:bg-gray-200">
          <X size={28} />
        </button>
        <img src={imageUrl} alt="Enlarged view" className="max-w-screen-lg max-h-screen-lg object-contain" />
      </div>
    </div>
  );
};

export default ImageModal;
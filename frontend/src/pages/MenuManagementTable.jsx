import React, { useState } from 'react';
import { Edit, Trash2 } from 'lucide-react';
import AddItemModal from './AddItemModal'

const MenuManagementTable = ({ items, onSaveNewItem, categories }) => {
  const [isModalOpen, setIsModalOpen] = useState(false);

  const handleSaveItem = (formData) => {
    console.log('New item data:', formData);
    // Logic to send data to the backend will go here
    setIsModalOpen(false); // Close modal on save
  };
  return (
    <div className="mt-12">
      <div className="flex justify-between items-center mb-6">
        <h2 className="text-2xl font-bold">Menu Management</h2>
        <button
          onClick={() => setIsModalOpen(true)}
          className="bg-blue-500 text-white font-bold py-2 px-4 rounded hover:bg-blue-600 transition-colors"
        >
          Add New Item
        </button>
      </div>
      <div className="bg-white shadow-md rounded-lg overflow-hidden">
        <table className="min-w-full leading-normal">
          <thead>
            <tr className="bg-gray-200 text-gray-600 uppercase text-sm leading-normal">
              <th className="py-3 px-6 text-left">Item Name</th>
              <th className="py-3 px-6 text-left">Category</th>
              <th className="py-3 px-6 text-center">Price</th>
              <th className="py-3 px-6 text-center">Stock</th>
              <th className="py-3 px-6 text-center">Actions</th>
            </tr>
          </thead>
          <tbody className="text-gray-600 text-sm font-light">
            {items.map((item) => (
              <tr key={item.item_id} className="border-b border-gray-200 hover:bg-gray-100">
                <td className="py-3 px-6 text-left">
                  <span className="font-medium">{item.item_name}</span>
                </td>
                <td className="py-3 px-6 text-left">
                  <span>{item.category}</span>
                </td>
                <td className="py-3 px-6 text-center">
                  <span>${parseFloat(item.price).toFixed(2)}</span>
                </td>
                <td className="py-3 px-6 text-center">
                  <span>{item.stock}</span>
                </td>
                <td className="py-3 px-6 text-center">
                  <div className="flex item-center justify-center gap-4">
                    <button className="text-blue-500 hover:text-blue-700">
                      <Edit size={20} />
                    </button>
                    <button className="text-red-500 hover:text-red-700">
                      <Trash2 size={20} />
                    </button>
                  </div>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
        
        {/* Render the modal component */}
      <AddItemModal
    isOpen={isModalOpen}
    onClose={() => setIsModalOpen(false)}
    onSave={onSaveNewItem}
    categories={categories} // <-- Pass categories to the modal
  />
      </div>
    </div>
  );
};

export default MenuManagementTable;
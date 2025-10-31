import React from 'react';
import { Edit, Trash2 } from 'lucide-react';

const StaffManagementTable = ({ 
  staffList, 
  onAddStaff, 
  onEditStaff, 
  onDeleteStaff 
}) => {
  return (
    <div className="mt-12">
      <div className="flex justify-between items-center mb-6">
        <h2 className="text-2xl font-bold">Staff Management</h2>
        <button
          onClick={onAddStaff}
          className="bg-blue-500 text-white font-bold py-2 px-4 rounded hover:bg-blue-600 transition-colors"
        >
          Add New Staff
        </button>
      </div>

      <div className="bg-white shadow-md rounded-lg overflow-hidden">
        <table className="min-w-full leading-normal">
          <thead>
            <tr className="bg-gray-100 text-gray-600 uppercase text-sm leading-normal">
              <th className="py-3 px-6 text-left">Name</th>
              <th className="py-3 px-6 text-left">Email</th>
              <th className="py-3 px-6 text-center">Role</th>
              <th className="py-3 px-6 text-center">Actions</th>
            </tr>
          </thead>
          <tbody className="text-gray-600 text-sm font-light">
            {staffList.map((staff) => (
              <tr key={staff.staff_id} className="border-b border-gray-200 hover:bg-gray-50">
                <td className="py-3 px-6 text-left">
                  <span className="font-medium">{staff.first_name} {staff.last_name}</span>
                </td>
                <td className="py-3 px-6 text-left">
                  <span>{staff.email}</span>
                </td>
                <td className="py-3 px-6 text-center">
                  <span className="capitalize py-1 px-3 rounded-full text-xs font-semibold bg-gray-200 text-gray-800">
                    {staff.role}
                  </span>
                </td>
                <td className="py-3 px-6 text-center">
                  <div className="flex item-center justify-center gap-4">
                    <button 
                      onClick={() => onEditStaff(staff)} 
                      className="text-blue-500 hover:text-blue-700"
                    >
                      <Edit size={20} />
                    </button>
                    <button
                      onClick={() => onDeleteStaff(staff.staff_id)}
                      className="text-red-500 hover:text-red-700"
                    >
                      <Trash2 size={20} />
                    </button>
                  </div>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default StaffManagementTable;
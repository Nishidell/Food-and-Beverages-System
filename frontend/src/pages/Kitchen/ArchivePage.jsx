    import React, { useState, useEffect } from 'react';
    import { Link } from 'react-router-dom';
    import InternalNavBar from './components/InternalNavBar';
    import { useAuth } from '../../context/AuthContext';
    import apiClient from '../../utils/apiClient'; // <-- 1. IMPORT

const styles = {
  card: {
    backgroundColor: '#fff2e0', // The user's requested color
    borderRadius: '0.5rem',
    boxShadow: '0 4px 6px -1px rgba(0,0,0,0.1), 0 2px 4px -1px rgba(0,0,0,0.06)',
    padding: '16px',
    color: '#3C2A21', // The new brown text color
    display: 'flex',
    flexDirection: 'column',
    height: '100%',
  },
  cardHeader: {
    marginBottom: '12px',
    borderBottom: '1px solid #D1C0B6', // A light brown border
    paddingBottom: '8px',
  },
  cardTitle: {
    fontWeight: 'bold',
    fontSize: '1.125rem', // 18px
    color: '#3C2A21',
  },
  cardSubText: {
    fontSize: '0.75rem', // 12px
    color: '#503C30', // A slightly lighter brown
  },
  infoText: {
    fontSize: '0.875rem', // 14px
    color: '#3C2A21',
  },
  infoLabel: {
    fontWeight: '500', // medium
  },
  itemSectionTitle: {
    fontWeight: '600',
    fontSize: '0.875rem',
    marginTop: '8px',
    color: '#3C2A21',
  },
  itemText: {
    fontSize: '0.875rem',
    marginLeft: '8px',
    color: '#3C2A21',
  },
  itemInstructions: {
    fontSize: '0.75rem',
    color: '#785A4A', // Lighter brown
    fontStyle: 'italic',
    paddingLeft: '16px',
  }
};

    function ArchivePage() {
      const [servedOrders, setServedOrders] = useState([]);
      const [error, setError] = useState(null);
      const [loading, setLoading] = useState(true);
      const { token } = useAuth();

      const fetchOrderDetails = async (orderId) => {
      try {
        const response = await apiClient(`/orders/${orderId}`); // No headers
        if (!response.ok) {
          console.error(`Failed to fetch details for order ${orderId}`);
          return null;
        }
        return await response.json();
      } catch (err) {
        if (err.message !== 'Session expired') {
          console.error(`Error fetching details for order ${orderId}:`, err);
        }
        return null;
      }
    };

    useEffect(() => {
        const fetchServedOrders = async () => {
          try {
            setLoading(true);
            setError(null);
            
            // 1. Fetch the list of served orders
            const listResponse = await apiClient('/orders/served'); 
            if (!listResponse.ok) {
              throw new Error('Failed to fetch served orders list');
            }
            const ordersList = await listResponse.json();

            if (!Array.isArray(ordersList)) {
                console.error("API did not return an array", ordersList);
                throw new Error("Invalid data from server.");
            }

            // 2. Fetch details for each order in parallel
            const ordersWithDetails = await Promise.all(
              ordersList.map(order => fetchOrderDetails(order.order_id))
            );
            
            // 3. Filter out any failed requests and set the state
            const newOrders = ordersWithDetails.filter(order => order !== null);
            setServedOrders(newOrders);

          } catch (err) {
            if (err.message !== 'Session expired') {
              setError(err.message);
            }
          } finally {
            setLoading(false);
          }
        };
        
        if (token) {
            fetchServedOrders();
        }
      }, [token]);

      // ... (Rest of component JSX is unchanged) ...
      if (loading) return (
        <>
          <InternalNavBar /> 
          <div className="p-8 text-center text-lg">Loading archive...</div>
        </>
      );
      
      if (error) return (
        <>
          <InternalNavBar />
          <div className="p-8 text-center text-red-500">Error: {error}</div>
        </>
      );

      return (
        <>
          <InternalNavBar />
          <div className="bg-figma-cream min-h-screen px-4 py-8">
            <div className="container mx-auto">
              <h1 className="text-3xl font-bold mb-6 text-center" style={{ color: '#3C2A21' }}>Served Orders Archive</h1>

              {servedOrders.length === 0 ? (
                <p className="text-center text-gray-500 mt-10">No served orders found.</p>
              ) : (
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: '24px' }}>
  {servedOrders.map(order => (  
    <div key={order.order_id} style={styles.card}>
      {/* Card Header */}
      <div style={styles.cardHeader}>
        <h2 style={styles.cardTitle}>Order #{order.order_id}</h2>
        <p style={styles.cardSubText}>Time: {new Date(order.order_date).toLocaleString()}</p>
        <p style={styles.infoText}>Type: <span style={styles.infoLabel}>{order.order_type}</span></p>
        <p style={styles.infoText}>Location: <span style={styles.infoLabel}>{order.delivery_location}</span></p>
        <p style={styles.infoText}>Status: <span style={styles.infoLabel}>{order.status}</span></p>
      </div>

      {/* Card Body (Items) */}
      <div style={{flex: 1, overflowY: 'auto', maxHeight: '192px', paddingRight: '4px'}}>
        <h3 style={styles.itemSectionTitle}>Items:</h3>
        {order.items && order.items.length > 0 ? (
          order.items.map(item => (
            <div key={item.detail_id} style={{marginTop: '4px'}}>
              <span style={styles.itemText}><span style={styles.infoLabel}>{item.quantity} x</span> {item.item_name}</span>
              {item.instructions && <p style={styles.itemInstructions}>- {item.instructions}</p>}
            </div>
          ))
        ) : (
          <p style={styles.itemText}>No item details found.</p>
           )}
          </div>
            </div>
            ))}
              </div>
              )}
            </div>
          </div>
        </>
      );
    }

    export default ArchivePage;
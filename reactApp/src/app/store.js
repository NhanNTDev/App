import { configureStore } from '@reduxjs/toolkit';
import cartReduser from '../state_manager_redux/cart/cartSlice'
import locationReduser from '../state_manager_redux/location/locationSlice'

export const store = configureStore({
  reducer: {
    cart: cartReduser,
    location: locationReduser,
  },
});

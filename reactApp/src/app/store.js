import { configureStore } from '@reduxjs/toolkit';
import cartReduser from '../state_manager_redux/cart/cartSlice'

export const store = configureStore({
  reducer: {
    cart: cartReduser,
  },
});

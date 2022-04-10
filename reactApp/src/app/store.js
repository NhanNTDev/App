import { configureStore } from '@reduxjs/toolkit';
import cartReduser from '../state_manager_redux/cart/cartSlice';
import locationReduser from '../state_manager_redux/location/locationSlice';
import userReducer from '../state_manager_redux/user/userSlice';
import orderReducer from "../state_manager_redux/order/orderSlice";
import zoneReducer from '../state_manager_redux/zone/zoneSlice';

export const store = configureStore({
  reducer: {
    cart: cartReduser,
    location: locationReduser,
    user: userReducer,
    order: orderReducer,
    zone: zoneReducer,
  },
});

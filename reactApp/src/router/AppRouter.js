import { Routes, Route, Navigate } from "react-router-dom";
import PrivateRoute from "./PrivateRoute";
import Account from "../pages/Account";
import Address from "../pages/Address";
import Campaign from "../pages/Campaign";
import Cart from "../pages/Cart";
import Checkout from "../pages/Checkout";
import Farm from "../pages/Farm";
import Home from "../pages/Home";
import Login from "../pages/Login";
import OrderList from "../pages/OrderList";
import PageNotFound from "../pages/PageNotFound";
import Product from "../pages/Product";
import Shop from "../pages/Shop";
import ViewAllCampaigns from "../pages/ViewAllCampaigns";
import Wishlist from "../pages/Wishlist";
import SearchResult from "../pages/SearchResult";
import { useSelector } from "react-redux";
import GetStarted from "../pages/GetStarted";

const AppRouter = () => {
  const user = useSelector((state) => state.user);
  return (
    <Routes>
      <Route path="/" element={<Home />} />
      <Route path="/home" element={<Home />} />
      <Route
        path="/checkout"
        element={
          <PrivateRoute>
            <Checkout />
          </PrivateRoute>
        }
      />
      <Route
        path="/account"
        element={
          <PrivateRoute>
            <Account />
          </PrivateRoute>
        }
      />
      <Route
        path="/address"
        element={
          <PrivateRoute>
            <Address />
          </PrivateRoute>
        }
      />
      <Route
        path="/wishlist"
        element={
          <PrivateRoute>
            <Wishlist />
          </PrivateRoute>
        }
      />
      <Route
        path="/orderlist"
        element={
          <PrivateRoute>
            <OrderList />
          </PrivateRoute>
        }
      />
      <Route path="/shop" element={<Shop />} />
      <Route
        path="/cart"
        element={
          <PrivateRoute>
            <Cart />
          </PrivateRoute>
        }
      />
      <Route
        path="/getStarted"
        element={
          <PrivateRoute>
            <GetStarted />
          </PrivateRoute>
        }
      />
      <Route path="/page-not-found" element={<PageNotFound />} />
      <Route path="/products/:campaignId/:productId" element={<Product />} />
      <Route path="/all-campaigns" element={<ViewAllCampaigns />} />
      <Route path="/campaign/:id" element={<Campaign />} />
      <Route path="/campaign/:campaignId/:farmId" element={<Farm />} />
      <Route path="/search-result" element={<SearchResult />} />
      <Route path="/login" element={user === null ? <Login /> : <Navigate replace to="/"/>} />
      <Route path="/*" element={<Navigate replace to="/page-not-found" />} />
    </Routes>
  );
};

export default AppRouter;

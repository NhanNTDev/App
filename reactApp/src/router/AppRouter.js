import { Routes, Route, Navigate } from "react-router-dom";
import PrivateRoute from "./PrivateRoute";
import Account from "../pages/Account";
import Address from "../pages/Address";
import Campaign from "../pages/Campaign";
import Cart from "../pages/Cart";
import Checkout from "../pages/Checkout";
import Home from "../pages/Home";
import Login from "../pages/Login";
import OrderList from "../pages/OrderList";
import PageNotFound from "../pages/PageNotFound";
import Product from "../pages/Product";
import ViewAllCampaigns from "../pages/ViewAllCampaigns";
import SearchResult from "../pages/SearchResult";
import { useSelector } from "react-redux";
import GetStarted from "../pages/GetStarted";
import ChangePassword from "../pages/ChangePassword";
import OrderDetails from "../pages/OrderDetails";
import ProductOrigin from "../pages/ProductOrigin";

const AppRouter = () => {
  const location = useSelector((state) => state.location);
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
          <PrivateRoute urlRedirect="/account">
            <Account />
          </PrivateRoute>
        }
      />
      <Route
        path="/address"
        element={
          <PrivateRoute urlRedirect="/address">
            <Address />
          </PrivateRoute>
        }
      />
      <Route
        path="/orderlist"
        element={
          <PrivateRoute urlRedirect="/orderlist">
            <OrderList />
          </PrivateRoute>
        }
      />
      <Route
        path="/cart"
        element={
          <PrivateRoute urlRedirect="/cart">
            <Cart />
          </PrivateRoute>
        }
      />
      <Route
        path="/changePassword"
        element={
          <PrivateRoute urlRedirect="/">
            <ChangePassword />
          </PrivateRoute>
        }
      />
      <Route
        path="/orderDetails"
        element={
          <PrivateRoute urlRedirect="/changePassword">
            <OrderDetails />
          </PrivateRoute>
        }
      />
      <Route path="/getStarted" element={location === null ? <GetStarted /> : <Home/>} />
      <Route path="/productOrigin" element={<ProductOrigin />} />
      <Route path="/products/:campaignId/:productId" element={<Product />} />
      <Route path="/all-campaigns" element={<ViewAllCampaigns />} />
      <Route path="/campaign/:id" element={<Campaign />} />
      <Route path="/search-result" element={<SearchResult />} />
      <Route path="/login" element={<Login />} />
      <Route path="/page-not-found" element={<PageNotFound />} />
      <Route path="/*" element={<Navigate replace to="/page-not-found" />} />
    </Routes>
  );
};

export default AppRouter;

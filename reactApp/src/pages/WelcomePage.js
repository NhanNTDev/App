import { Routes, Route, Navigate } from "react-router-dom";

import Footer from "../components/home/Footer";
import Header from "../components/header/Header";
import Home from "./Home";
import Checkout from "./Checkout";
import Account from "./Account";
import PageNotFound from "./PageNotFound";
import Shop from "./Shop";
import Wistlist from "./Wishlist";
import Address from "./Address";
import OrderList from "./OrderList";
import Product from "./Product";
import Cart from "./Cart";
import ViewAllCampaigns from "./ViewAllCampaigns";
import Campaign from "./Campaign";
import SearchResult from "./SearchResult";
import Farm from "./Farm";

const WelcomePage = () => {
  return (
    <div style={{ backgroundColor: "#f9f9f9" }}>
      <Header></Header>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/home" element={<Home />} />
        <Route path="/checkout" element={<Checkout />} />
        <Route path="/account" element={<Account />} />
        <Route path="/address" element={<Address />} />
        <Route path="/wishlist" element={<Wistlist />} />
        <Route path="/orderlist" element={<OrderList />} />
        <Route path="/shop" element={<Shop />} />
        <Route path="/cart" element={<Cart />} />
        <Route path="/page-not-found" element={<PageNotFound />} />
        <Route path="/product" element={<Product />} />
        <Route path="/all-campaigns" element={<ViewAllCampaigns />} />
        <Route path="/campaign/:id" element={<Campaign />} />
        <Route path="/campaign/:campaignId/:farmId" element={<Farm/>} />
        <Route path="/search-result" element={<SearchResult/>}/>
        <Route path="/*" element={<Navigate replace to="/page-not-found" />} />
      </Routes>
      <Footer></Footer>
    </div>
  );
};

export default WelcomePage;

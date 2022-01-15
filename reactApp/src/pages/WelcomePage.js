import { Routes, Route, Navigate } from "react-router-dom";

import Footer from "../components/home/Footer";
import Header from "../components/header/Header";
import AppRouter from "../router/AppRouter";

const WelcomePage = () => {
  return (
    <div style={{ backgroundColor: "#f9f9f9" }}>
      <Header/>
      <AppRouter/>
      {/* <Routes>
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
        <Route path="/products/:campaignId/:productId" element={<Product />} />
        <Route path="/all-campaigns" element={<ViewAllCampaigns />} />
        <Route path="/campaign/:id" element={<Campaign />} />
        <Route path="/campaign/:campaignId/:farmId" element={<Farm/>} />
        <Route path="/search-result" element={<SearchResult/>}/>
        <Route path="/login" element={<Login/>}/>
        <Route path="/*" element={<Navigate replace to="/page-not-found" />} />
      </Routes> */}
      <Footer/>
      </div>
  );
};

export default WelcomePage;

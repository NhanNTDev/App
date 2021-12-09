import { Routes, Route} from "react-router-dom";

import Footer from "../components/Footer";
import Header from "../components/Header";
import Home from "./Home";
import Checkout from "./Checkout";
import Account from "./Account";
import PageNotFound from "./PageNotFound";
import Shop from "../components/Shop";
import Wistlist from "./Wishlist";
import Address from "./Address";
import OrderList from "./OrderList";

const WelcomePage = () => {
  return (
    <>
      <Header></Header>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/home" element={<Home />} />
        <Route path="/checkout" element={<Checkout />} />
        <Route path="/account" element={<Account />} />
        <Route path="/address" element={<Address />} />
        <Route path="/wishlist" element={<Wistlist />} />
        <Route path="/orderlist" element={<OrderList/>} />
        <Route path="/shop" element={<Shop/>}/>
        <Route path="/page-not-found" element={<PageNotFound/>}/>
        
      </Routes>
      <Footer></Footer>
    </>
  );
};

export default WelcomePage;

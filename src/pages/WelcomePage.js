import { Routes, Route, Redirect} from "react-router-dom";

import Footer from "../components/Footer";
import Header from "../components/Header";
import Home from "./Home";
import Checkout from "./Checkout";
import ProfileRight from "../components/ProfileRight";
import AddressForm from "../components/AddressForm";
import Wistlist from "../components/Wistlist";
import OrderList from "../components/OrderList";
import PageNotFound from "./PageNotFound";
import Shop from "../components/Shop";

const WelcomePage = () => {
  return (
    <>
      <Header></Header>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/home" element={<Home />} />
        <Route path="/checkout" element={<Checkout />} />
        <Route path="/profile" element={<ProfileRight />} />
        <Route path="/address" element={<AddressForm />} />
        <Route path="/wishlist" element={<Wistlist />} />
        <Route path="/orderlist" element={<OrderList />} />
        <Route path="/shop" element={<Shop/>}/>
        <Route path="/page-not-found" element={<PageNotFound/>}/>
        
      </Routes>
      <Footer></Footer>
    </>
  );
};

export default WelcomePage;

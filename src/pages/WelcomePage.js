
import { Routes, Route} from "react-router-dom";

import Footer from "../components/Footer";
import Header from "../components/Header";
import Home from "./Home";
import Checkout from "./Checkout";

const WelcomePage = () => {
  return (
    <>
      <Header></Header>
      <Routes>
        <Route path="/" element={<Home/>}/>
        <Route path="/Home" element={<Home/>}/>
        <Route path="/Checkout" element={<Checkout/>}/>
      </Routes>
      <Footer></Footer>
    </>
  );
};

export default WelcomePage;

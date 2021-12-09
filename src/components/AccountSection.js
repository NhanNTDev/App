import { BrowserRouter, Routes, Route } from "react-router-dom";
import AccountLeft from "./AccountLeft";
import AddressForm from "./AddressForm";
import OrderList from "./OrderList";
import ProfileRight from "./ProfileRight";
import Wistlist from "./Wistlist";

const AccountSection = () => {
  return (
    <BrowserRouter>
      <section className="account-page section-padding">
        <div className="container">
          <div className="row">
            <div className="col-lg-9 mx-auto">
              <div className="row no-gutters">
                <div className="col-md-4">
                  <AccountLeft />
                </div>
                <div className="col-md-8">
                  <Routes>
                    <Route path="/" element={<ProfileRight/>} />
                    <Route path="/address" element={<AddressForm/>} />
                    <Route path="/wishlist" element={<Wistlist/>} />
                    <Route path="/orderlist" element={<OrderList/>} />
                  </Routes>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </BrowserRouter>
  );
};

export default AccountSection;

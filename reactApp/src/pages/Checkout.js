import { Link } from "react-router-dom";
import CheckoutSection from "../components/checkout/CheckoutSection";

const Checkout = () => {
  return (
    <>
      <section className="pt-3 pb-3 page-info section-padding border-bottom bg-white">
        <div className="container">
          <div className="row">
            <div className="col-md-12">
              <Link to="/">
                <strong>
                  <span className="mdi mdi-home"></span> Trang chủ
                </strong>
              </Link>{" "}
              <span className="mdi mdi-chevron-right"></span>{" "}
              <span>Thanh toán</span>
            </div>
          </div>
        </div>
      </section>
      <CheckoutSection/>
    </>
  );
};

export default Checkout;

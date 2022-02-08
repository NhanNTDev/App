import CheckoutSection from "../components/checkout/CheckoutSection";

const Checkout = () => {
  return (
    <>
      <section className="pt-3 pb-3 page-info section-padding border-bottom bg-white">
        <div className="container">
          <div className="row">
            <div className="col-md-12">
              <a href="#">
                <strong>
                  <span className="mdi mdi-home"></span> Trang chủ
                </strong>
              </a>{" "}
              <span className="mdi mdi-chevron-right"></span>{" "}
              <a href="#">Thanh toán</a>
            </div>
          </div>
        </div>
      </section>
      <CheckoutSection></CheckoutSection>
    </>
  );
};

export default Checkout;

import { Link } from "react-router-dom";

const CampaignDetail = (props) => {
  return (
    <div className="shop-detail-right">
      <span className="badge badge-success">50% OFF</span>
      <h2>{props.campaign.name}</h2>
      <h6>
        <strong>
          <span className="mdi mdi-approval"></span> Available in
        </strong>{" "}
        - 500 gm
      </h6>
      <p className="regular-price">
        <i className="mdi mdi-tag-outline"></i> MRP : $800.99
      </p>
      <p className="offer-price mb-0">
        Giá ưu đãi : <span className="text-success">$450.99</span>
      </p>
      <Link to="/checkout">
        <button type="button" className="btn btn-secondary btn-lg">
          <i className="mdi mdi-cart-outline"></i> Thêm Vào Giỏ Hàng
        </button>{" "}
      </Link>
      <div className="short-description">
        <h5>
          Quick Overview
          <p className="float-right">
            Availability: <span className="badge badge-success">In Stock</span>
          </p>
        </h5>
        <p>
          <b>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</b> Nam
          fringilla augue nec est tristique auctor. Donec non est at libero
          vulputate rutrum.
        </p>
        <p className="mb-0">
          {" "}
          Vivamus adipiscing nisl ut dolor dignissim semper. Nulla luctus
          malesuada tincidunt. Class aptent taciti sociosqu ad litora torquent
          per conubia nostra, per inceptos hiMenaeos. Integer enim purus,
          posuere at ultricies eu, placerat a felis. Suspendisse aliquet urna
          pretium eros convallis interdum.
        </p>
      </div>
      <h6 className="mb-3 mt-4">Why shop from Groci?</h6>
      <div className="row">
        <div className="col-md-6">
          <div className="feature-box">
            <i className="mdi mdi-truck-fast"></i>
            <h6 className="text-info">Free Delivery</h6>
            <p>Lorem ipsum dolor...</p>
          </div>
        </div>
        <div className="col-md-6">
          <div className="feature-box">
            <i className="mdi mdi-basket"></i>
            <h6 className="text-info">100% Guarantee</h6>
            <p>Rorem Ipsum Dolor sit...</p>
          </div>
        </div>
      </div>
    </div>
  );
};

export default CampaignDetail;

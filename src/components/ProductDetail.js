import { Link } from "react-router-dom";

const ProductDetail = () => {
  return (
    <div class="shop-detail-right">
      <span class="badge badge-success">50% OFF</span>
      <h2>Dâu Tây Đà Lạt (Sales)</h2>
      <h6>
        <strong>
          <span class="mdi mdi-approval"></span> Available in
        </strong>{" "}
        - 500 gm
      </h6>
      <p class="regular-price">
        <i class="mdi mdi-tag-outline"></i> MRP : $800.99
      </p>
      <p class="offer-price mb-0">
        Giá ưu đãi : <span class="text-success">$450.99</span>
      </p>
      <Link to="/checkout">
        <button type="button" class="btn btn-secondary btn-lg">
          <i class="mdi mdi-cart-outline"></i> Thêm Vào Giỏ Hàng
        </button>{" "}
      </Link>
      <div class="short-description">
        <h5>
          Quick Overview
          <p class="float-right">
            Availability: <span class="badge badge-success">In Stock</span>
          </p>
        </h5>
        <p>
          <b>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</b> Nam
          fringilla augue nec est tristique auctor. Donec non est at libero
          vulputate rutrum.
        </p>
        <p class="mb-0">
          {" "}
          Vivamus adipiscing nisl ut dolor dignissim semper. Nulla luctus
          malesuada tincidunt. Class aptent taciti sociosqu ad litora torquent
          per conubia nostra, per inceptos hiMenaeos. Integer enim purus,
          posuere at ultricies eu, placerat a felis. Suspendisse aliquet urna
          pretium eros convallis interdum.
        </p>
      </div>
      <h6 class="mb-3 mt-4">Why shop from Groci?</h6>
      <div class="row">
        <div class="col-md-6">
          <div class="feature-box">
            <i class="mdi mdi-truck-fast"></i>
            <h6 class="text-info">Free Delivery</h6>
            <p>Lorem ipsum dolor...</p>
          </div>
        </div>
        <div class="col-md-6">
          <div class="feature-box">
            <i class="mdi mdi-basket"></i>
            <h6 class="text-info">100% Guarantee</h6>
            <p>Rorem Ipsum Dolor sit...</p>
          </div>
        </div>
      </div>
    </div>
  );
};

export default ProductDetail;

import { Link } from "react-router-dom";

const ProductItem = (props) => {
  return (
    <div className="col-md-3">
      <div className="product">
        <Link to="/product">
          <div className="product-header">
            <img className="img-fluid" src="img/item/3.jpg" alt="" />
            <span className="veg text-success mdi mdi-circle"></span>
          </div>
          <div className="product-body">
            <div style={{ height: 80 }}>
              <h4>{props.name}</h4>
              <h6>
                <strong>
                  <span class="mdi mdi-approval"></span> Còn lại:
                </strong>{" "}
                {props.available} {" / "} {props.maxQuantity} {props.unit}
              </h6>
            </div>
            <div style={{ height: 80 }}>
              <h5>
                <strong>
                  <span className="mdi mdi-map-marker-circle"></span> Chiến
                  dịch:
                </strong>{" "}
                {props.campaignName}
              </h5>
              <h5>
                <strong>
                  <span className="mdi mdi-flower"></span> Nông trại:
                </strong>{" "}
                {props.farmName}
              </h5>
              <br />
            </div>
            <br />
          </div>
        </Link>
        <div className="product-footer">
          <button
            type="button"
            className="btn btn-secondary btn-sm float-right"
            onClick={() => {}}
          >
            <i className="mdi mdi-cart"></i> Thêm vào giỏ hàng
          </button>
          <p className="offer-price mb-0">
            <i className="mdi mdi-tag-outline"></i>{" "}
            {props.price.toLocaleString()} {" VNĐ / "} {props.unit}
          </p>
          <br />
        </div>
      </div>
    </div>
  );
};

export default ProductItem;

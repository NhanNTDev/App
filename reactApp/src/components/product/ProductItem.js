import { Link } from "react-router-dom";

const ProductItem = (props) => {
  return (
    <div className="col-md-3">
      <div className="product">
        <Link to={`/products/${props.product.productCategory.campaignId}/${props.product.id}`}>
          <div className="product-header">
            <img className="img-fluid" src={props.product.image1} alt="" />
            <span className="veg text-success mdi mdi-circle"></span>
          </div>
          <div className="product-body">
            <div>
              <h4
                style={{
                  height: 50,
                  overflow: "hidden",
                  textOverflow: "ellipsis",
                }}
              >
                {props.product.name}
              </h4>
              <h6>
                <strong>
                  <span class="mdi mdi-approval"></span> Còn lại:
                </strong>{" "}
                {/* {props.product.product.available} {" / "} {props.product.product.maxQuantity} {props.product.product.unit} */}
              </h6>
            </div>
            <div>
              <h5>
                <strong>
                  <span className="mdi mdi-map-marker-circle"></span> Chiến
                  dịch:
                </strong>{" "}
                {props.product.productCategory.name}
              </h5>
              <h5>
                <strong>
                  <span className="mdi mdi-flower"></span> Nông trại:
                </strong>{" "}
                {props.product.farm.name}
              </h5>
              <br />
            </div>
            <br />
          </div>
        </Link>
        {/* <div className="product-footer">
          <button
            type="button"
            className="btn btn-secondary btn-sm float-right"
            onClick={() => {}}
          >
            <i className="mdi mdi-cart"></i> Thêm vào giỏ hàng
          </button>
          <p className="offer-price mb-0">
            <i className="mdi mdi-tag-outline"></i>{" "}
            {props.product.product.price.toLocaleString()} {" VNĐ / "} {props.product.product.unit}
          </p>
          <br />
        </div> */}
      </div>
    </div>
  );
};

export default ProductItem;

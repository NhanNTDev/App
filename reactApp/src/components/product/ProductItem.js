import { Link } from "react-router-dom";

const ProductItem = (props) => {
  return (
    <div className="col-md-3">
      <div className="product">
        <Link
          to={`/products/${props.product.productCategory.campaignId}/${props.product.id}`}
        >
          <div className="product-header">
            {props.product.image1 !== null ? (
              <img
                className="img-fluid"
                src={props.product.image1}
                alt=""
              />
            ) : (
              <img className="img-fluid" src="/img/item/1.jpg" alt="" />
            )}
            <span className="veg text-success mdi mdi-circle"></span>
          </div>
          <div className="product-body">
            <div style={{ height: 90 }}>
              <h4
                style={{
                  height: 40,
                  overflow: "hidden",
                  textOverflow: "ellipsis",
                }}
              >
                {props.product.name}
              </h4>
              <p className="offer-price mb-0">
                <i className="mdi mdi-tag-outline"></i>{" "}
                {props.product.price.toLocaleString()} {" VNĐ / "}{" "}
                {props.product.unit}
              </p>
              <h6>
                <strong>
                  <span class="mdi mdi-approval"></span> Còn lại:
                </strong>{" "}
                {props.product.quantity} {props.product.unit}
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
          <br />
        </div> */}
      </div>
    </div>
  );
};

export default ProductItem;

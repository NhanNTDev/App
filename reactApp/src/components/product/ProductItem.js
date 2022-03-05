import { Link } from "react-router-dom";

const ProductItem = (props) => {
  return (
    <div className="col-md-3">
      <div className="product">
        <Link to={`/products/${props.campaignId}/${props.id}`}>
          <div className="product-header">
            {props.harvest.image1 && (
              <img
                className="img-fluid"
                src={props.harvest.image1}
                alt=""
              />
            ) }
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
                {props.productName}
              </h4>
              <p className="offer-price mb-0">
                <i className="mdi mdi-tag-outline"></i>{" "}
                {props.price.toLocaleString()} {" VNĐ / "} {props.unit}
              </p>
              <h6>
                <strong>
                  <span class="mdi mdi-approval"></span> Còn lại:
                </strong>{" "}
                {props.inventory} {props.unit}
              </h6>
            </div>
            <div>
              <h5>
                <strong>
                  <span className="mdi mdi-map-marker-circle"></span> Chiến
                  dịch:
                </strong>{" "}
                {props.campaign.name}
              </h5>
              <h5>
                <strong>
                  <span className="mdi mdi-flower"></span> Nông trại:
                </strong>{" "}
                {props.harvest.farm.name}
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

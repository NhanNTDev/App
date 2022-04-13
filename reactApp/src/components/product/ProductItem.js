import { Tag } from "antd";
import { Link } from "react-router-dom";

const ProductItem = (props) => {
  console.log(window.location.href);
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
            {props.quantity !== 0 && <span className="veg text-success mdi mdi-circle"></span>}
            
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
                {props.productName} {props.quantity === 0 && <span><Tag color="error">Hết hàng</Tag></span>}
              </h4>
              <p className="offer-price mb-0">
                <i className="mdi mdi-tag-outline"></i>{" "}
                {props.price.toLocaleString()} {" VNĐ / "} {props.unit}
              </p>
              <h6>
                <strong>
                  <span className="mdi mdi-approval"></span> Còn lại:
                </strong>{" "}
                {props.quantity} {props.unit} <Tag color='gold'>Đã bán {(props.inventory - props.quantity) + " " + props.unit}</Tag>
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
      </div>
    </div>
  );
};

export default ProductItem;

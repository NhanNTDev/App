import { Tag } from "antd";
import { Link } from "react-router-dom";

const ProductItemShort = (props) => {
  console.log(props);
  return (
    <div className="col-md-4">
      <div className="product" style={props.quantity === 0 ? {
        backgroundColor: 'gray',
      } : null}>
        <Link to={props.harvestCampaign.quantity !== 0 ? `/products/${props.campaignId}/${props.harvestCampaign.id}` : '#'}>
          <div className="product-header">
            {props.harvestCampaign.harvest.image1 !== null ? (
              <img
                className="img-fluid"
                src={props.harvestCampaign.harvest.image1}
                alt=""
              />
            ) : (
              <img className="img-fluid" src="/img/item/1.jpg" alt="" />
            )}
            {props.harvestCampaign.quantity !== 0 && <span className="veg text-success mdi mdi-circle"></span>}
          </div>

          <div className="product-body">
            <div style={{ height: 160 }}>
              <h4
                style={{
                  height: 55,
                  overflow: "hidden",
                  textOverflow: "ellipsis",
                }}
              >
                {props.harvestCampaign.productName} {props.harvestCampaign.quantity === 0 && <span><Tag color="error">Hết hàng</Tag></span>}
              </h4>
              <p className="offer-price">
                <i className="mdi mdi-tag-outline"></i>{" "}
                {props.harvestCampaign.price.toLocaleString()} {" VNĐ / "}{" "}
                {props.harvestCampaign.unit}
              </p>
              <div className="detail">
                <h6>
                  <span class="mdi mdi-approval"></span> Còn lại: {props.harvestCampaign.quantity}{"  "}
                  {props.harvestCampaign.unit}
                </h6>
                <h5>
                  <i>
                    <span className="mdi mdi-home-circle"></span> Nông trại:
                  </i>{" "}
                  {props.harvestCampaign.harvest.farm.name}
                </h5>
                <h5>
                  <i>
                    <span className="mdi mdi-carrot"></span> Mùa vụ:
                  </i>{" "}
                  {props.harvestCampaign.harvest.name}
                </h5>
              </div>
            </div>
            <br />
          </div>
        </Link>
      </div>
   
    </div>
  );
};

export default ProductItemShort;

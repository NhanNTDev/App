import { Link } from "react-router-dom";

const ProductItemShort = (props) => {
  return (
    <div className="item">
      <div className="product">
        <Link to={`/products/${props.campaignId}/${props.harvestCampaign.id}`}>
          <div className="product-header">
            {props.harvestCampaign.harvest.product.image1 !== null ? (
              <img
                className="img-fluid"
                src={props.harvestCampaign.harvest.product.image1}
                alt=""
              />
            ) : (
              <img className="img-fluid" src="/img/item/1.jpg" alt="" />
            )}
            <span className="veg text-success mdi mdi-circle"></span>
          </div>

          <div className="product-body">
            <div style={{ height: 80 }}>
              <h4
                style={{
                  height: 40,
                  overflow: "hidden",
                  textOverflow: "ellipsis",
                }}
              >
                {props.harvestCampaign.productName}
              </h4>
              <p className="offer-price">
                <i className="mdi mdi-tag-outline"></i>{" "}
                {props.harvestCampaign.price.toLocaleString()} {" VNĐ / "}{" "}
                {props.harvestCampaign.unit}
              </p>
              <div className="detail">
                <h6>
                  <span class="mdi mdi-approval"></span> Còn lại:
                  {props.harvestCampaign.inventory} {props.harvestCampaign.unit}
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
        <div className="product-footer">
          <br />
        </div>
      </div>
    </div>
  );
};

export default ProductItemShort;

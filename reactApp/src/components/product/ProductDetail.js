import { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import farmApi from "../../apis/farmApi";

const ProductDetail = (props) => {
  const [farm, setFarm] = useState([]);

  useEffect(() => {
    const fetchFarm = async () => {
      const farmResponse = farmApi.get(props.harvestCampaign.harvest.farmId);
      setFarm(farmResponse);
    }
  }, []);
    
  return (
    <div className="shop-detail-right">
      <h2>{props.harvest.product.name}</h2>
      <h6>
        <strong>
          <span className="mdi mdi-approval"></span> Còn lại:
        </strong>{" "}
        {props.inventory}
        {" "}{props.unit}
      </h6>
      <p className="offer-price mb-0">
        <span className="mdi mdi-tag"></span>{" "}
        <span className="price-offer">
          {props.price.toLocaleString()}
          {" VNĐ / "}
          {props.unit}
        </span>
      </p>
      <Link to="/checkout">
        <button type="button" className="btn btn-secondary btn-lg">
          <i className="mdi mdi-cart-outline"></i> Thêm vào giỏ hàng
        </button>{" "}
      </Link>
      <div className="short-description">
        <h5>Mô tả:</h5>
        <p
          style={{
            overflow: "hidden",
            textOverflow: "ellipsis",
            maxHeight: 150,
          }}
        >
          {props.harvest.product.description}
        </p>
        <p
          className="mb-0"
          style={{
            overflow: "hidden",
            textOverflow: "ellipsis",
            maxHeight: 100,
          }}
        >
          {" "}
          <strong>Mùa vụ: </strong> {props.harvest.name}
          <br />
          {props.harvest.description}
        </p>
      </div>
    </div>
  );
};

export default ProductDetail;

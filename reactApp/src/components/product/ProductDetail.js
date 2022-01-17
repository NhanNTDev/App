import { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import farmApi from "../../apis/farmApi";

const ProductDetail = (props) => {
  const [farm, setFarm] = useState({});

  useEffect(() => {
    const fetchFarm = async () => {
      const farmResponse = await farmApi.get(props.harvest.farmId);
      console.log(farmResponse);
      setFarm(farmResponse);
    };
    fetchFarm();
  }, []);

  return (
    <div className="shop-detail-right">
      <h2>{props.harvest.product.name}</h2>
      <p className="offer-price mb-0">
        <span className="mdi mdi-tag"></span>{" "}
        <span className="price-offer">
          {props.price.toLocaleString()}
          {" VNĐ / "}
          {props.unit}
        </span>
      </p>
      <h6>
        <strong>
          <span className="mdi mdi-approval"></span> Còn lại:
        </strong>{" "}
        {props.inventory} {props.unit}
      </h6>
      <h5>
        <i>
          <span className="mdi mdi-home-circle"></span> Nông trại:
        </i>{" "}
        {farm.name}
      </h5>
      <h5>
        <i>
          <span className="mdi mdi-map-marker"></span> Địa Chỉ:
        </i>{" "}
        {farm.address}
      </h5>
      <h5>
        <i>
          Đánh giá: <span className="mdi mdi-star" style={{color: '#ebd428'}} ></span>
          <span className="mdi mdi-star" style={{color: '#ebd428'}}></span>
          <span className="mdi mdi-star" style={{color: '#ebd428'}}></span>
          <span className="mdi mdi-star" style={{color: '#ebd428'}}></span>
        </i>{" "}
      </h5>

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

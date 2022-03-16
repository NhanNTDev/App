import { message, Space } from "antd";
import { useEffect, useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import { useNavigate } from "react-router-dom";
import farmApi from "../../apis/farmApi";
import { addToCartThunk } from "../../state_manager_redux/cart/cartSlice";

const ProductDetail = (props) => {
  const [farm, setFarm] = useState({});
  const [quantity, setQuantity] = useState(1);
  const user = useSelector((state) => state.user);
  const navigate = useNavigate();
  useEffect(() => {
    const fetchFarm = async () => {
      const farmResponse = await farmApi.get(props.harvest.farmId);
      setFarm(farmResponse);
    };
    fetchFarm();
  }, []);
  const dispatch = useDispatch();

  const decreaseQuantity = () => {
    setQuantity(quantity - 1);
  };

  const increaseQuantity = () => {
    setQuantity(quantity + 1);
  };

  const handleOnchangeQuantity = (e) => {
    if (e.target.validity.valid) {
      if (e.target.value > props.quantity) {
        setQuantity(props.quantity);
        return;
      }
      setQuantity(e.target.value);
    } else setQuantity(quantity);
  };

  const handleAddToCart = () => {
    if (user !== null) {
      const action = addToCartThunk({
        productId: props.id,
        customerId: user.id,
        quantity: quantity,
      });
      dispatch(action);
    } else {
      navigate(`/login?urlRedirect=/products/${props.campaignId}/${props.id}`);
    }
  };

  return (
    <div className="shop-detail-right">
      <h2>{props.productName}</h2>
      <p className="offer-price mb-0">
        <span className="mdi mdi-tag"></span>{" "}
        <span className="price-offer">
          <strong>
            {props.price.toLocaleString()}
            {" VNĐ / "}
            {props.unit}
          </strong>
        </span>
      </p>
      <h6>
        <strong>
          <span className="mdi mdi-approval"></span> Còn lại :
        </strong>{" "}
        {props.quantity} {props.unit}
      </h6>
      <h5>
        <i>
          <span className="mdi mdi-home-circle"></span> Nông trại :
        </i>{" "}
        {farm.name}
      </h5>
      <h5>
        <i>
          <span className="mdi mdi-map-marker"></span> Địa Chỉ :
        </i>{" "}
        {farm.address}
      </h5>
      

      <div className="qty">
        <div className="input-group" style={{ width: 250 }}>
          <h5>
            <i>Số lượng : </i>
          </h5>
          <button
            disabled={quantity === 1 ? "disabled" : null}
            className="btn-update-quantity-2"
            type="button"
            onClick={decreaseQuantity}
            style={{ marginLeft: 10 }}
          >
            -
          </button>
          <input
            value={quantity}
            type="text"
            pattern="^[1-9]{1}[0-9]*"
            onChange={(e) => handleOnchangeQuantity(e)}
            className="form-control border-form-control form-control-lg input-number"
            style={{ height: 30 }}
          />
          <button
            disabled={quantity === props.quantity ? "disabled" : null}
            className="btn-update-quantity-2"
            type="button"
            onClick={increaseQuantity}
          >
            +
          </button>
        </div>
      </div>

      <Space>
        <button
          type="button"
          className="btn btn-secondary btn-lg"
          onClick={handleAddToCart}
        >
          <i className="mdi mdi-cart-outline"></i> Thêm vào giỏ hàng
        </button>{" "}
      </Space>

      <div className="short-description">
        {props.unit !== props.unitOfSystem ? (
          <p>
            <strong>Quy cách đóng gói:</strong> 1 {props.unit} ={" "}
            {props.valueChangeOfUnit} {props.unitOfSystem}
          </p>
        ) : null}
        <h5>Mô tả:</h5>
        <p
          style={{
            overflow: "hidden",
            textOverflow: "ellipsis",
            maxHeight: 150,
          }}
        >
          {props.harvest.description}
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

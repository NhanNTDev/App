import { Modal, notification, Rate, Space, Tag, Spin } from "antd";
import { useEffect, useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import { Link, useNavigate } from "react-router-dom";
import farmApi from "../../apis/farmApi";
import { ExclamationCircleOutlined, LoadingOutlined } from "@ant-design/icons";
import { addToCartThunk } from "../../state_manager_redux/cart/cartSlice";
const { confirm } = Modal;

const ProductDetail = (props) => {
  console.log(props);
  const [farm, setFarm] = useState({});
  const [quantity, setQuantity] = useState(1);
  const user = useSelector((state) => state.user);
  const cart = useSelector((state) => state.cart);
  const antIcon = <LoadingOutlined style={{ fontSize: 24 }} spin />;
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();
  useEffect(() => {
    const fetchFarm = async () => {
      const farmResponse = await farmApi.get(props.farmId);
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
  function showAddOtherCampaignConfirm() {
    confirm({
      title: "Bạn đang mua hàng tại một chiến dịch khác",
      icon: <ExclamationCircleOutlined />,
      content: "Hành động này sẽ xóa giỏ hàng cũ của bạn khỏi hệ thống!",
      okText: "Xác nhận",
      okType: "danger",
      cancelText: "Hủy",
      onOk() {
        if (user !== null) {
          const action = addToCartThunk({
            productId: props.id,
            customerId: user.id,
            quantity: quantity,
          });
          dispatch(action);
        } else {
          navigate(
            `/login?urlRedirect=/products/${props.campaign.id}/${props.id}`
          );
        }
      },
      onCancel() {},
    });
  }
  const handleOnchangeQuantity = (e) => {
    if (e.target.validity.valid) {
      if (e.target.value > props.quantity) {
        notification.error({
          duration: 3,
          message: `${props.productName} chỉ còn lại ${props.quantity} ${props.unit}!`,
          style: { fontSize: 16 },
        });
        setQuantity(props.quantity);
      } else if (e.target.value !== "") {
        setQuantity(e.target.value);
      } else {
        setQuantity(1);
      }
    } else setQuantity(quantity);
  };

  const handleAddToCart = async () => {
    setLoading(true);
    if (cart !== null && props.campaign.id !== cart.campaignId) {
      showAddOtherCampaignConfirm();
    } else if (user !== null) {
      const action = addToCartThunk({
        productId: props.id,
        customerId: user.id,
        quantity: quantity,
      });
      await dispatch(action);
      setLoading(false);
    } else {
      navigate(`/login?urlRedirect=/products/${props.campaign.id}/${props.id}`);
    }
  };

  return (
    <div className="shop-detail-right">
      <h2 style={{ display: "inline", marginRight: 10 }}>
        {props.productName}
      </h2>{" "}
      {props.quantity === 0 && <Tag color="red">Hết hàng</Tag>}
      <Link style={{ fontSize: 16 }} to={`/productOrigin?id=${props.id}`}>
        Xem nguồn gốc
      </Link>
      <br />
      <br />
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
        {props.quantity} {props.unit} <Tag color='gold'>Đã bán {(props.inventory - props.quantity) + props.unit}</Tag>
      </h6>
      <h5>
        <i>
          <span className="mdi mdi-home-circle"></span> Nông trại :
        </i>{" "}
        {farm.name}{" "}
        {farm.totalStar !== 0 && ( <>
          <Rate value={farm.totalStar} allowHalf disabled={true}></Rate> {farm.totalStar + "/5"} </>
        )}
      </h5>
      <h5>
        <i>
          <span className="mdi mdi-map-marker"></span> Địa Chỉ :
        </i>{" "}
        {farm.address}
      </h5>
      <div className="qty" disabled={props.quantity === 0}>
        <div className="input-group" style={{ width: 250 }}>
          <h5>
            <i>Số lượng : </i>
          </h5>
          <button
            disabled={quantity <= 1 ? "disabled" : null}
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
            disabled={quantity >= props.quantity ? "disabled" : null}
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
          disabled={props.quantity === 0 || loading}
        >
          {loading ? (
            <>
              <Spin indicator={antIcon} style={{marginRight: 10}}/>
            </>
          ) : null}
          <i className="mdi mdi-cart-outline"></i> Thêm vào giỏ hàng
        </button>{" "}
      </Space>
      <div className="short-description">
        {props.unit !== props.systemUnit ? (
          <p>
            <strong>Quy cách đóng gói:</strong> 1 {props.unit} ={" "}
            {props.valueChangeOfUnit} {props.systemUnit}
          </p>
        ) : null}
        <p
          className="mb-0"
          style={{
            overflow: "hidden",
            textOverflow: "ellipsis",
            maxHeight: 100,
          }}
        >
          {" "}
          <strong>Mùa vụ: </strong> {props.harvestName}
          <br />
        </p>
        <h5>Mô tả:</h5>
        <p
          style={{
            overflow: "hidden",
            textOverflow: "ellipsis",
            maxHeight: 150,
          }}
        >
          {props.harvestDescription}
        </p>
      </div>
    </div>
  );
};

export default ProductDetail;

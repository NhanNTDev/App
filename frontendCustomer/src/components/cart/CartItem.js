import { Checkbox, notification, Modal } from "antd";
import React, { useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import {ExclamationCircleOutlined} from '@ant-design/icons'
import { Link } from "react-router-dom";
import {
  checkCartItem,
  removeFromCart,
  setQuantity,
} from "../../state_manager_redux/cart/cartSlice";
const { confirm } = Modal;
const CartItem = ({ item, campaignId }) => {
  const dispatch = useDispatch();
  const [cartItemQuantity, setCartItemQuantity] = useState(item.quantity);
  const user = useSelector((state) => state.user);

  const hanldeRemoveItem = () => {
    const action = removeFromCart({
      harvestCampaignId: item.id,
      customerId: user.id,
    });
    dispatch(action);
  };

  const hanldeUpdateQuantity = ({ newQuantity }) => {
    setCartItemQuantity(newQuantity);
    const action = setQuantity({
      newQuantity: newQuantity,
      harvestCampaignId: item.id,
      customerId: user.id,
    });
    dispatch(action);
  };
  function showDeleteConfirm() {
    confirm({
      title: "Xác nhận xóa sản phẩm khỏi giỏ hàng!",
      icon: <ExclamationCircleOutlined />,
      content:
        "Sản phẩm này đã hết hàng, bạn có muốn xóa sản phẩm ra khỏi giỏ hàng?",
      okText: "Xóa",
      okType: "danger",
      cancelText: "Hủy",
      onOk() {
        const action = removeFromCart({
          harvestCampaignId: item.id,
          customerId: user.id,
        });
        dispatch(action);
      },
      onCancel() {},
    });
  }
  const handleOnchangeQuantity = (e) => {
    if (e.target.validity.valid) {
      if (e.target.value > item.maxQuantity) {
        if (item.maxQuantity === 0) {
          showDeleteConfirm();
        } else {
          notification.error({
            duration: 3,
            message: `${item.productName} chỉ còn lại ${item.maxQuantity} ${item.unit}!`,
          });
          setCartItemQuantity(item.maxQuantity);
          const action = setQuantity({
            newQuantity: item.maxQuantity,
            harvestCampaignId: item.id,
            customerId: user.id,
          });
          dispatch(action);
        }
      } else if (e.target.value !== "") {
        setCartItemQuantity(e.target.value);
        const action = setQuantity({
          newQuantity: parseInt(e.target.value),
          harvestCampaignId: item.id,
          customerId: user.id,
        });
        dispatch(action);
      } else {
        setCartItemQuantity(1);
        const action = setQuantity({
          newQuantity: 1,
          harvestCampaignId: item.id,
          customerId: user.id,
        });
        dispatch(action);
      }
    } else setCartItemQuantity(cartItemQuantity);
  };

  const handleCheckbox = () => {
    const action = checkCartItem({
      harvestCampaignId: item.id,
      currentValue: item.checked,
    });
    dispatch(action);
  };

  return (
    <tr>
      <td className="cart_checkbox">
        <Checkbox checked={item.checked} onChange={handleCheckbox} />
      </td>
      <td className="cart_product">
        <a href="#">
          <img alt="Product" src={item.image} />
        </a>
      </td>
      <td className="cart_description">
        <Link to={`/products/${campaignId}/${item.id}`}>
          <h5 className="product_name">{item.productName}</h5>
        </Link>
      </td>
      <td className="price">
        <span>{item.price.toLocaleString()} VNĐ</span>
      </td>
      <td className="qty">
        <div className="input-group">
          <button
            disabled={item.quantity <= 1 ? "disabled" : null}
            className="btn-update-quantity"
            type="button"
            onClick={() =>
              hanldeUpdateQuantity({
                newQuantity: item.quantity - 1,
              })
            }
          >
            -
          </button>
          <input
            value={cartItemQuantity}
            type="text"
            pattern="^[1-9]{1}[0-9]*"
            onChange={(e) => handleOnchangeQuantity(e)}
            className="form-control border-form-control form-control-lg input-number"
          />
          <button
            className="btn-update-quantity"
            type="button"
            disabled={item.quantity >= item.maxQuantity ? "disabled" : null}
            onClick={() =>
              hanldeUpdateQuantity({
                newQuantity: item.quantity + 1,
              })
            }
          >
            +
          </button>
        </div>
      </td>
      <td className="productUnit">
        <span>{item.unit}</span>
      </td>
      <td className="total_item">
        <span>{item.total.toLocaleString()} VNĐ</span>
      </td>
      <td className="action text-center">
        <button
          className="btn btn-sm btn-danger"
          data-original-title="Remove"
          onClick={hanldeRemoveItem}
        >
          {/* <i className="mdi mdi-close-circle-outline"></i> */}
          Xóa
        </button>
      </td>
    </tr>
  );
};

export default CartItem;

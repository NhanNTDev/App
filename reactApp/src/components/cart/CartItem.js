import { Checkbox } from "antd";
import React, { useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import { Link } from "react-router-dom";
import {
  checkCartItem,
  removeFromCart,
  setQuantity,
} from "../../state_manager_redux/cart/cartSlice";

const CartItem = ({item, campaignId}) => {
  const dispatch = useDispatch();
  const [cartItemQuantity, setCartItemQuantity] = useState(
    item.quantity
  );
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
      customerId: user.id
    });
    dispatch(action);
  };

  const handleOnchangeQuantity = (e) => {
    if (e.target.validity.valid) {
      setCartItemQuantity(e.target.value);
      if (e.target.value !== "") {
        const action = setQuantity({
          newQuantity: parseInt(e.target.value),
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
    console.log("check nè")
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
            disabled={
              item.quantity === 1 ? "disabled" : null
            }
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

import { Checkbox } from "antd";
import React, { useState } from "react";
import { useDispatch } from "react-redux";
import {
  removeFromCart,
  setQuantity,
} from "../../state_manager_redux/cart/cartSlice";

const CartItem = (props) => {
  const dispatch = useDispatch();
  const [cartItemQuantity, setCartItemQuantity] = useState(
    props.itemCarts[0].quantity
  );
  const hanldeRemoveItem = () => {
    const action = removeFromCart({
      campaignId: props.campaignId,
      productId: props.id,
      itemCartId: props.itemCarts[0].id,
    });
    dispatch(action);
  };
  const hanldeUpdateQuantity = ({ newQuantity }) => {
    setCartItemQuantity(newQuantity);
    const action = setQuantity({
      campaignId: props.campaignId,
      productId: props.id,
      newQuantity: newQuantity,
      itemCartId: props.itemCarts[0].id,
    });
    dispatch(action);
  };

  const handleOnchangeQuantity = (e) => {
    if (e.target.validity.valid) {
      setCartItemQuantity(e.target.value);
      if (e.target.value !== "") {
        const action = setQuantity({
          campaignId: props.campaignId,
          productId: props.id,
          newQuantity: parseInt(e.target.value),
          itemCartId: props.itemCarts[0].id,
        });
        dispatch(action);
      }
    } else setCartItemQuantity(cartItemQuantity);
  };
  return (
    <tr>
      <td className="cart_checkbox">
        <Checkbox />
      </td>
      <td className="cart_product">
        <a href="#">
          <img alt="Product" src={props.harvest.product.image1} />
        </a>
      </td>
      <td className="cart_description">
        <h5 className="product_name">{props.productName}</h5>
      </td>
      <td className="price">
        <span>{props.price.toLocaleString()} VNĐ</span>
      </td>
      <td className="qty">
        <div className="input-group">
          <button
            disabled={props.itemCarts[0].quantity === 1 ? "disabled" : null}
            className="btn-update-quantity"
            type="button"
            onClick={() =>
              hanldeUpdateQuantity({
                newQuantity: props.itemCarts[0].quantity - 1,
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
                newQuantity: props.itemCarts[0].quantity + 1,
              })
            }
          >
            +
          </button>
        </div>
      </td>
      <td className="productUnit">
        <span>{props.unit}</span>
      </td>
      <td className="total_item">
        <span>{props.itemCarts[0].total.toLocaleString()} VNĐ</span>
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

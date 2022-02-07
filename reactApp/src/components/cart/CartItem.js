import { Checkbox } from "antd";
import React from "react";
import { useDispatch } from "react-redux";
import {
  removeFromCart,
  setQuantity,
} from "../../state_manager_redux/cart/cartSlice";

const CartItem = (props) => {
  const dispatch = useDispatch();
  const hanldeRemoveItem = () => {
    const action = removeFromCart({
      campaignId: props.campaignId,
      productId: props.id,
      itemCartId: props.itemCarts[0].id,
    });
    dispatch(action);
  };
  const hanldeUpdateQuantity = ({ newQuantity }) => {
    const action = setQuantity({
      campaignId: props.campaignId,
      productId: props.id,
      newQuantity: newQuantity,
      itemCartId: props.itemCarts[0].id,
    });
    dispatch(action);
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
          <span className="input-group-btn">
            <button
              disabled={props.itemCarts[0].quantity === 1 ? "disabled" : null}
              className="btn btn-theme-round btn-number"
              type="button"
              onClick={() =>
                hanldeUpdateQuantity({
                  newQuantity: props.itemCarts[0].quantity - 1,
                })
              }
            >
              -
            </button>
          </span>
          <input
            value={props.itemCarts[0].quantity}
            className="form-control border-form-control form-control-sm input-number"
          />
          <span className="input-group-btn">
            <button
              className="btn btn-theme-round btn-number"
              type="button"
              onClick={() =>
                hanldeUpdateQuantity({
                  newQuantity: props.itemCarts[0].quantity + 1,
                })
              }
            >
              +
            </button>
          </span>
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
          <i className="mdi mdi-close-circle-outline"></i>
        </button>
      </td>
    </tr>
  );
};

export default CartItem;

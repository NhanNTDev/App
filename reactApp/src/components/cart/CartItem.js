import { Checkbox } from "antd";
import React from "react";

const CartItem = (props) => {
  console.log(props);
  return (
    <tr>
      <td className="cart_checkbox">
        <Checkbox />
      </td>
      <td className="cart_product">
        <a href="#"><img alt="Product" src={props.harvest.product.image1} /></a>
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
              disabled="disabled"
              className="btn btn-theme-round btn-number"
              type="button"
            >
              -
            </button>
          </span>
          <input
            type="Number"
            min="1"
            max="10"
              value={props.itemCarts[0].quantity}
            className="form-control border-form-control form-control-sm input-number"
          />
          <span className="input-group-btn">
            <button className="btn btn-theme-round btn-number" type="button">
              +
            </button>
          </span>
        </div>
      </td>
      <td className="productUnit"><span>{props.unit}</span></td>
      <td className="total_item">
        <span>
          {props.itemCarts[0].total.toLocaleString()} VNĐ
        </span>
      </td>
      <td className="action text-center">
        <a
          className="btn btn-sm btn-danger"
          data-original-title="Remove"
          href="#"
          title=""
          data-placement="top"
          data-toggle="tooltip"
        >
          <i className="mdi mdi-close-circle-outline"></i>
        </a>
      </td>
    </tr>
  );
};

export default CartItem;

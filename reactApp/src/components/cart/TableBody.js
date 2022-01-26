import React from "react";
import CartItem from "./CartItem";

const TableBody = (props) => {
  console.log(props);
  return (
    <>
      {props.farm.map(item => <CartItem {...item}/>)}
      <tr>
        <td colSpan="8">
          <div className="cart-farm-header">
            <h5>{props.farm[0].harvest.farm.name}</h5>
            <h6>
              <i>
                <span className="mdi mdi-map-marker"></span> Địa Chỉ:
              </i>{" "}
              {/* {props.address} */}
            </h6>
            <h6>
              <i>
                Đánh giá:{" "}
                <span
                  className="mdi mdi-star"
                  style={{ color: "#ebd428" }}
                ></span>
                <span
                  className="mdi mdi-star"
                  style={{ color: "#ebd428" }}
                ></span>
                <span
                  className="mdi mdi-star"
                  style={{ color: "#ebd428" }}
                ></span>
                <span
                  className="mdi mdi-star"
                  style={{ color: "#ebd428" }}
                ></span>
              </i>{" "}
            </h6>
          </div>
        </td>
      </tr>
    </>
  );
};

export default TableBody;

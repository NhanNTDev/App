import React from "react";
import CartItem from "./CartItem";

const TableBody = ({farm, campaignId}) => {
  return (
    <>
      
      <tr>
        <td colSpan="8">
          <div className="cart-farm-header">
            <h5>{farm.name}</h5>
            <h6>
              <i>
                <span className="mdi mdi-map-marker"></span> Địa Chỉ:
              </i>{" "}
              {farm.address}
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
      {farm.harvestInCampaigns.map((item) => (
        <CartItem key={item.id} item={item} campaignId={campaignId} />
      ))}
    </>
  );
};

export default TableBody;

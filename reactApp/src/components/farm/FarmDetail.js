import React from "react";

const FarmDetail = (props) => {
  return (
    <div className="shop-detail-right">
      <h2>{props.farm.name}</h2>
      <h6>
        <span className="mdi mdi-map-marker"></span> Địa chỉ: {props.farm.address}
      </h6>
      <h6>
        <span className="mdi mdi-phone"></span> Số Điện Thoại: {props.farm.phone}
      </h6>
      <div className="short-description">
        <h5>
          Mô tả:
        </h5>
        <p style={{overflow: "hidden", textOverflow: "ellipsis", maxHeight: 150}}>{props.farm.description}</p>
        <p className="mb-0" style={{overflow: "hidden", textOverflow: "ellipsis", maxHeight: 100}}>
          {" "}
          <strong>Sản phẩm nổi bật: </strong> Hồng giòn Đà Lạt
          <br />
        </p>
      </div>
      {/* <Link to="/checkout">
        <button type="button" className="btn btn-secondary btn-lg">
          <i className="mdi mdi-cart-outline"></i> Tham Gia Chiến Dịch
        </button>{" "}
      </Link> */}
    </div>
  );
};

export default FarmDetail;

import React from "react";

const FarmDetail = (props) => {
  return (
    <div className="shop-detail-right">
      <h2>Tên Nông Trại</h2>
      <h6>
        <span className="mdi mdi-map-marker"></span> Địa chỉ
      </h6>
      <h6>
        <span className="mdi mdi-phone"></span> Số Điện Thoại:{" "}
      </h6>
      <div className="short-description">
        <h5>
          Mô tả:
        </h5>
        <p style={{overflow: "hidden", textOverflow: "ellipsis", maxHeight: 150}}>Đât là phần mô tả nông trại</p>
        <p className="mb-0" style={{overflow: "hidden", textOverflow: "ellipsis", maxHeight: 100}}>
          {" "}
          <strong>Sản phẩm nổi bật: </strong> aaaaaaa
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

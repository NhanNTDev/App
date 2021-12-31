import { Link } from "react-router-dom";

const CampaignDetail = (props) => {
  return (
    <div className="shop-detail-right">
      <span className="badge badge-success">50% OFF</span>
      <h2>{props.campaign.name}</h2>
      <h6>
          <span className="mdi mdi-timer"></span> Từ thứ 2 đến thứ 5 hàng tuần
      </h6>
      <h6>
          <span className="mdi mdi-corn"></span> Tổng nông trại tham gia: {props.campaign.farmJoined}
      </h6>
      <p className="offer-price mt-2">
        <span className="mdi mdi-tag">Giá ưu đãi</span>
      </p>
      <p className="offer-price mt-2">
        <span className="mdi mdi-truck">Giao hàng nhanh gọn</span>
      </p>
      <p className="offer-price mt-2">
        <span className="mdi mdi-approval">Sản phẩm tươi ngon</span>
      </p>
      {/* <Link to="/checkout">
        <button type="button" className="btn btn-secondary btn-lg">
          <i className="mdi mdi-cart-outline"></i> Tham Gia Chiến Dịch
        </button>{" "}
      </Link> */}
    </div>
  );
};

export default CampaignDetail;

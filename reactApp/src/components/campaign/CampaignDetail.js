import { Link } from "react-router-dom";

const CampaignDetail = (props) => {
  return (
    <div className="shop-detail-right">
      <span className="badge badge-success">50% OFF</span>
      <h2>{props.campaign.name}</h2>
      <h6>
        <strong>
          <span className="mdi mdi-approval"></span> Ưu đãi khi mua trên
        </strong>{" "}
        - 100 kg
      </h6>
      <p className="regular-price">
        <i className="mdi mdi-tag-outline"></i> MRP : $800.99
      </p>
      <p className="offer-price mb-0">
        Giá ưu đãi : <span className="text-success">$450.99</span>
      </p>
      <Link to="/checkout">
        <button type="button" className="btn btn-secondary btn-lg">
          <i className="mdi mdi-cart-outline"></i> Tham Gia Chiến Dịch
        </button>{" "}
      </Link>
    </div>
  );
};

export default CampaignDetail;

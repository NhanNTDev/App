import { Empty } from "antd";
import { Link } from "react-router-dom";
import CampaignSliderItem from "./CampaignSliderItem";

const CampaignSlider = (props) => {
  return (
    <section className="product-items-slider section-padding">
      <div className="container">
        <div className="section-header">
          <h5 className="heading-design-h5">
            {props.title}{" "}
            {props.type === "Hàng tuần" ?<span className="badge badge-primary">Dành cho bạn</span> : (
              <span className="badge badge-primary">Nổi bật</span>
            )}
            <Link
              className="float-right text-secondary"
              to={`/all-campaigns?type=${props.type}`}
            >
              Xem tất cả
            </Link>
          </h5>
        </div>
        <div className="owl-carousel owl-carousel-featured">
          {Object.entries(props.listCampaigns).length !== 0 &&
            props.listCampaigns &&
            props.listCampaigns.map((campaign) => (
              <CampaignSliderItem key={campaign.id} {...campaign} />
            ))}
        </div>
        {Object.entries(props.listCampaigns).length === 0 && (
          <div className="d-flex justify-content-center">
            <Empty description={`Không có chiến dịch ${props.type} nào tại vị trí của bạn!`}></Empty>
          </div>
        )}
      </div>
    </section>
  );
};

export default CampaignSlider;

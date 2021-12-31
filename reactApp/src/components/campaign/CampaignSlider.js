import { Link } from "react-router-dom";
import CampaignSliderItem from "./CampaignSliderItem";

const CampaignSlider = (props) => {
  return (
    <section className="product-items-slider section-padding">
      <div className="container">
        <div className="section-header">
          <h5 className="heading-design-h5">
            {props.title}{" "}
            {props.type === "other" && (
              <span className="badge badge-primary">Đang hot</span>
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
          {props.listCampaigns &&
            props.listCampaigns.map((campaign) => (
              <CampaignSliderItem {...campaign} />
            ))}
        </div>
      </div>
    </section>
  );
};

export default CampaignSlider;

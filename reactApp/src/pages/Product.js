import CampaignSlider from "../components/campaign/CampaignSlider";
import ProductDetail from "../components/product/ProductDetail";
import ProductPicture from "../components/product/ProductPicture";
import { hotCampaign } from "../constants/Data";
import { runScript } from "../utils/Common";

const Product = () => {
  const hotCampaigns = hotCampaign;
  runScript();
  return (
    <>
      <section className="pt-3 pb-3 page-info section-padding border-bottom bg-white">
        <div className="container">
          <div className="row">
            <div className="col-md-12">
              <a href="#">
                <strong>
                  <span className="mdi mdi-home"></span> Trang chủ
                </strong>
              </a>{" "}
              <span className="mdi mdi-chevron-right"></span>{" "}
              <a href="#">Đà  Lạt - Hồ Chí Minh</a>
              <span className="mdi mdi-chevron-right"></span>{" "}
              <a href="#">Nguyễn Thành Nhân Farm</a>
              <span className="mdi mdi-chevron-right"></span> <span>Hồng giòn Đà Lạt</span>
            </div>
          </div>
        </div>
      </section>
      <section className="shop-single section-padding pt-3">
        <div className="container">
          <div className="row">
            <div className="col-md-6">
              <ProductPicture/>
            </div>
            <div className="col-md-6">
              <ProductDetail/>
            </div>
          </div>
        </div>
      </section>
      <CampaignSlider title="Chiến dịch khác" listCampaigns={hotCampaigns} type="other"></CampaignSlider>
    </>
  );
};

export default Product;

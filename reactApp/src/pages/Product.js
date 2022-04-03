import { useEffect, useState } from "react";
import ProductDetail from "../components/product/ProductDetail";
import ProductPicture from "../components/product/ProductPicture";
import harvestCampaignApi from "../apis/harvestCampaignApi";
import { useParams } from "react-router-dom";

const Product = () => {
  const params = useParams();
  const [harvestCampaign, setHarvestCampaign] = useState(null);

  useEffect(() => {
    const fetchProducts = async () => {
      const harvestsResponse = await harvestCampaignApi.get(params.productId);
      setHarvestCampaign(harvestsResponse);
    };
    fetchProducts();
  }, []);

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
              <a href="#">{harvestCampaign && harvestCampaign.campaign.name}</a>
              <span className="mdi mdi-chevron-right"></span>{" "}
              <a href="#">{harvestCampaign && harvestCampaign.productName}</a>
            </div>
          </div>
        </div>
      </section>
      <section className="shop-single section-padding pt-3">
        <div className="container">
          <div className="row">
            <div className="col-md-4">
              {harvestCampaign && <ProductPicture {...harvestCampaign} />}
            </div>
            <div className="col-md-8">
              {harvestCampaign && <ProductDetail {...harvestCampaign} />}
            </div>
          </div>
        </div>
      </section>
      {/* {harvests.length > 0 ? (
        <ProductSlider
          title="Sản phẩm khác trong nông trại"
          listProduct={harvests.filter(c => c.id.toString() !== params.productId)}
        />
      ) : null} */}
    </>
  );
};

export default Product;

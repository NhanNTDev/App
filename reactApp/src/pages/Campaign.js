import { useEffect, useState } from "react";

import { Link, useParams } from "react-router-dom";
import CampaignPicture from "../components/campaign/CampaignPicture";
import CampaignDetail from "../components/campaign/CampaignDetail";
import campaignsApi from "../apis/campaignsApi";
import ProductList from "../components/product/ProductList";
import Skeleton from "react-loading-skeleton";
import "react-loading-skeleton/dist/skeleton.css";
import { deleteScript, runScript } from "../utils/Common";

const Campaign = () => {
  const params = useParams();
  const [campaign, setCampaign] = useState(null);
  const [loading, setLoading] = useState(true);
  const campaignId = params.id;

  useEffect(() => {
    const fetchCampaign = async () => {
      const campaignResponse = await campaignsApi.get(campaignId);
      setCampaign(campaignResponse);
      setLoading(false);
      deleteScript();
      runScript();
    };
    fetchCampaign();
  }, []);

  return (
    <>
      <section className="pt-3 pb-3 page-info section-padding border-bottom bg-white">
        <div className="container">
          <div className="row">
            <div className="col-md-12">
              <Link to="/home">
                <strong>
                  <span className="mdi mdi-home"></span> Trang chủ
                </strong>
              </Link>{" "}
              <span className="mdi mdi-chevron-right"></span>{" "}
              <a href="#">{campaign !== null ? campaign.name : ""}</a>
            </div>
          </div>
        </div>
      </section>
      <section className="shop-single section-padding pt-3">
        <div className="container">
          <div className="row">
            <div className="col-md-4">
              <CampaignDetail campaign={{ ...campaign }} />
              <CampaignPicture campaign={{ ...campaign }} />
            </div>
            <div className="col-md-8">
              {loading === true ? (
                <Skeleton count={8} width="50%" inline={true} height={250} />
              ) : (
                <ProductList campaignId={params.id} />
              )}
            </div>
          </div>
        </div>
      </section>
    </>
  );
};

export default Campaign;

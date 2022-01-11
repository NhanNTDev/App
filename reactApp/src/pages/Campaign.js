import { useLayoutEffect, useEffect, useState } from "react";

import { useParams } from "react-router-dom";
import { runScript, deleteScript } from "../utils/Common";
import * as campaignsService from "../apis/campaign-service";
import CampaignPicture from "../components/campaign/CampaignPicture";
import CampaignDetail from "../components/campaign/CampaignDetail";
import ListFarms from "../components/farm/ListFarms";
import campaignsApi from "../apis/campaignsApi";

const Campaign = () => {
  const params = useParams();
  const [campaign, setCampaign] = useState(null);
  const campaignId = params.id;

  useEffect(() => {
    deleteScript();
  }, []);

  useEffect(() => {
    const fetchCampaign = async () => {
      const campaignResponse = await campaignsApi.get(campaignId);
      setCampaign(campaignResponse);
    };
    fetchCampaign();
    runScript();

  }, []);


  return (
    <>
      <section className="pt-3 pb-3 page-info section-padding border-bottom bg-white">
        <div className="container">
          <div className="row">
            <div className="col-md-12">
              <a href="#">
                <strong>
                  <span className="mdi mdi-home"></span> Home
                </strong>
              </a>{" "}
              <span className="mdi mdi-chevron-right"></span>{" "}
              <a href="#">Campaign</a>{" "}
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
              <CampaignPicture campaign={{ ...campaign }} />
              <CampaignDetail campaign={{ ...campaign }} />
            </div>
            <div className="col-md-8">
              <ListFarms campaignId={campaignId}/>
            </div>
          </div>
        </div>
      </section>
    </>
  );
};

export default Campaign;

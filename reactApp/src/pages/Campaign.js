import { useLayoutEffect, useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import { runScript, deleteScript } from "../utils/Common";
import * as campaignsService from "../apis/campaign-service";
import CampaignPicture from "../components/campaign/CampaignPicture";
import CampaignDetail from "../components/campaign/CampaignDetail";
import FarmList from "../components/farm/FarmList";

const Campaign = () => {
  const param = useParams();
  const [campaign, setCampaign] = useState(null);

  useEffect(() => {
    deleteScript();
  }, []);

  useLayoutEffect(() => {
    const fetchCampaigns = async () => {
      const campaignsResponse = await campaignsService.getCampaigns();
      setCampaign(campaignsResponse.find((c) => c.id.toString() === param.id));
    };
    fetchCampaigns();
    runScript();
    // return () => {
    //   deleteScript();
    // }

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
              <FarmList campaignId={param.id}/>
            </div>
          </div>
        </div>
      </section>
    </>
  );
};

export default Campaign;

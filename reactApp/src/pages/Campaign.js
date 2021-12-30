import { useLayoutEffect, useEffect, useState } from "react";
import { useLocation } from "react-router-dom";
import CampaignSlider from "../components/campaign/CampaignSlider";
import { runScript, deleteScript } from "../utils/Common";
import * as campaignsService from "../services/campaign-service";
import * as farmsService from "../services/farm-service";
import CampaignPicture from "../components/campaign/CampaignPicture";
import CampaignDetail from "../components/campaign/CampaignDetail";
import FarmGroup from "../components/farm/FarmGroup";
import ViewAllCampaigns from "./ViewAllCampaigns";
import ListFarms from "../components/farm/ListFarms";

const Campaign = () => {
  const location = useLocation();
  const [campaigns, setCampaigns] = useState([]);
  const path = location.pathname.split("/")[2];
  const [campaign, setCampaign] = useState(null);
  const [farms, setFarms] = useState([]);

  useEffect(() => {
    deleteScript();
  }, []);

  useLayoutEffect(() => {
    const fetchCampaigns = async () => {
      const campaignsResponse = await campaignsService.getCampaigns();
      setCampaigns(campaignsResponse);
      setCampaign(campaignsResponse.find((c) => c.id.toString() === path));
    };
    fetchCampaigns();
    // return () => {
    //   deleteScript();
    // }
  }, []);

  useLayoutEffect(() => {
    const fetchFarms = async () => {
      const farmsResponse = await farmsService.getAllFarms();
      setFarms(farmsResponse);
      runScript();
    };
    fetchFarms();
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
              {/* <CampaignDetail campaign={{ ...campaign }} /> */}
              <ListFarms/>
            </div>
          </div>
        </div>
      </section>
    </>
  );
};

export default Campaign;

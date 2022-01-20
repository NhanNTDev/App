import CenterBanner from "../components/home/CenterBanner";
import CampaignSlider from "../components/campaign/CampaignSlider";
import TopCategory from "../components/home/TopCategory";
import { runScript, deleteScript } from "../utils/Common";
import { useState, useEffect } from "react";
import TopBanner from "../components/home/TopBanner";
import campaignsApi from "../apis/campaignsApi";
import categoriesApi from "../apis/categoriesApi";

const Home = () => {
  const [weeklyCampaigns, setWeeklyCampaigns] = useState([]);
  const [hotCampaigns, setHotCampaign] = useState([]);

  const [categories, setCategories] = useState([]);
  useEffect(() => {
    deleteScript();
  }, []);

  useEffect(() => {
    const fetchCategories = async () => {
      const categoriesResponse = await categoriesApi.getAll();
      setCategories(categoriesResponse.data);
    };
    fetchCategories();
  }, []);

  useEffect(() => {
    const params = {
      page: 1,
      size: 10,
    };
    const fetchCampaigns = async () => {
      const campaigns = await campaignsApi.getAll(params);
      setWeeklyCampaigns(campaigns.data);
      setHotCampaign(campaigns.data);
      runScript();
    };
    fetchCampaigns();
  }, []);

  return (
    <>
      <TopBanner />
      <TopCategory listCategories={categories}></TopCategory>
      <CampaignSlider
        title="Chiến dịch trong tuần"
        listCampaigns={weeklyCampaigns}
        type="weekly"
      ></CampaignSlider>
      <CenterBanner />
      <CampaignSlider
        title="Chiến dịch khác"
        listCampaigns={hotCampaigns}
        type="other"
      ></CampaignSlider>
    </>
  );
};

export default Home;

import CenterBanner from "../components/home/CenterBanner";
import CampaignSlider from "../components/campaign/CampaignSlider";
import TopCategory from "../components/home/TopCategory";
import { runScript, deleteScript } from "../utils/Common";
import { useLayoutEffect, useState, useEffect } from "react";
import * as categoryService from "../apis/category-service";
import * as campaignsService from "../apis/campaign-service";
import TopBanner from "../components/home/TopBanner";
import campaignsApi from "../apis/campaignsApi";


const Home = () => {
  const [weeklyCampaigns, setWeeklyCampaigns] = useState([]);
  const [hotCampaigns, setHotCampaign] = useState([]);

  const [categories, setCategories] = useState([]);
  //Delete Script element of casourel
  useEffect(()=> {
    deleteScript();
  }, []);

  useEffect(() => {
    const fetchCategories = async () => {
      const categoryResponse = await categoryService.getAllCategoriesAPI();
      setCategories(categoryResponse);
    };

    fetchCategories();
  }, []);

  useEffect(() => {
    const fetchCampaigns = async () => {
      const campaigns = await campaignsService.getCampaigns();
      // const campaigns = await campaignsApi.get();
      setWeeklyCampaigns(campaigns);
      setHotCampaign(campaigns);
      runScript();
    };

    fetchCampaigns();
  }, []);
  useEffect(() => {
    const fetchCampaigns = async () => {
      const params = {
        page: 1,
        size: 12,
      }
      // const campaigns = await campaignsService.getCampaigns();
      const campaigns = await campaignsApi.getAll(params);
      console.log("call api:")
      console.log(campaigns);
      // setWeeklyCampaigns(campaigns);
      // setHotCampaign(campaigns);
      // runScript();
    };

    fetchCampaigns();
  }, []);




  return (
    <>
      <TopBanner/>
      <TopCategory listCategories={categories}></TopCategory>
      <CampaignSlider
        title="Chiến dịch trong tuần"
        listCampaigns={weeklyCampaigns}
        type="weekly"
      ></CampaignSlider>
      <CenterBanner/>
      <CampaignSlider
        title="Chiến dịch khác"
        listCampaigns={hotCampaigns}
        type="other"
      ></CampaignSlider>
    </>
  );
};

export default Home;

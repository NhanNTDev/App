import Banner from "../components/Banner";
import CenterBanner from "../components/CenterBanner";
import ItemGroup from "../components/ItemGroup";
import TopCategory from "../components/TopCategory";
import { runScript } from "../utils/Common";
import { useLayoutEffect, useState, useEffect } from "react";
import * as categoryService from "../services/category-service";
import * as campaignsService from "../services/campaign-service";

const Home = () => {
  const [weeklyCampaigns, setWeeklyCampaigns] = useState([]);
  const [hotCampaigns, setHotCampaign] = useState([]);

  const [categories, setCategories] = useState([]);

  useEffect(() => {
    const fetchCategories = async () => {
      const categoryResponse = await categoryService.getAllCategoriesAPI();
      setCategories(categoryResponse);
      console.log("useEffect1")
    };
    fetchCategories();
  }, []);

  useEffect(() => {
    const fetchCampaigns = async () => {
      const campaigns = await campaignsService.getCampaigns();
      setWeeklyCampaigns(campaigns);
      setHotCampaign(campaigns);
      runScript();
      console.log("useEffect2")
    };

    fetchCampaigns();
  }, []);

  return (
    <>
      <Banner></Banner>
      <TopCategory listCategories={categories}></TopCategory>
      <ItemGroup
        title="Chiến dịch trong tuần"
        listCampaigns={weeklyCampaigns}
        type="weekly"
      ></ItemGroup>
      <CenterBanner></CenterBanner>
      <ItemGroup
        title="Chiến dịch hot"
        listCampaigns={hotCampaigns}
        type="hot"
      ></ItemGroup>
    </>
  );
};

export default Home;

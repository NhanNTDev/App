import Banner from "../components/Banner";
import CenterBanner from "../components/CenterBanner";
import ItemGroup from "../components/ItemGroup";
import TopCategory from "../components/TopCategory";
import { runScript } from "../utils/Common";
import { weeklyCampaign, hotCampaign } from "../constants/Data";
import { useLayoutEffect, useState } from "react";
import * as categoryService from "../services/category-service";


const Home = () => {
    runScript()
    const weeklyCampaigns = weeklyCampaign;
    const hotCampaigns = hotCampaign;

    const [categories, setCategories] = useState([]);

  useLayoutEffect(() => {
    const fetChCategories = async () => {
      const categoryResponse = await categoryService.getAllCategoriesAPI();
      setCategories(categoryResponse);
    };
    fetChCategories();
    console.log(categories)
  }, [])
    
    return (
        <>
            <Banner></Banner>
            <TopCategory categories></TopCategory>
            <ItemGroup title="Chiến dịch trong tuần" listCampaigns={weeklyCampaigns} type="weekly"></ItemGroup>
            <CenterBanner></CenterBanner>
            <ItemGroup title="Chiến dịch hot" listCampaigns={hotCampaigns} type="hot"></ItemGroup>
        </>

    )
}

export default Home;
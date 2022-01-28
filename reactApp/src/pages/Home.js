import CenterBanner from "../components/home/CenterBanner";
import CampaignSlider from "../components/campaign/CampaignSlider";
import TopCategory from "../components/home/TopCategory";
import { runScript, deleteScript } from "../utils/Common";
import { useState, useEffect } from "react";
import TopBanner from "../components/home/TopBanner";
import campaignsApi from "../apis/campaignsApi";
import categoriesApi from "../apis/categoriesApi";
import cartApi from "../apis/cartApi";
import { useDispatch } from "react-redux";
import { setCart } from "../state_manager_redux/cart/cartSlice";

const Home = () => {
  const [weeklyCampaigns, setWeeklyCampaigns] = useState([]);
  const [hotCampaigns, setHotCampaign] = useState([]);

  const [categories, setCategories] = useState([]);
  const dispatch = useDispatch();
  useEffect(() => {
    deleteScript();
  }, []);
  // Get cart from server
  useEffect(() => {
    const fetchCartItems = async () => {
      const cartItemsResponse = await cartApi.getAll();
      console.log(cartItemsResponse);
      const action = setCart(cartItemsResponse);
      dispatch(action);
      // setCart(cartItemsResponse);
    };
    fetchCartItems();
  }, []);
  // Get category
  useEffect(() => {
    const fetchCategories = async () => {
      const categoriesResponse = await categoriesApi.getAll();
      setCategories(categoriesResponse.data);
    };
    fetchCategories();
  }, []);
  // Get campaign
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

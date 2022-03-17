import CenterBanner from "../components/home/CenterBanner";
import CampaignSlider from "../components/campaign/CampaignSlider";
import TopCategory from "../components/home/TopCategory";
import { runScript, deleteScript } from "../utils/Common";
import { useState, useEffect } from "react";
import TopBanner from "../components/home/TopBanner";
import campaignsApi from "../apis/campaignsApi";
import categoriesApi from "../apis/categoriesApi";
import cartApi from "../apis/cartApi";
import { useDispatch, useSelector } from "react-redux";
import { setCart } from "../state_manager_redux/cart/cartSlice";
import { Spin } from "antd";
import { LoadingOutlined } from "@ant-design/icons";

const Home = () => {
  const [weeklyCampaigns, setWeeklyCampaigns] = useState([]);
  const [hotCampaigns, setHotCampaign] = useState([]);
  const [categories, setCategories] = useState([]);
  const [loading, setLoading] = useState(true);
  const address = useSelector((state) => state.location);
  const user = useSelector((state) => state.user);
  const antIcon = <LoadingOutlined style={{ fontSize: 32 }} spin />;
  const dispatch = useDispatch();
  useEffect(() => {
    deleteScript();
  });
  // Get cart from server
  useEffect(() => {
    const fetchCartItems = async () => {
      const cartItemsResponse = await cartApi.getAll(user.id);
      const action = setCart(cartItemsResponse);
      dispatch(action);
    };
    if (user !== null) fetchCartItems();
  }, []);
 
  // Get campaign and categories
  useEffect(() => {
    const params = {
      page: 1,
      size: 10,
    };
    const fetchData = async () => {
      //FetchCategory
      const categoriesResponse = await categoriesApi.getAll();
      setCategories(categoriesResponse.data);
      const campaigns = await campaignsApi.getAll(params);
      setWeeklyCampaigns(campaigns.data);
      setHotCampaign(campaigns.data);
      runScript();
      setLoading(false);
    };
    fetchData();
  }, [address]);


  return (
    <>
      <div className="d-flex justify-content-center">
        {loading ? (
          <>
            <Spin indicator={antIcon} /> <br /> <br />{" "}
          </>
        ) : null}
      </div>
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

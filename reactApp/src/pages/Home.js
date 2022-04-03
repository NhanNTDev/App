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
import { message, notification, Spin } from "antd";
import { LoadingOutlined } from "@ant-design/icons";

const Home = () => {
  const [weeklyCampaigns, setWeeklyCampaigns] = useState([]);
  const [hotCampaigns, setHotCampaign] = useState([]);
  const [categories, setCategories] = useState([]);
  const [loading, setLoading] = useState(true);
  const [noCampaign, setNoCampaign] = useState(false);
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
      const cartItemsResponse = await cartApi.getAll(user.id).catch((err) => {
        let errorMessage = err.response.data.error.message;
        console.log(errorMessage);
      });
      const action = setCart(cartItemsResponse);
      dispatch(action);
    };
    if (user !== null) fetchCartItems();
  }, []);

  // Get campaign and categories
  useEffect(() => {
    const params = {
      address: address,
      page: 1,
      size: 10,
    };
    const fetchData = async () => {
      setLoading(true);
      //FetchCategory
      const categoriesResponse = await categoriesApi.getAll();
      setCategories(categoriesResponse.data);
      const campaigns = await campaignsApi
        .getAll(params)
        .catch((err) => console.log(err));
      if (campaigns !== null && campaigns !== undefined) {
        setWeeklyCampaigns(campaigns.data);
        setHotCampaign(campaigns.data);
        setNoCampaign(false);
      } else {
        setNoCampaign(true);
        notification.error({
          duration: 2,
          message: "Không tồn tại chiến dịch cho địa chỉ của bạn!",
          style:{fontSize: 16},
        });
      }
      runScript();
      setLoading(false);
    };
    fetchData();
    console.log("reset");
  }, [address]);

  return (
    <>
      
      <TopBanner />
      <TopCategory listCategories={categories}></TopCategory>
      <div className="d-flex justify-content-center">
        {loading ? (
          <>
            <Spin indicator={antIcon} /> <br /> <br />{" "}
          </>
        ) : null}
      </div>
      {!noCampaign ? (
        <CampaignSlider
          title="Chiến dịch trong tuần"
          listCampaigns={weeklyCampaigns}
          type="weekly"
        ></CampaignSlider>
      ) : null}
      <CenterBanner />
      {!noCampaign ? (<CampaignSlider
        title="Chiến dịch khác"
        listCampaigns={hotCampaigns}
        type="other"
      ></CampaignSlider>) : null }
    </>
  );
};

export default Home;

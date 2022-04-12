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
import { Button, notification, Result } from "antd";
import { useNavigate, useSearchParams } from "react-router-dom";
import { setLocation } from "../state_manager_redux/location/locationSlice";
import userApi from "../apis/userApi";
import { setUser } from "../state_manager_redux/user/userSlice";
import LoadingPage from "./LoadingPage";

const Home = () => {
  const [weeklyCampaigns, setWeeklyCampaigns] = useState([]);
  const [hotCampaigns, setHotCampaign] = useState([]);
  const [categories, setCategories] = useState([]);
  const [loading, setLoading] = useState(true);
  const [noCampaign, setNoCampaign] = useState(false);
  const [networkErr, setNetworkErr] = useState(false);
  const [reload, setReload] = useState(true);
  const address = useSelector((state) => state.location);
  const user = useSelector((state) => state.user);
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const [searchParams] = useSearchParams();
  const [code, setCode] = useState(searchParams.get("code"));
  const zoneId = useSelector((state) => state.zone);

  useEffect(() => {
    if (code !== null) {
      const loginByCode = async () => {
        const result = await userApi.loginByCode(code).catch((err) => {
          if (err.message === "Network Error") {
            notification.error({
              duration: 3,
              message: "Mất kết nối mạng!",
              style: { fontSize: 16 },
            });
          } else {
            notification.error({
              duration: 3,
              message: "Có lỗi xảy ra trong quá trình xử lý!",
              style: { fontSize: 16 },
            });
          }
          if (address === null) navigate("/page-not-found");
        });
        if (result && result.user.role === "customer") {
          setCode(null);
          const setUserAction = setUser({ ...result });
          dispatch(setUserAction);
          if (result.user.address !== null && result.user.address !== "") {
            const setLocationAction = setLocation({
              location: result.user.address,
            });
            dispatch(setLocationAction);
          }
        }
      };
      loginByCode();
    }
    if (address === null && code === null) {
      navigate("/getStarted");
    }
  }, [code]);
  useEffect(() => {
    deleteScript();
  });
  // Get cart from server
  useEffect(() => {
    const fetchCartItems = async () => {
      const cartItemsResponse = await cartApi.getAll(user.id).catch((err) => {
        console.log(err);
      });
      if (cartItemsResponse !== undefined && cartItemsResponse !== null) {
        const action = setCart(cartItemsResponse);
        dispatch(action);
      }
    };
    if (user !== null) fetchCartItems();
  }, []);

  // Get campaign and categories
  useEffect(() => {
    const params = {
      "delivery-zone-id": parseInt(zoneId),
      page: 1,
      size: 10,
    };
    const fetchData = async () => {
      setNetworkErr(false);
      setLoading(true);
      //FetchCategory
      const categoriesResponse = await categoriesApi.getAll().catch((err) => {
        setNetworkErr(true);
      });
      if (categoriesResponse !== undefined) {
        setCategories(categoriesResponse.data);
      }
      await campaignsApi
        .getAll(params)
        .then((result) => {
          if (result !== null && result !== undefined) {
            setWeeklyCampaigns(result.data);
            setHotCampaign(result.data);
            setNoCampaign(false);
          }
        })
        .catch((err) => {
          if (err.message === "Network Error") {
            notification.error({
              duration: 3,
              message: "Mất kết nối mạng!",
              style: { fontSize: 16 },
            });
            setNetworkErr(true);
          } else if (err.response.status === 400) {
            setNoCampaign(true);
            notification.error({
              duration: 2,
              message: "Không tồn tại chiến dịch cho địa chỉ của bạn!",
              style: { fontSize: 16 },
            });
          } else {
            notification.error({
              duration: 3,
              message: "Có lỗi xảy ra trong quá trình xử lý!",
              style: { fontSize: 16 },
            });
            setNetworkErr(true);
          }
        });

      runScript();
      setLoading(false);
    };
    if (address !== null) {
      fetchData();
    } else {
      setLoading(false);
    }
  }, [reload]);

  return (
    <>
      {networkErr ? (
        <Result
          status="error"
          title="Đã có lỗi xảy ra!"
          subTitle="Rất tiếc đã có lỗi xảy ra trong quá trình tải dữ liệu, quý khách vui lòng kiểm tra lại kết nối mạng và thử lại."
          extra={[
            <Button
              type="primary"
              key="console"
              onClick={() => {
                setReload(!reload);
              }}
            >
              Tải lại
            </Button>,
          ]}
        ></Result>
      ) : (
        <>
          <TopBanner />
          <TopCategory listCategories={categories}></TopCategory>
          {loading ? (
            <LoadingPage />
          ) : !noCampaign ? (
            <>
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
          ) : (
            <div className="d-flex justify-content-center">
              <Result
                status="warning"
                title="Không tồn tại chiến dịch hổ trợ vị trí của bạn!"
              />
            </div>
          )}
        </>
      )}
    </>
  );
};

export default Home;

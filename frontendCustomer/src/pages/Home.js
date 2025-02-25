import CenterBanner from "../components/home/CenterBanner";
import CampaignSlider from "../components/campaign/CampaignSlider";
import TopCategory from "../components/home/TopCategory";
import { runCaroselScript } from "../utils/Common";
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
  const code = searchParams.get("code");
  const zoneId = useSelector((state) => state.zone);
  const [loginByCodeFlag, setLoginByCodeFlag] = useState(false);

  useEffect(() => {
    const loginByCode = async () => {
      await userApi
        .loginByCode(code)
        .then((result) => {
          if (result && result.user.role === "customer") {
            const setUserAction = setUser({ ...result });
            dispatch(setUserAction);
            if (result.user.address !== null && result.user.address !== "") {
              const setLocationAction = setLocation({
                location: result.user.address,
              });
              dispatch(setLocationAction);
            }
          }
        })
        .catch((err) => {
          if (err.message === "Network Error") {
            notification.error({
              duration: 3,
              message: "Mất kết nối mạng!",
              style: { fontSize: 16 },
            });
          }
          if (address === null) navigate("/page-not-found");
        });
    };
    if (!loginByCodeFlag) {
      setLoginByCodeFlag(true);
      code && loginByCode();
    }
    if (address === null && code === null) {
      navigate("/getStarted");
    }
  }, []);
  // Get cart from server
  useEffect(() => {
    const fetchCartItems = async () => {
      const cartItemsResponse = await cartApi
        .getAll(user.id)
        .catch((err) => {});
      if (cartItemsResponse !== undefined && cartItemsResponse !== null) {
        const action = setCart(cartItemsResponse);
        dispatch(action);
      }
    };
    if (user !== null) fetchCartItems();
  }, []);

  // Get campaign and categories
  useEffect(() => {
    const fetchData = async () => {
      let noCampaignCount = 0;
      setNoCampaign(false);
      setNetworkErr(false);
      setLoading(true);
      //FetchCategory
      await categoriesApi
        .getAll()
        .then((result) => {
          setCategories(result.data);
        })
        .catch((err) => {
          setNetworkErr(true);
        });
      const params1 = {
        "delivery-zone-id": parseInt(zoneId),
        type: "Hàng tuần",
        page: 1,
        size: 10,
      };
      await campaignsApi
        .getAll(params1)
        .then((result) => {
          if (result !== null && result !== undefined) {
            setWeeklyCampaigns(result.data);
            return result;
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
            noCampaignCount = noCampaignCount + 1;
          } else {
            notification.error({
              duration: 3,
              message: "Có lỗi xảy ra trong quá trình xử lý!",
              style: { fontSize: 16 },
            });
            setNetworkErr(true);
          }
        });
      const params2 = {
        "delivery-zone-id": parseInt(zoneId),
        type: "Sự kiện",
        page: 1,
        size: 10,
      };
      await campaignsApi
        .getAll(params2)
        .then((result) => {
          if (result !== null && result !== undefined) {
            setHotCampaign(result.data);
            return result;
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
            noCampaignCount = noCampaignCount + 1;
          } else {
            notification.error({
              duration: 3,
              message: "Có lỗi xảy ra trong quá trình xử lý!",
              style: { fontSize: 16 },
            });
            setNetworkErr(true);
          }
        });
      if (noCampaignCount === 2) {
        notification.error({
          duration: 2,
          message: "Không tồn tại chiến dịch hỗ trợ vị trí của bạn!",
          style: { fontSize: 16 },
        });
        setNoCampaign(true);
      }
      runCaroselScript();
      setLoading(false);
    };

    if (zoneId !== null) {
      fetchData();
    } else {
      setLoading(false);
    }
  }, [reload, zoneId]);

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
          {loading ? (
            <LoadingPage />
          ) : !noCampaign ? (
            <>
              <TopCategory categories={categories}></TopCategory>
              <CampaignSlider
                title="Chiến dịch hàng tuần"
                listCampaigns={weeklyCampaigns}
                type="Hàng tuần"
              ></CampaignSlider>
              <CenterBanner />
              <CampaignSlider
                title="Chiến dịch sự kiện"
                listCampaigns={hotCampaigns}
                type="Sự kiện"
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

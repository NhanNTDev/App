import Footer from "../components/home/Footer";
import Header from "../components/header/Header";
import AppRouter from "../router/AppRouter";
import { useDispatch, useSelector } from "react-redux";
import { Routes, Route, Navigate, useLocation } from "react-router-dom";
import Login from "./Login";
import GetStarted from "./GetStarted";
import Home from "./Home";
import { useEffect, useState } from "react";
import externalApi from "../apis/externalApis";
import { setZone } from "../state_manager_redux/zone/zoneSlice";
import { notification } from "antd";
import LoadingPage from "./LoadingPage";

const WelcomePage = () => {
  const userLocation = useSelector((state) => state.location);
  const user = useSelector((state) => state.user);
  const [loading, setLoading] = useState(false);
  const dispatch = useDispatch();

  useEffect(() => {
    setLoading(true);
    const getZone = async () => {
      await externalApi
        .getZone(userLocation)
        .then((result) => {
          const setZoneAction = setZone({ zoneId: result });
          dispatch(setZoneAction);
        })
        .catch((err) => {
          notification.error({
            duration: 3,
            message: "Có lỗi xảy ra trong quá trình xử lý!",
            style: { fontSize: 16 },
          });
        });
      setLoading(false);
    };
    userLocation && getZone();
  }, [userLocation]);
  return (
    <>
      <div style={{ backgroundColor: "#f9f9f9" }}>
        {userLocation === null ? (
          <>
            <Routes>
              <Route path="/home" element={<Home />} />
              <Route path="/" element={<GetStarted />} />
              <Route
                path="/login"
                element={
                  user === null ? <Login /> : <Navigate replace to="/" />
                }
              />
              <Route path="/*" element={<Navigate replace to="/" />} />
            </Routes>
          </>
        ) : (
          <>
            <Header />
            {loading ? <LoadingPage /> : <AppRouter />}
          </>
        )}

        <Footer />
      </div>
    </>
  );
};

export default WelcomePage;

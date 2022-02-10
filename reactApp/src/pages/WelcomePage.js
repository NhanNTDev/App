import Footer from "../components/home/Footer";
import Header from "../components/header/Header";
import AppRouter from "../router/AppRouter";
import { useDispatch, useSelector } from "react-redux";
import { Routes, Route, Navigate } from "react-router-dom";
import Login from "./Login";
import GetStarted from "./GetStarted";
import { setLocation } from "../state_manager_redux/location/locationSlice";

const WelcomePage = () => {
  const userLocation = useSelector((state) => state.location);
  const user = useSelector((state) => state.user);
  const dispatch = useDispatch();

  if (user !== null && userLocation === null) {
    if (user.address !== "") {
      const action = setLocation({ location: user.address });
      dispatch(action);
    }
  }

  return (
    <div style={{ backgroundColor: "#f9f9f9" }}>
      {userLocation === null ? (
        <>
          <Routes>
            <Route path="/" element={<GetStarted />} />
            <Route path="/login" element={user === null ? <Login /> : <Navigate replace to="/"/>} />
            <Route path="/*" element={<Navigate replace to="/" />} />
          </Routes>
        </>
      ) : (
        <>
          <Header />
          <AppRouter />
        </>
      )}

      <Footer />
    </div>
  );
};

export default WelcomePage;

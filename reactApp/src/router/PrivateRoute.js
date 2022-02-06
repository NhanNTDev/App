import { useSelector } from "react-redux";
import { Navigate } from "react-router-dom";

const PrivateRoute = ({ children }) => {
  const user = useSelector((state) => state.user);
  console.log(user);
  return user !== null ? children : <Navigate to="/login" />;
};

export default PrivateRoute;

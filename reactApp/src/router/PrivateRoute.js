import { Navigate } from "react-router-dom";

const PrivateRoute = ({ children }) => {
  const user = localStorage.getItem("USER");
  return user !== null ? children : <Navigate to="/login" />;
};

export default PrivateRoute;

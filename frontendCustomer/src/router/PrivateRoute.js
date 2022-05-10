import { useSelector } from "react-redux";
import { Navigate } from "react-router-dom";

const PrivateRoute = ({ children, urlRedirect }) => {
  const user = useSelector((state) => state.user);
  const loginUrl = `/login?urlRedirect=${urlRedirect}`;
  return user !== null ? children : <Navigate to={loginUrl}/>;
};

export default PrivateRoute;

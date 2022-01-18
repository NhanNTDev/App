import { useContext } from "react";
import { Route, Navigate } from "react-router-dom";
import AuthContext from "../contexts/AuthContext";

const PublicRoute = ({ element: Component, ...rest }) => {
    const auth = useContext(AuthContext);
  return (
    <Route
      {...rest}
      component={(props) =>
        auth.isAuthen ? <Navigate to="/home" /> : <Component {...props} />
      }
    />
  );
};
export default PublicRoute;
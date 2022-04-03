import { useSelector } from "react-redux";
import { Link } from "react-router-dom";

const MenuAccountLeft = ({ type }) => {
  const user = useSelector((state) => state.user);
  return (
    <div className="card account-left">
      <div className="user-profile-header">
        <img
         
          src={user.image !== "" ? user.image : "/img/user/user.jpg"}
        />
        <h5 className="mb-1 text-secondary">
          <strong></strong> {user.name}
        </h5>
        <p>{user.phoneNumber}</p>
      </div>
      <div className="list-group">
        <Link
          to="/account"
          className={
            type === "account"
              ? "list-group-item list-group-item-action active"
              : "list-group-item list-group-item-action"
          }
        >
          <i aria-hidden="true" className="mdi mdi-account-outline"></i> Thông
          Tin Của Tôi
        </Link>
        <Link
          to="/address"
          className={
            type === "address"
              ? "list-group-item list-group-item-action active"
              : "list-group-item list-group-item-action"
          }
        >
          <i aria-hidden="true" className="mdi mdi-map-marker-circle"></i> Địa
          Chỉ Giao Hàng
        </Link>
        <Link
          to="/orderlist"
          className={
            type === "orderList"
              ? "list-group-item list-group-item-action active"
              : "list-group-item list-group-item-action"
          }
        >
          <i aria-hidden="true" className="mdi mdi-format-list-bulleted"></i>{" "}
          Lịch Sử Đặt Hàng
        </Link>
        <Link to="/changePassword" className={
            type === "changePassword"
              ? "list-group-item list-group-item-action active"
              : "list-group-item list-group-item-action"
          }>
          <i aria-hidden="true" className="mdi mdi-lock"></i> Đổi mật khẩu
        </Link>
      </div>
    </div>
  );
};

export default MenuAccountLeft;

import { Link, useNavigate } from "react-router-dom";
import { useState } from "react";
import TopOption from "./TopOption";
import NavBar from "./NavBar";
import LocationSearch from "./LocationSearch";
import { useDispatch, useSelector } from "react-redux";
import { logout } from "../../state_manager_redux/user/userSlice";
import { getCartCouter } from "../../state_manager_redux/cart/cartSelector";

const Header = () => {
  const [searchValue, setSearchValue] = useState("");
  const navigate = useNavigate();
  const user = useSelector((state) => state.user);
  const address = useSelector((state) => state.location);
  const dispatch = useDispatch();
  const handleLogout = () => {
    const action = logout();
    dispatch(action);
    navigate("/login");
  };
  const cartCouter = useSelector(getCartCouter);

  const handleLocationButtonClick = () => {
    var element = document.getElementById("toggle");
    element.classList.toggle("toggled");
  };

  return (
    <>
      <TopOption />
      <nav className="navbar navbar-light navbar-expand-lg bg-dark bg-faded osahan-menu">
        <div className="container-fluid">
          <Link className="navbar-brand" to="/home">
            {" "}
            <img src="/img/logo.png" alt="logo" />{" "}
          </Link>
          <button
            className="navbar-toggler navbar-toggler-white"
            type="button"
            data-toggle="collapse"
            data-target="#navbarText"
            aria-controls="navbarText"
            aria-expanded="false"
            aria-label="Toggle navigation"
          >
            <span className="navbar-toggler-icon"></span>
          </button>
          <div className="navbar-collapse" id="navbarNavDropdown">
            <div className="navbar-nav mr-auto mt-2 mt-lg-0 margin-auto top-categories-search-main">
              <div className="top-categories-search">
                <div className="input-group">
                  <span className="input-group-btn categories-dropdown">
                    <button
                      className="form-control locate-btn"
                      // data-toggle="offcanvas"
                      onClick={handleLocationButtonClick}
                    >
                      <span
                        className="mdi mdi-map-marker-circle"
                        style={{ color: "orange" }}
                      >
                        {" "}
                      </span>
                      {address !== null ? address : "Cập nhật vị trí hiện tại"}
                    </button>
                  </span>
                  <input
                    value={searchValue}
                    className="form-control"
                    placeholder="Tìm kiếm sản phẩm tại đây"
                    aria-label="Tìm kiếm sản phẩm tại đây"
                    type="text"
                    onChange={(e) => {
                      setSearchValue(e.target.value);
                    }}
                    onKeyPress={(e) => {
                      if (e.key == "Enter") {
                        navigate(`/search-result?searchValue=${searchValue}`);
                      }
                    }}
                  />
                  <span className="input-group-btn">
                    <button
                      className="btn btn-secondary"
                      type="button"
                      onClick={() => {
                        navigate(`/search-result?searchValue=${searchValue}`);
                      }}
                    >
                      <i className="mdi mdi-file-find"></i> Tìm Kiếm
                    </button>
                  </span>
                </div>
              </div>
            </div>
            <div className="my-2 my-lg-0">
              <ul className="list-inline main-nav-right">
                {user !== null ? (
                  <li className="list-inline-item dropdown osahan-top-dropdown">
                    <a
                      className="btn btn-theme-round dropdown-toggle dropdown-toggle-top-user"
                      href="#"
                      data-toggle="dropdown"
                      aria-haspopup="true"
                      aria-expanded="false"
                    >
                      <img
                        alt="logo"
                        src={user.image !== null ? user.image : "img/user.jpg"}
                      />
                      {user.shortName !== null ? user.shortName : user.userName}
                    </a>
                    <div class="dropdown-menu dropdown-menu-right dropdown-list-design">
                      <Link to="/account" className="dropdown-item">
                        <i
                          aria-hidden="true"
                          className="mdi mdi-account-outline"
                        ></i>{" "}
                        Thông Tin Cá Nhân
                      </Link>
                      <Link to="/address" className="dropdown-item">
                        <i
                          aria-hidden="true"
                          className="mdi mdi-map-marker-circle"
                        ></i>{" "}
                        Thông Tin Giao Hàng
                      </Link>
                      <Link to="/wishList" className="dropdown-item">
                        <i
                          aria-hidden="true"
                          className="mdi mdi-heart-outline"
                        ></i>{" "}
                        Mục Yêu Thích{" "}
                      </Link>
                      <Link to="orderList" className="dropdown-item">
                        <i
                          aria-hidden="true"
                          className="mdi mdi-format-list-bulleted"
                        ></i>{" "}
                        Lịch Sử Đặt Hàng
                      </Link>
                      <div className="dropdown-divider"></div>
                      <a
                        className="dropdown-item"
                        onClick={() => handleLogout()}
                      >
                        <i className="mdi mdi-lock"></i> Đăng xuất
                      </a>
                    </div>
                  </li>
                ) : (
                  <li className="list-inline-item">
                    <Link to="/login" className="btn btn-link">
                      <i className="mdi mdi-account-circle"></i> Đăng nhập/Đăng
                      ký
                    </Link>
                  </li>
                )}
                <li className="list-inline-item cart-btn">
                  <Link to="/cart" className="btn btn-link border-none">
                    <i className="mdi mdi-cart"></i> Giỏ hàng{" "}
                    {cartCouter === 0 ? null : <small className="cart-value">{cartCouter}</small>}
                  </Link>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </nav>
      <NavBar />
      <LocationSearch />
    </>
  );
};

export default Header;

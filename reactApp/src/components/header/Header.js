import { Link, useNavigate, Navigate } from "react-router-dom";
import { useEffect, useState } from "react";
import TopOption from "./TopOption";
import NavBar from "./NavBar";
import LocationSearch from "./LocationSearch";
import { useDispatch, useSelector } from "react-redux";
import { logout } from "../../state_manager_redux/user/userSlice";
import { getCartCouter } from "../../state_manager_redux/cart/cartSelector";
import { SearchOutlined, BellTwoTone } from "@ant-design/icons";
import { AutoComplete, Badge, Popover, Tag } from "antd";
import harvestCampaignApi from "../../apis/harvestCampaignApi";
import externalApi from "../../apis/externalApis";

const Header = () => {
  const [searchValue, setSearchValue] = useState("");
  const navigate = useNavigate();
  const user = useSelector((state) => state.user);
  const address = useSelector((state) => state.location);
  const cartCouter = useSelector(getCartCouter);
  const dispatch = useDispatch();
  const [searchSuggestion, setSearchSuggestion] = useState([]);
  const zoneId = useSelector((state) => state.zone);
  const [notification, setNotification] = useState([]);

  const content = (
    <div>
      {notification.map((noti) => {
        return (
          <>
            <div
              style={{
                width: 350,
                border: "groove 1px",

                marginBottom: 5,
                padding: 5,
              }}
            >
              <h5 className="heading-design-h5 d-flex justify-content-center">
                <strong>{noti.title}</strong>
              </h5>
              <h6
                className="heading-design-h6"
                style={{ wordWrap: "break-word" }}
              >
                {noti.body}
              </h6>
              <h6
                className="heading-design-h6"
                style={{ textAlign: "right", marginRight: 10 }}
              >
                {noti.time}
              </h6>
            </div>
          </>
        );
      })}
    </div>
  );

  useEffect(() => {
    const getSuggestion = async () => {
      await harvestCampaignApi.getSearchOption(zoneId).then((result) => {
        let options = [];
        result.map((product) => {
          options.push({ value: product.productName });
        });
        setSearchSuggestion(options);
      });
    };
    getSuggestion();
    const getNotification = async () => {
      await externalApi.getNotification(user.id).then((result) => {
        setNotification(result);
      });
    };
    getNotification();
  }, []);
  const handleLogout = () => {
    const action = logout();
    dispatch(action);
    navigate("/login");
  };

  const handleLocationButtonClick = () => {
    var element = document.getElementById("toggle");
    element.classList.toggle("toggled");
  };

  return (
    <>
      <TopOption />
      <nav className="navbar navbar-light navbar-expand-lg bg-dark bg-faded osahan-menu">
        <div className="container-fluid">
          <Link className="navbar-brand" to="/home" style={{ marginLeft: 50 }}>
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
                  <span
                    className="input-group-btn categories-dropdown"
                    style={{ marginRight: 5 }}
                  >
                    <button
                      className="form-control locate-btn"
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
                  <AutoComplete
                    size="large"
                    className="form-control"
                    options={searchSuggestion}
                    filterOption={(inputValue, option) =>
                      option.value
                        .toUpperCase()
                        .indexOf(inputValue.toUpperCase()) !== -1
                    }
                    onKeyPress={(e) => {
                      if (e.key === "Enter") {
                        if (searchValue.trim() !== "") {
                          navigate(
                            `/search-result?searchValue=${searchValue}`,
                            {
                              replace: true,
                            }
                          );
                        }
                      }
                    }}
                    onSearch={(value) => {
                      setSearchValue(value);
                    }}
                    value={searchValue}
                    onSelect={(value) => {
                      setSearchValue(value);
                      navigate(`/search-result?searchValue=${value}`, {
                        replace: true,
                      });
                    }}
                    placeholder="Nhập tên sản phẩm"
                  ></AutoComplete>

                  <span className="input-group-btn">
                    <button
                      className="btn btn-secondary"
                      type="button"
                      onClick={() => {
                        if (searchValue.trim() !== "") {
                          navigate(
                            `/search-result?searchValue=${searchValue}`,
                            {
                              replace: true,
                            }
                          );
                        }
                      }}
                    >
                      <i>
                        <SearchOutlined style={{ paddingBottom: 5 }} />
                      </i>{" "}
                      Tìm Kiếm
                    </button>
                  </span>
                </div>
              </div>
            </div>
            <div className="my-2 my-lg-0">
              <ul className="list-inline main-nav-right">
                {user !== null ? (
                  <>
                    <li className="list-inline-item">
                      <Popover
                        placement="bottom"
                        content={content}
                        trigger="click"
                      >
                        <Badge dot style={{ marginRight: 10 }}>
                          <BellTwoTone
                            style={{ fontSize: 24, marginRight: 10 }}
                          />
                        </Badge>
                      </Popover>
                    </li>

                    <li className="list-inline-item dropdown osahan-top-dropdown">
                      <a
                        className="btn btn-theme-round dropdown-toggle dropdown-toggle-top-user"
                        href="#"
                        data-toggle="dropdown"
                        aria-haspopup="true"
                        aria-expanded="false"
                      >
                        <img
                          src={
                            user.image !== ""
                              ? user.image
                              : "/img/user/user.jpg"
                          }
                        />
                        {user.name !== null ? user.name : user.userName}
                      </a>
                      <div className="dropdown-menu dropdown-menu-right dropdown-list-design">
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
                        <Link to="/orderList" className="dropdown-item">
                          <i
                            aria-hidden="true"
                            className="mdi mdi-format-list-bulleted"
                          ></i>{" "}
                          Lịch Sử Đặt Hàng
                        </Link>
                        <Link to="/changePassword" className="dropdown-item">
                          <i className="mdi mdi-lock"></i> Đổi Mật Khẩu
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
                  </>
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
                    {cartCouter === 0 ? null : (
                      <small className="cart-value">{cartCouter}</small>
                    )}
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

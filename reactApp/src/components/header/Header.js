import { Link, useNavigate } from "react-router-dom";
import { useState } from "react";
import LoginPopup from "../login/LoginPopup";
import TopOption from "./TopOption";
import NavBar from "./NavBar";

const Header = () => {
  const [searchValue, setSearchValue] = useState("");
  const [city, setCity] = useState("0");
  const navigate = useNavigate();
  const citys = [
    {
      id: "0",
      name: "Chọn Thành Phố",
    },
    {
      id: "1",
      name: "Hồ Chí Minh",
    },
    {
      id: "2",
      name: "Hà Nội",
    },
    {
      id: "3",
      name: "Đà Nẵng",
    },
    {
      id: "4",
      name: "Cần Thơ",
    },
    {
      id: "5",
      name: "Quy Nhơn",
    },
  ];

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
                    {/* <select
                      className="form-control"
                      value={city}
                      onChange={(e) => {
                        setCity(e.target.value);
                      }}
                    >
                      {citys.map((city) => (
                        <option value={city.id} key={city.id}>
                          {city.name}
                        </option>
                      ))}
                    </select> */}
                    <button className="form-control locate-btn">
                      <span
                        className="mdi mdi-map-marker-circle"
                        style={{ color: "orange" }}
                      >
                        {" "}
                      </span>
                      Cập nhật vị trí hiện tại
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
                <li className="list-inline-item">
                  <Link
                    to="/login"
                    className="btn btn-link"
                  >
                    <i className="mdi mdi-account-circle"></i> Đăng nhập/Đăng ký
                  </Link>
                </li>
                <li className="list-inline-item cart-btn">
                  <Link
                    to="/cart"
                    // data-toggle="offcanvas"
                    className="btn btn-link border-none"
                  >
                    <i className="mdi mdi-cart"></i> Giỏ hàng{" "}
                    <small className="cart-value">5</small>
                  </Link>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </nav>
      <NavBar />
    
    </>
  );
};

export default Header;

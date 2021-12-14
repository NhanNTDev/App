
import { Link } from "react-router-dom";
import { useState } from "react";
import CartPopup from "./CartPopup";
import LoginPopup from "./LoginPopup";

const Header = () => {
  const [searchValue, setSearchValue] = useState("");
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

  const topRefs = [
    {
      id: "1",
      title: "Đăng ký người bán",
      link: "",
    },
    {
      id: "2",
      title: "Kết nối",
      link: "",
    },
    {
      id: "3",
      title: "Tải ứng dụng",
      link: "",
    },
  ];

  const navbarItems = [
    {
      id: "1",
      title: "Trang Chủ",
      childrens: [],
      link: "/home",
    },
    {
      id: "2",
      title: "Shop",
      childrens: [],
      link: "/shop",
    },
    {
      id: "3",
      title: "Nông Trại",
      childrens: [],
      link: "/home",
    },
    {
      id: "4",
      title: "Check out",
      childrens: [],
      link: "/checkout",
    },
    {
      id: "5",
      title: "Cá Nhân",
      childrens: [
        {
          id: "1",
          title: "Thông Tin Cá Nhân",
          link: "/account",
        },
        {
          id: "2",
          title: "Thông Tin Giao Hàng",
          link: "/address",
        },
        {
          id: "3",
          title: "Mục Yêu Thích",
          link: "/wishlist",
        },
        {
          id: "4",
          title: "Lịch Sử Đặt Hàng",
          link: "/orderlist",
        },
      ],
      link: "",
    },
    {
      id: "6",
      title: "Liên Hệ",
      childrens: [],
      link: "/home",
    },
    {
      id: "7",
      title: "Khác",
      childrens: [
        {
          id: "1",
          title: "Page Not Found",
          link: "/page-not-found",
        },
        {
          id: "2",
          title: "Mục khác 2",
          link: "",
        },
        {
          id: "3",
          title: "Mục khác 3",
          link: "",
        },
        {
          id: "4",
          title: "Mục khác 4",
          link: "",
        },
      ],
      link: "",
    },
  ];

  const renderNavbarItem = (props) => {
    return (
      <div key={props.id}>
        {props.id === "1" ? (
          <li className="nav-item">
            <Link className="nav-link shop" to={props.link}>
              <span className="mdi mdi-store"></span> {props.title}
            </Link>
          </li>
        ) : props.childrens.length > 0 ? (
          <li className="nav-item dropdown">
            <Link
              className="nav-link dropdown-toggle"
              to="#"
              data-toggle="dropdown"
              aria-haspopup="true"
              aria-expanded="false"
            >
              {props.title}
            </Link>
            <div className="dropdown-menu">
              {props.childrens.map((child) => (
                <Link key={child.id} className="dropdown-item" to={child.link}>
                  <i className="mdi mdi-chevron-right" aria-hidden="true"></i>{" "}
                  {child.title}
                </Link>
              ))}
            </div>
          </li>
        ) : (
          <li className="nav-item">
            <Link className="nav-link" to={props.link}>
              {props.title}
            </Link>
          </li>
        )}
      </div>
    );
  };

  const renderNavbar = () => {
    return (
      <>
        <nav className="navbar navbar-expand-lg navbar-light osahan-menu-2 pad-none-mobile">
          <div className="container-fluid">
            <div className="collapse navbar-collapse" id="navbarText">
              <ul className="navbar-nav mr-auto mt-2 mt-lg-0 margin-auto">
                {navbarItems.map((navbarItem) =>
                  renderNavbarItem({ ...navbarItem })
                )}
              </ul>
            </div>
          </div>
        </nav>
      </>
    );
  };

  const renderTopReference = () => {
    return (
      <div className="navbar-top bg-success pt-2 pb-2">
        <div className="container-fluid">
          <div className="row">
            <div className="col-lg-12 text-center">
              {topRefs.map((topRef) => (
                <Link
                  key={topRef.id}
                  to={topRef.link}
                  className="mb-0 mr-2 text-white"
                >
                  {topRef.title} <span className="mb-0 ml-2 text-white">{"|"}</span>
                </Link>
                
              ))}             
            </div>
          </div>
        </div>
      </div>
    );
  };

  return (
    <>
      {renderTopReference()}
      <nav className="navbar navbar-light navbar-expand-lg bg-dark bg-faded osahan-menu">
        <div className="container-fluid">
          <Link className="navbar-brand" to="/home">
            {" "}
            <img src="img/logo.png" alt="logo" />{" "}
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
                    <select className="form-control-select" value="0" onChange={()=> {}}>
                      {citys.map((city) => (
                        <option value={city.id} key={city.id}>
                          {city.name}
                        </option>
                      ))}
                    </select>
                  </span>
                  <input
                    value={searchValue}
                    className="form-control"
                    placeholder="Tìm kiếm sản phẩm tại đây"
                    aria-label="Tìm kiếm sản phẩm tại đây"
                    type="text"
                    onChange={(e) => {setSearchValue(e.target.value)}}
                  />
                  <span className="input-group-btn">
                    <button className="btn btn-secondary" type="button">
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
                    to="#"
                    data-target="#bd-example-modal"
                    data-toggle="modal"
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
      {renderNavbar()}
      <LoginPopup />
    </>
  );
};

export default Header;

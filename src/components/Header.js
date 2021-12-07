import CartPopup from "./CartPopup"
import LoginPopup from "./LoginPopup"

const Header = () => {
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
    ]
    return (
        <>
            <div className="navbar-top bg-success pt-2 pb-2">
                <div className="container-fluid">
                    <div className="row">
                        <div className="col-lg-12 text-center">
                            <a href="shop.html" className="mb-0 text-white">
                                Đăng ký người bán
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <nav className="navbar navbar-light navbar-expand-lg bg-dark bg-faded osahan-menu">
                <div className="container-fluid">
                    <a className="navbar-brand" href="index.html">
                        {" "}
                        <img src="img/logo.png" alt="logo" />{" "}
                    </a>
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
                                        <select className="form-control-select" value="0">
                                            {citys.map(city => <option value={city.id} key={city.id}>{city.name}</option>)}
                                        </select>
                                    </span>
                                    <input
                                        className="form-control"
                                        placeholder="Tìm kiếm sản phẩm tại đây"
                                        aria-label="Tìm kiếm sản phẩm tại đây"
                                        type="text"
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
                                    <a
                                        href="#"
                                        data-target="#bd-example-modal"
                                        data-toggle="modal"
                                        className="btn btn-link"
                                    >
                                        <i className="mdi mdi-account-circle"></i> Đăng nhập/Đăng ký
                                    </a>
                                </li>
                                <li className="list-inline-item cart-btn">
                                    <a
                                        href="#"
                                        data-toggle="offcanvas"
                                        className="btn btn-link border-none"
                                    >
                                        <i className="mdi mdi-cart"></i> Giỏ hàng{" "}
                                        <small className="cart-value">5</small>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </nav>
            <nav className="navbar navbar-expand-lg navbar-light osahan-menu-2 pad-none-mobile">
                <div className="container-fluid">
                    <div className="collapse navbar-collapse" id="navbarText">
                        <ul className="navbar-nav mr-auto mt-2 mt-lg-0 margin-auto">
                            <li className="nav-item">
                                <a className="nav-link shop" href="index.html">
                                    <span className="mdi mdi-store"></span> Super Store
                                </a>
                            </li>
                            <li className="nav-item">
                                <a href="index.html" className="nav-link">
                                    Home
                                </a>
                            </li>
                            <li className="nav-item">
                                <a href="about.html" className="nav-link">
                                    About Us
                                </a>
                            </li>
                            <li className="nav-item">
                                <a className="nav-link" href="shop.html">
                                    Fruits & Vegetables
                                </a>
                            </li>
                            <li className="nav-item">
                                <a className="nav-link" href="shop.html">
                                    Grocery & Staples
                                </a>
                            </li>
                            <li className="nav-item dropdown">
                                <a
                                    className="nav-link dropdown-toggle"
                                    href="#"
                                    data-toggle="dropdown"
                                    aria-haspopup="true"
                                    aria-expanded="false"
                                >
                                    Pages
                                </a>
                                <div className="dropdown-menu">
                                    <a className="dropdown-item" href="shop.html">
                                        <i className="mdi mdi-chevron-right" aria-hidden="true"></i>{" "}
                                        Shop Grid
                                    </a>
                                    <a className="dropdown-item" href="single.html">
                                        <i className="mdi mdi-chevron-right" aria-hidden="true"></i>{" "}
                                        Single Product
                                    </a>
                                    <a className="dropdown-item" href="cart.html">
                                        <i className="mdi mdi-chevron-right" aria-hidden="true"></i>{" "}
                                        Shopping Cart
                                    </a>
                                    <a className="dropdown-item" href="checkout.html">
                                        <i className="mdi mdi-chevron-right" aria-hidden="true"></i>{" "}
                                        Checkout
                                    </a>
                                </div>
                            </li>
                            <li className="nav-item dropdown">
                                <a
                                    className="nav-link dropdown-toggle"
                                    href="#"
                                    data-toggle="dropdown"
                                    aria-haspopup="true"
                                    aria-expanded="false"
                                >
                                    My Account
                                </a>
                                <div className="dropdown-menu">
                                    <a className="dropdown-item" href="my-profile.html">
                                        <i className="mdi mdi-chevron-right" aria-hidden="true"></i>{" "}
                                        My Profile
                                    </a>
                                    <a className="dropdown-item" href="my-address.html">
                                        <i className="mdi mdi-chevron-right" aria-hidden="true"></i>{" "}
                                        My Address
                                    </a>
                                    <a className="dropdown-item" href="wishlist.html">
                                        <i className="mdi mdi-chevron-right" aria-hidden="true"></i>{" "}
                                        Wish List{" "}
                                    </a>
                                    <a className="dropdown-item" href="orderlist.html">
                                        <i className="mdi mdi-chevron-right" aria-hidden="true"></i>{" "}
                                        Order List
                                    </a>
                                </div>
                            </li>
                            <li className="nav-item dropdown">
                                <a
                                    className="nav-link dropdown-toggle"
                                    href="#"
                                    data-toggle="dropdown"
                                    aria-haspopup="true"
                                    aria-expanded="false"
                                >
                                    Blog Page
                                </a>
                                <div className="dropdown-menu">
                                    <a className="dropdown-item" href="blog.html">
                                        <i className="mdi mdi-chevron-right" aria-hidden="true"></i>{" "}
                                        Blog
                                    </a>
                                    <a className="dropdown-item" href="blog-detail.html">
                                        <i className="mdi mdi-chevron-right" aria-hidden="true"></i>{" "}
                                        Blog Detail
                                    </a>
                                </div>
                            </li>
                            <li className="nav-item dropdown">
                                <a
                                    className="nav-link dropdown-toggle"
                                    href="#"
                                    data-toggle="dropdown"
                                    aria-haspopup="true"
                                    aria-expanded="false"
                                >
                                    More Pages
                                </a>
                                <div className="dropdown-menu">
                                    <a className="dropdown-item" href="about.html">
                                        <i className="mdi mdi-chevron-right" aria-hidden="true"></i>{" "}
                                        About Us
                                    </a>
                                    <a className="dropdown-item" href="contact.html">
                                        <i className="mdi mdi-chevron-right" aria-hidden="true"></i>{" "}
                                        Contact Us
                                    </a>
                                    <a className="dropdown-item" href="faq.html">
                                        <i className="mdi mdi-chevron-right" aria-hidden="true"></i>{" "}
                                        FAQ{" "}
                                    </a>
                                    <a className="dropdown-item" href="not-found.html">
                                        <i className="mdi mdi-chevron-right" aria-hidden="true"></i>{" "}
                                        404 Error
                                    </a>
                                </div>
                            </li>
                            <li className="nav-item">
                                <a className="nav-link" href="contact.html">
                                    Contact
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
            <LoginPopup></LoginPopup>
            <CartPopup></CartPopup>
        </>
    );
}

export default Header;
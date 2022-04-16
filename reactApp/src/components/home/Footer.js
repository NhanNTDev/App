const Footer = () => {
    return (
        <>
            <section className="section-padding bg-white border-top">
                <div className="container">
                    <div className="row">
                        <div className="col-lg-4 col-sm-6">
                            <div className="feature-box">
                                <i className="mdi mdi-truck-fast"></i>
                                <h6>Giao hàng nhanh chóng</h6>
                                <p>Giao hàng ngay khi chiến dịch kết thúc</p>
                            </div>
                        </div>
                        <div className="col-lg-4 col-sm-6">
                            <div className="feature-box">
                                <i className="mdi mdi-basket"></i>
                                <h6>Sản phẩm tươi sạch</h6>
                                <p>Thu hoạch trước khi vận chuyển</p>
                            </div>
                        </div>
                        <div className="col-lg-4 col-sm-6">
                            <div className="feature-box">
                                <i className="mdi mdi-tag-heart"></i>
                                <h6>Giá cả siêu rẻ</h6>
                                <p>Giá tại vườn, không qua trung gian</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section className="section-padding footer bg-white border-top">
                <div className="container">
                    <div className="row">
                        <div className="col-lg-3 col-md-3">
                            <h4 className="mb-5 mt-0">
                                <a className="logo" href="index.html">
                                    <img src="/img/logo-footer.png" alt="Groci" />
                                </a>
                            </h4>
                            <p className="mb-0">
                                <a className="text-dark" href="#">
                                    <i className="mdi mdi-phone"></i> +61 525 240 310
                                </a>
                            </p>
                            <p className="mb-0">
                                <a className="text-dark" href="#">
                                    <i className="mdi mdi-cellphone-iphone"></i> 12345 67890,
                                    56847-98562
                                </a>
                            </p>
                            <p className="mb-0">
                                <a className="text-success" href="#">
                                    <i className="mdi mdi-email"></i> dichonao@gmail.com
                                </a>
                            </p>
                            
                        </div>
                        <div className="col-lg-2 col-md-2">
                            <h6 className="mb-4">Thành Phố </h6>
                            <ul>
                                <li>
                                    <a href="#">Hồ Chí Minh</a>
                                </li>
                                <li>
                                    <a href="#">Đồng Nai</a>
                                </li>
                                <li>
                                    <a href="#">Đà Lạt</a>
                                </li>
                            </ul>
                        </div>
                        <div className="col-lg-2 col-md-2">
                            <h6 className="mb-4">Loại hàng hóa</h6>
                            <ul>
                                <li>
                                    <a href="#">Rau củ quả</a>
                                </li>
                                <li>
                                    <a href="#">Trái cây</a>
                                </li>
                                <li>
                                    <a href="#">Nấm</a>
                                </li>
                                <li>
                                    <a href="#">Hạt</a>
                                </li>
                                <li>
                                    <a href="#">Các nông sản khác</a>
                                </li>
                            </ul>
                        </div>
                        <div className="col-lg-2 col-md-2">
                            <h6 className="mb-4">Chúng Tôi</h6>
                            <ul>
                                <li>
                                    <a href="#">Đi chợ nào</a>
                                </li>
                                {/* <li>
                                    <a href="#">Careers</a>
                                </li>
                                <li>
                                    <a href="#">Store Location</a>
                                </li>
                                <li>
                                    <a href="#">Affillate Program</a>
                                </li>
                                <li>
                                    <a href="#">Copyright</a>
                                </li> */}
                            </ul>
                        </div>
                        <div className="col-lg-3 col-md-3">
                            <h6 className="mb-4">Tải ứng dụng</h6>
                            <div className="app">
                                <a href="#">
                                    <img src="img/google.png" alt="" />
                                </a>
                                <a href="#">
                                    <img src="img/apple.png" alt="" />
                                </a>
                            </div>
                            <h6 className="mb-3 mt-4">Kết nối</h6>
                            <div className="footer-social">
                                <a className="btn-facebook" target="_blank" href="#">
                                    <i className="mdi mdi-facebook"></i>
                                </a>
                                <a className="btn-twitter" href="#">
                                    <i className="mdi mdi-twitter"></i>
                                </a>
                                <a className="btn-instagram" href="#">
                                    <i className="mdi mdi-instagram"></i>
                                </a>
                                <a className="btn-whatsapp" href="#">
                                    <i className="mdi mdi-whatsapp"></i>
                                </a>
                                <a className="btn-messenger" href="#">
                                    <i className="mdi mdi-facebook-messenger"></i>
                                </a>
                                <a className="btn-google" href="#">
                                    <i className="mdi mdi-google"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section className="pt-4 pb-4 footer-bottom">
                <div className="container">
                    <div className="row no-gutters">
                        <div className="col-lg-6 col-sm-6">
                            <p className="mt-1 mb-0">
                                &copy; Copyright 2021 <strong className="text-dark">Dichonao</strong>
                                 . All Rights Reserved
                                <br />
                            </p>
                        </div>
                    </div>
                </div>
            </section>
        </>
    )
}

export default Footer;
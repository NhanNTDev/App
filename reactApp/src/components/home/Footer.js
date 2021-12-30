const Footer = () => {
    return (
        <>
            <section className="section-padding bg-white border-top">
                <div className="container">
                    <div className="row">
                        <div className="col-lg-4 col-sm-6">
                            <div className="feature-box">
                                <i className="mdi mdi-truck-fast"></i>
                                <h6>Free & Next Day Delivery</h6>
                                <p>Lorem ipsum dolor sit amet, cons...</p>
                            </div>
                        </div>
                        <div className="col-lg-4 col-sm-6">
                            <div className="feature-box">
                                <i className="mdi mdi-basket"></i>
                                <h6>100% Satisfaction Guarantee</h6>
                                <p>Rorem Ipsum Dolor sit amet, cons...</p>
                            </div>
                        </div>
                        <div className="col-lg-4 col-sm-6">
                            <div className="feature-box">
                                <i className="mdi mdi-tag-heart"></i>
                                <h6>Great Daily Deals Discount</h6>
                                <p>Sorem Ipsum Dolor sit amet, Cons...</p>
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
                                    <img src="img/logo-footer.png" alt="Groci" />
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
                                    <i className="mdi mdi-email"></i> iamosahan@gmail.com
                                </a>
                            </p>
                            <p className="mb-0">
                                <a className="text-primary" href="#">
                                    <i className="mdi mdi-web"></i> www.askbootstrap.com
                                </a>
                            </p>
                        </div>
                        <div className="col-lg-2 col-md-2">
                            <h6 className="mb-4">TOP CITIES </h6>
                            <ul>
                                <li>
                                    <a href="#">New Delhi</a>
                                </li>
                                <li>
                                    <a href="#">Bengaluru</a>
                                </li>
                                <li>
                                    <a href="#">Hyderabad</a>
                                </li>
                                <li>
                                    <a href="#">Kolkata</a>
                                </li>
                                <li>
                                    <a href="#">Gurugram</a>
                                </li>
                            </ul>
                        </div>
                        <div className="col-lg-2 col-md-2">
                            <h6 className="mb-4">CATEGORIES</h6>
                            <ul>
                                <li>
                                    <a href="#">Vegetables</a>
                                </li>
                                <li>
                                    <a href="#">Grocery & Staples</a>
                                </li>
                                <li>
                                    <a href="#">Breakfast & Dairy</a>
                                </li>
                                <li>
                                    <a href="#">Soft Drinks</a>
                                </li>
                                <li>
                                    <a href="#">Biscuits & Cookies</a>
                                </li>
                            </ul>
                        </div>
                        <div className="col-lg-2 col-md-2">
                            <h6 className="mb-4">ABOUT US</h6>
                            <ul>
                                <li>
                                    <a href="#">Company Information</a>
                                </li>
                                <li>
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
                                </li>
                            </ul>
                        </div>
                        <div className="col-lg-3 col-md-3">
                            <h6 className="mb-4">Download App</h6>
                            <div className="app">
                                <a href="#">
                                    <img src="img/google.png" alt="" />
                                </a>
                                <a href="#">
                                    <img src="img/apple.png" alt="" />
                                </a>
                            </div>
                            <h6 className="mb-3 mt-4">GET IN TOUCH</h6>
                            <div className="footer-social">
                                <a className="btn-facebook" href="#">
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
                                &copy; Copyright 2020 <strong className="text-dark">Groci</strong>
                                . All Rights Reserved
                                <br />
                                <small className="mt-0 mb-0">
                                    Made with <i className="mdi mdi-heart text-danger"></i> by{" "}
                                    <a
                                        href="https://askbootstrap.com/"
                                        target="_blank"
                                        className="text-primary"
                                    >
                                        Ask Bootstrap
                                    </a>
                                </small>
                            </p>
                        </div>
                        <div className="col-lg-6 col-sm-6 text-right">
                            <img alt="osahan logo" src="img/payment_methods.png" />
                        </div>
                    </div>
                </div>
            </section>
        </>
    )
}

export default Footer;
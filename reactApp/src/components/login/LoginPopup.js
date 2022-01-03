const LoginPopup = () => {
    return (
        <>
            <div className="modal fade login-modal-main" id="bd-example-modal">
                <div
                    className="modal-dialog modal-lg modal-dialog-centered"
                    role="document"
                >
                    <div className="modal-content">
                        <div className="modal-body">
                            <div className="login-modal">
                                <div className="row">
                                    <div className="col-lg-6 pad-right-0">
                                        <div className="login-modal-left"></div>
                                    </div>
                                    <div className="col-lg-6 pad-left-0">
                                        <button
                                            type="button"
                                            className="close close-top-right"
                                            data-dismiss="modal"
                                            aria-label="Close"
                                        >
                                            <span aria-hidden="true">
                                                <i className="mdi mdi-close"></i>
                                            </span>
                                            <span className="sr-only">Đóng</span>
                                        </button>
                                        <form>
                                            <div className="login-modal-right">
                                                <div className="tab-content">
                                                    <div
                                                        className="tab-pane active"
                                                        id="login"
                                                        role="tabpanel"
                                                    >
                                                        <h5 className="heading-design-h5">
                                                            Đăng nhập vào tài khoản của bạn
                                                        </h5>
                                                        <fieldset className="form-group">
                                                            <label>Tên đăng nhập</label>
                                                            <input
                                                                type="text"
                                                                className="form-control"
                                                                placeholder="+91 123 456 7890"
                                                            />
                                                        </fieldset>
                                                        <fieldset className="form-group">
                                                            <label>Mật khẩu</label>
                                                            <input
                                                                type="password"
                                                                className="form-control"
                                                                placeholder="********"
                                                            />
                                                        </fieldset>
                                                        <fieldset className="form-group">
                                                            <button
                                                                type="submit"
                                                                className="btn btn-lg btn-secondary btn-block"
                                                            >
                                                                Đăng nhập
                                                            </button>
                                                        </fieldset>
                                                        <div className="login-with-sites text-center">
                                                            <p>Đăng nhập bằng tài khoản khác:</p>
                                                            <button className="btn-facebook login-icons btn-lg">
                                                                <i className="mdi mdi-facebook"></i> Facebook
                                                            </button>
                                                            <button className="btn-google login-icons btn-lg">
                                                                <i className="mdi mdi-google"></i> Google
                                                            </button>
                                                            <button className="btn-twitter login-icons btn-lg">
                                                                <i className="mdi mdi-twitter"></i> Twitter
                                                            </button>
                                                        </div>
                                                        <div className="custom-control custom-checkbox">
                                                            <input
                                                                type="checkbox"
                                                                className="custom-control-input"
                                                                id="customCheck1"
                                                            />
                                                            <label
                                                                className="custom-control-label"
                                                                htmlFor="customCheck1"
                                                            >
                                                                Nhớ mật khẩu
                                                            </label>
                                                        </div>
                                                    </div>
                                                    <div className="tab-pane" id="register" role="tabpanel">
                                                        <h5 className="heading-design-h5">Đăng ký tài khoản mới!</h5>
                                                        <fieldset className="form-group">
                                                            <label>Nhập Email/Số điện thoại</label>
                                                            <input
                                                                type="text"
                                                                className="form-control"
                                                                placeholder="+91 123 456 7890"
                                                            />
                                                        </fieldset>
                                                        <fieldset className="form-group">
                                                            <label>Nhập mật khẩu</label>
                                                            <input
                                                                type="password"
                                                                className="form-control"
                                                                placeholder="********"
                                                            />
                                                        </fieldset>
                                                        <fieldset className="form-group">
                                                            <label>Nhập lại mật khẩu </label>
                                                            <input
                                                                type="password"
                                                                className="form-control"
                                                                placeholder="********"
                                                            />
                                                        </fieldset>
                                                        <fieldset className="form-group">
                                                            <button
                                                                type="submit"
                                                                className="btn btn-lg btn-secondary btn-block"
                                                            >
                                                                Đăng ký
                                                            </button>
                                                        </fieldset>
                                                        <div className="custom-control custom-checkbox">
                                                            <input
                                                                type="checkbox"
                                                                className="custom-control-input"
                                                                id="customCheck2"
                                                            />
                                                            <label
                                                                className="custom-control-label"
                                                                htmlFor="customCheck2"
                                                            >
                                                                Tôi đồng ý với{" "}
                                                                <a href="#">điều khoản sử dụng</a>
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div className="clearfix"></div>
                                                <div className="text-center login-footer-tab">
                                                    <ul className="nav nav-tabs" role="tablist">
                                                        <li className="nav-item">
                                                            <a
                                                                className="nav-link active"
                                                                data-toggle="tab"
                                                                href="#login"
                                                                role="tab"
                                                            >
                                                                <i className="mdi mdi-lock"></i> ĐĂNG NHẬP
                                                            </a>
                                                        </li>
                                                        <li className="nav-item">
                                                            <a
                                                                className="nav-link"
                                                                data-toggle="tab"
                                                                href="#register"
                                                                role="tab"
                                                            >
                                                                <i className="mdi mdi-pencil"></i> ĐĂNG KÝ
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </div>
                                                <div className="clearfix"></div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </>

    )
}


export default LoginPopup;
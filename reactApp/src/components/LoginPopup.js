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
                                            <span className="sr-only">Close</span>
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
                                                            Login to your account
                                                        </h5>
                                                        <fieldset className="form-group">
                                                            <label>Enter Email/Mobile number</label>
                                                            <input
                                                                type="text"
                                                                className="form-control"
                                                                placeholder="+91 123 456 7890"
                                                            />
                                                        </fieldset>
                                                        <fieldset className="form-group">
                                                            <label>Enter Password</label>
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
                                                                Enter to your account
                                                            </button>
                                                        </fieldset>
                                                        <div className="login-with-sites text-center">
                                                            <p>or Login with your social profile:</p>
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
                                                                Remember me
                                                            </label>
                                                        </div>
                                                    </div>
                                                    <div className="tab-pane" id="register" role="tabpanel">
                                                        <h5 className="heading-design-h5">Register Now!</h5>
                                                        <fieldset className="form-group">
                                                            <label>Enter Email/Mobile number</label>
                                                            <input
                                                                type="text"
                                                                className="form-control"
                                                                placeholder="+91 123 456 7890"
                                                            />
                                                        </fieldset>
                                                        <fieldset className="form-group">
                                                            <label>Enter Password</label>
                                                            <input
                                                                type="password"
                                                                className="form-control"
                                                                placeholder="********"
                                                            />
                                                        </fieldset>
                                                        <fieldset className="form-group">
                                                            <label>Enter Confirm Password </label>
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
                                                                Create Your Account
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
                                                                I Agree with{" "}
                                                                <a href="#">Term and Conditions</a>
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
                                                                <i className="mdi mdi-lock"></i> LOGIN
                                                            </a>
                                                        </li>
                                                        <li className="nav-item">
                                                            <a
                                                                className="nav-link"
                                                                data-toggle="tab"
                                                                href="#register"
                                                                role="tab"
                                                            >
                                                                <i className="mdi mdi-pencil"></i> REGISTER
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
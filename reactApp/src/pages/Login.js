import { useEffect, useState } from "react";
import { Link, useNavigate, useSearchParams } from "react-router-dom";
import userApi from "../apis/userApi";
import validator from "validator";
import { Spin, message } from "antd";
import { LoadingOutlined } from "@ant-design/icons";

import { useDispatch, useSelector } from "react-redux";
import { setUser } from "../state_manager_redux/user/userSlice";
const Login = () => {
  useEffect(() => {
    user && navigate("/home");
  }, []);
  const [userName, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [loginFail, setLoginFail] = useState(false);
  const [showPassword, setShowPassword] = useState(false);
  const [validateMsg, setValidateMsg] = useState("");
  const navigate = useNavigate();
  const dispatch = useDispatch();
  const antIcon = <LoadingOutlined style={{ fontSize: 32 }} spin />;
  const [loading, setLoading] = useState(false);
  const [searchParams] = useSearchParams();
  const urlRedirect = searchParams.get("urlRedirect");
  const user = useSelector((state) => state.user);
  const handleLogin = () => {
    setLoginFail(false);
    const isValid = validateAll();
    if (!isValid) return;
    setLoading(true);
    const login = async () => {
      const result = await userApi.login({ userName, password }).catch(() => {
        setLoginFail(true);
        setLoading(false);
      });
      if (result && result.user.role === "customer") {
        const setUserAction = setUser({ ...result });
        dispatch(setUserAction);
        urlRedirect !== null ? navigate(`${urlRedirect}`) : navigate("/home");
        message.success({
          duration: 3,
          content: "Đăng nhập thành công",
        });
      }
    };
    login();
  };

  const onChangeUserName = (event) => {
    setUsername(event.target.value);
  };
  const onChangePassword = (event) => {
    setPassword(event.target.value);
  };

  const validateAll = () => {
    const msg = {};
    if (validator.isEmpty(userName)) {
      msg.userName = "Vui lòng nhập mục này";
    }
    if (validator.isEmpty(password)) {
      msg.password = "Vui lòng nhập mục này";
    }

    setValidateMsg(msg);
    if (Object.keys(msg).length > 0) return false;
    return true;
  };

  return (
    <>
      <div className="d-flex justify-content-center">
        {loading ? (
          <>
            <Spin indicator={antIcon} /> <br /> <br />{" "}
          </>
        ) : null}
      </div>
      <div className="container d-flex justify-content-center">
        <div className="login-modal-main" id="bd-example-modal">
          <div className="modal-lg modal-dialog-centered" role="document">
            <div className="modal-content">
              <div className="modal-body">
                <div className="login-modal">
                  <div className="row">
                    <div className="col-lg-6 pad-right-0">
                      <div className="login-modal-left"></div>
                    </div>
                    <div className="col-lg-6 pad-left-0">
                      <div className="login-modal-right">
                        <div className="tab-content">
                          <div
                            className="tab-pane fade show active"
                            id="login"
                            role="tabpanel"
                            aria-labelledby="tab1"
                          >
                            <h5 className="heading-design-h5">
                              Đăng nhập vào tài khoản của bạn
                            </h5>
                            <fieldset className="form-group">
                              <label>Số điện thoại *</label>
                              <input
                                required
                                value={userName}
                                onKeyPress={(e) => {
                                  if (e.key == "Enter") handleLogin();
                                }}
                                onChange={onChangeUserName}
                                type="text"
                                className="form-control"
                                placeholder="nhập email/số điện thoại..."
                              />
                              <span style={{ color: "red" }}>
                                {validateMsg.userName}
                              </span>
                            </fieldset>
                            <fieldset className="form-group">
                              <label>Mật khẩu *</label>
                              <input
                                required
                                type={showPassword ? "text" : "password"}
                                value={password}
                                onKeyPress={(e) => {
                                  if (e.key == "Enter") handleLogin();
                                }}
                                onChange={onChangePassword}
                                className="form-control"
                                placeholder="nhập mật khẩu..."
                              />
                              <span
                                id="show-password-btn"
                                onClick={() => {
                                  setShowPassword(!showPassword);
                                }}
                                className={
                                  showPassword
                                    ? "mdi mdi-eye-off"
                                    : "mdi mdi-eye"
                                }
                              ></span>

                              <span style={{ color: "red" }}>
                                {validateMsg.password}
                              </span>
                            </fieldset>
                            <fieldset className="form-group">
                              <button
                                className="btn btn-lg btn-secondary btn-block"
                                onClick={handleLogin}
                              >
                                Đăng nhập
                              </button>
                            </fieldset>
                            {loginFail && (
                              <fieldset className="form-group">
                                <span style={{ color: "red" }}>
                                  Tên đăng nhập hoặc mật khẩu không chính xác
                                </span>
                              </fieldset>
                            )}

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
                              <div className="float-right">
                                <Link to="#">Quên mật khẩu</Link>{" "}
                              </div>
                            </div>
                            <div className="login-with-sites text-center">
                              <p>Đăng nhập bằng tài khoản khác:</p>
                              <button className="btn-facebook login-icons btn-lg">
                                <i className="mdi mdi-facebook"></i> Facebook
                              </button>
                              <button className="btn-google login-icons btn-lg">
                                <i className="mdi mdi-google"></i> Google
                              </button>
                            </div>
                          </div>
                          <form
                            className="tab-pane fade show"
                            id="register"
                            role="tabpanel"
                            aria-labelledby="tab2"
                          >
                            <div>
                              <h5 className="heading-design-h5">
                                Đăng ký tài khoản mới!
                              </h5>
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
                                <span
                                  id="show-password-btn"
                                  onClick={() => {
                                    setShowPassword(!showPassword);
                                  }}
                                  className={
                                    showPassword
                                      ? "mdi mdi-eye-off"
                                      : "mdi mdi-eye"
                                  }
                                ></span>
                              </fieldset>
                              <fieldset className="form-group">
                                <label>Nhập lại mật khẩu </label>
                                <input
                                  type="password"
                                  className="form-control"
                                  placeholder="********"
                                />
                                <span
                                  id="show-password-btn"
                                  onClick={() => {
                                    setShowPassword(!showPassword);
                                  }}
                                  className={
                                    showPassword
                                      ? "mdi mdi-eye-off"
                                      : "mdi mdi-eye"
                                  }
                                ></span>
                              </fieldset>
                              <fieldset className="form-group">
                                <button className="btn btn-lg btn-secondary btn-block">
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
                          </form>
                        </div>
                        <div className="clearfix"></div>

                        <div className="text-center login-footer-tab">
                          <ul className="nav nav-tabs" role="tablist">
                            <li className="nav-item">
                              <a
                                className="nav-link active"
                                id="tab1"
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
                                id="tab2"
                                data-toggle="tab"
                                href="#register"
                                role="tab"
                              >
                                <i className="mdi mdi-pencil"></i> ĐĂNG KÝ
                              </a>
                            </li>
                          </ul>
                        </div>
                      </div>
                      <div className="clearfix"></div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

export default Login;

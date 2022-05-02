import validator from "validator";
import { Link, useNavigate, useSearchParams } from "react-router-dom";

import { Spin, notification, Button } from "antd";
import userApi from "../../apis/userApi";
import { LoadingOutlined } from "@ant-design/icons";
import { setUser } from "../../state_manager_redux/user/userSlice";
import { useState } from "react";
import { useDispatch } from "react-redux";
import { setLocation } from "../../state_manager_redux/location/locationSlice";
import { auth } from "../../firebase/firebase";
import { RecaptchaVerifier, signInWithPhoneNumber } from "firebase/auth";

const LoginForm = () => {
  const [userName, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [invalidOtp, setInvalidOtp] = useState(false);
  const [loginFail, setLoginFail] = useState(false);
  const [showPassword, setShowPassword] = useState(false);
  const [validateMsg, setValidateMsg] = useState("");
  const [searchParams] = useSearchParams();
  const [otp, setOtp] = useState("");
  const [currentUi, setCurrentUi] = useState("login");
  const urlRedirect = searchParams.get("urlRedirect");
  const navigate = useNavigate();
  const dispatch = useDispatch();
  const antIcon = <LoadingOutlined style={{ fontSize: 32 }} spin />;
  const [loading, setLoading] = useState(false);
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
        if (result.user.address !== null && result.user.address !== "") {
          const setLocationAction = setLocation({
            location: result.user.address,
          });
          dispatch(setLocationAction);
        }
        dispatch(setUserAction);
        urlRedirect !== null ? navigate(`${urlRedirect}`) : navigate("/home");
        notification.success({
          duration: 3,
          message: "Đăng nhập thành công",
          style: { fontSize: 16 },
        });
      }
    };
    login();
  };

  const handleResetPassword = () => {
    setLoading(true);
    const params = {
      username: userName,
      password: password,
    }
    const resetPassword = async () => {
      await userApi.resetPassword(params).then(() => {
        notification.success({duration: 2, 
        message: "Đặt lại mật khẩu thành công!", style: {fontSize: 16}})
        goToLogin();
      }).catch(() => {
        notification.error(({duration: 2,
        message: "Tài khoản không tồn tại!", style:{fontSize: 16}}));
        goToResetPassword();
      }) 
      setLoading(false);
    }
    resetPassword();
  };
  const generateRecapcha = () => {
    window.recaptchaVerifier = new RecaptchaVerifier(
      "sign-in-button",
      {
        size: "invisible",
        callback: (response) => {
          // reCAPTCHA solved, allow signInWithPhoneNumber.
        },
      },
      auth
    );
  };

  const sentOtp = async () => {
    const valid = await validateAll();
    if (!valid) return;
    auth.settings.appVerificationDisabledForTesting = false;
    generateRecapcha();
    let appVerifier = window.recaptchaVerifier;
    signInWithPhoneNumber(auth, "+84" + userName.substring(1, 10), appVerifier)
      .then((confirmationResult) => {
        window.confirmationResult = confirmationResult;
        setCurrentUi("otp");
      })
      .catch((err) => {
        // Error; SMS not sent
        console.log(err);
      });
  };

  const verifyOtp = () => {
    let confirmationResult = window.confirmationResult;
    confirmationResult
      .confirm(otp)
      .then((result) => {
        handleResetPassword();
      })
      .catch((error) => {
        setInvalidOtp(true);
      });
  };

  const goToLogin = () => {
    setCurrentUi("login");
    setValidateMsg([]);
    setUsername("");
    setPassword("");
    setConfirmPassword("");
    setOtp("");
  };
  const goToResetPassword = () => {
    setCurrentUi("resetPassword");
    setValidateMsg([]);
    setUsername("");
    setPassword("");
    setConfirmPassword("");
    setOtp("");
    setLoginFail(false);
  }
  const onChangeUserName = (event) => {
    setUsername(event.target.value);
  };
  const onChangePassword = (event) => {
    setPassword(event.target.value);
  };

  const onChangeConfirmPassword = (event) => {
    setConfirmPassword(event.target.value);
  };

  const validateAll = () => {
    const msg = {};
    if (validator.isEmpty(userName)) {
      msg.userName = "Vui lòng nhập mục này";
    }
    if (validator.isEmpty(password)) {
      msg.password = "Vui lòng nhập mục này";
    }
    if (currentUi === "resetPassword") {
      if (password !== confirmPassword) {
        msg.confirmPassword = "Mật khẩu không khớp";
      }
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
      {currentUi === "login" && (
        <>
          <h5 className="heading-design-h5">Đăng nhập vào tài khoản của bạn</h5>
          <fieldset className="form-group">
            <label>Số điện thoại *</label>
            <input
              required
              value={userName}
              onKeyPress={(e) => {
                if (e.key === "Enter") handleLogin();
              }}
              onChange={onChangeUserName}
              type="text"
              className="form-control"
              placeholder="nhập email/số điện thoại..."
            />
            <span style={{ color: "red" }}>{validateMsg.userName}</span>
          </fieldset>
          <fieldset className="form-group">
            <label>Mật khẩu *</label>
            <input
              required
              type={showPassword ? "text" : "password"}
              value={password}
              onKeyPress={(e) => {
                if (e.key === "Enter") handleLogin();
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
              className={showPassword ? "mdi mdi-eye-off" : "mdi mdi-eye"}
            ></span>

            <span style={{ color: "red" }}>{validateMsg.password}</span>
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
            <div className="float-right">
              <Button onClick={goToResetPassword} type="link">
                Quên mật khẩu
              </Button>{" "}
            </div>
          </div>
        </>
      )}
      {currentUi === "resetPassword" && (
        <>
          <h5 className="heading-design-h5">Đặt lại mật khẩu</h5>
          <fieldset className="form-group">
            <label>Số điện thoại *</label>
            <input
              required
              value={userName}
              onKeyPress={(e) => {
                if (e.key === "Enter") handleResetPassword();
              }}
              onChange={onChangeUserName}
              type="text"
              className="form-control"
              placeholder="nhập email/số điện thoại..."
            />
            <span style={{ color: "red" }}>{validateMsg.userName}</span>
          </fieldset>
          <fieldset className="form-group">
            <label>Mật khẩu mới: *</label>
            <input
              required
              type={showPassword ? "text" : "password"}
              value={password}
              onKeyPress={(e) => {
                if (e.key === "Enter") handleResetPassword();
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
              className={showPassword ? "mdi mdi-eye-off" : "mdi mdi-eye"}
            ></span>

            <span style={{ color: "red" }}>{validateMsg.password}</span>
          </fieldset>
          <fieldset className="form-group">
            <label>Nhập lại mật khẩu: *</label>
            <input
              required
              type={showPassword ? "text" : "password"}
              value={confirmPassword}
              onKeyPress={(e) => {
                if (e.key === "Enter") handleLogin();
              }}
              onChange={onChangeConfirmPassword}
              className="form-control"
              placeholder="nhập mật khẩu..."
            />
            <span
              id="show-password-btn"
              onClick={() => {
                setShowPassword(!showPassword);
              }}
              className={showPassword ? "mdi mdi-eye-off" : "mdi mdi-eye"}
            ></span>

            <span style={{ color: "red" }}>{validateMsg.confirmPassword}</span>
          </fieldset>
          <fieldset className="form-group">
            <button
              className="btn btn-lg btn-secondary btn-block"
              onClick={sentOtp}
            >
              Đặt lại
            </button>
          </fieldset>
          <div className="custom-control custom-checkbox">
            <div className="float-right">
              <Button onClick={goToLogin} type="link">
                Về trang đăng nhập
              </Button>{" "}
            </div>
          </div>
          <div id="sign-in-button"></div>
        </>
      )}
      {currentUi === "otp" && (
        <>
          <fieldset className="form-group">
            <label>Xác nhận mã OTP:</label>
            <input
              type="text"
              className="form-control"
              placeholder="Nhập mã OTP"
              value={otp}
              onChange={(e) => {
                setOtp(e.target.value);
              }}
            />
            {invalidOtp && (
              <span
                className="d-flex justify-content-center"
                style={{ color: "red" }}
              >
                Mã OTP không đúng!
              </span>
            )}
          </fieldset>
          <div className="custom-control custom-checkbox">
            <div className="float-right">
              <Button
                onClick={goToLogin}
                type="link"
              >
                Về trang đăng nhập
              </Button>{" "}
            </div>
          </div>
          <br />
          <br />
          <fieldset className="form-group">
            <button
              className="btn btn-lg btn-secondary btn-block"
              onClick={verifyOtp}
            >
              Xác nhận
            </button>
          </fieldset>
        </>
      )}
    </>
  );
};

export default LoginForm;

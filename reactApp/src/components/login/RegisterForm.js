import { useState } from "react";
import { Spin, notification, Button } from "antd";
import { LoadingOutlined } from "@ant-design/icons";
import userApi from "../../apis/userApi";
import { auth } from "../../firebase/firebase";
import { RecaptchaVerifier, signInWithPhoneNumber } from "firebase/auth";

const RegisterForm = ({ callback }) => {
  const [userName, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [ruleCheckbox, setRuleCheckbox] = useState(false);
  const [showPassword, setShowPassword] = useState(false);
  const [validateMsg, setValidateMsg] = useState("");
  const antIcon = <LoadingOutlined style={{ fontSize: 32 }} spin />;
  const [loading, setLoading] = useState(false);
  const [otp, setOtp] = useState("");
  const [otpUi, setOtpUi] = useState(false);
  const [invalidOtp, setInvalidOtp] = useState(false);
  const [duplicate, setDuplicate] = useState(false);

  const handleRegister = () => {
    setLoading(true);
    const data = {
      phoneNumber: userName,
      password: password,
      role: [
        {
          name: "customer",
        },
      ],
    };
    const register = async () => {
      const result = await userApi.register(data).catch(() => {
        notification.error({
          duration: 2,
          message: "Đăng ký thất bại!",
          style: { fontSize: 16 },
        });
        setLoading(false);
      });
      if (result) {
        if (result.succeeded) {
          notification.success({
            duration: 3,
            message: "Đăng ký thành công!",
            style: { fontSize: 16 },
          });
          callback();
        } else {
          notification.error({
            duration: 2,
            message: "Có lỗi xảy ra trong quá trình xử lý!",
            style: { fontSize: 16 },
          });
        }
        setLoading(false);
      }
    };
    register();
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
  const resentOtp = () => {
    
    generateRecapcha();
    let appVerifier = window.recaptchaVerifier;
    signInWithPhoneNumber(auth, "+84" + userName.substring(1, 10), appVerifier)
      .then((confirmationResult) => {
        console.log(confirmationResult);
        window.confirmationResult = confirmationResult;
        setOtpUi(true);
      })
      .catch((err) => {
        // Error; SMS not sent
        console.log(err);
      });
  };
  const sentOtp = async () => {
    const valid = await validateAll();
    if (!valid) return;
    auth.settings.appVerificationDisabledForTesting = false;
    generateRecapcha();
    let appVerifier = window.recaptchaVerifier;
    signInWithPhoneNumber(auth, "+84" + userName.substring(1, 10), appVerifier)
      .then((confirmationResult) => {
        console.log(confirmationResult);
        window.confirmationResult = confirmationResult;
        setOtpUi(true);
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
        handleRegister();
      })
      .catch((error) => {
        setInvalidOtp(true);
      });
  };

  const validateAll = async () => {
    setLoading(true);
    let duplicateResult = true;
    await userApi
      .checkDuplicate(userName)
      .then((result) => {
        if (result) {
          setDuplicate(false);
          duplicateResult = false;
        }
      })
      .catch((err) => {
        if (err.response.status === 400) setDuplicate(true);
      });
    setLoading(false);
    const msg = {};
    if (
      !/^(0?)(3[2-9]|5[6|8|9]|7[0|6-9]|8[0-6|8|9]|9[0-4|6-9])[0-9]{7}$/.test(
        userName
      )
    ) {
      msg.userName = "Số điện thoại không hợp lệ";
    }
    if (!/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/.test(password)) {
      msg.password =
        "Mật khẩu phải bao gồm ít nhất 1 chữ hoa, 1 chữ thường và chứa ít nhất 8 ký tự!";
    }
    if (password !== confirmPassword) {
      msg.confirmPassword = "Mật khẩu không khớp";
    }
    if (!ruleCheckbox) {
      msg.rule = "Chấp nhận điều khoản sử dụng để đăng ký!";
    }

    setValidateMsg(msg);
    console.log(duplicateResult);
    console.log(validateMsg);
    if (Object.keys(msg).length > 0 || duplicateResult !== false) return false;
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
      <h5 className="heading-design-h5">Đăng ký tài khoản mới!</h5>
      {otpUi ? (
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
          <span>
            Bạn chưa nhận được mã,{" "}
            <Button style={{ padding: 0 }} type="link" onClick={resentOtp}>
              Gửi lại
            </Button>
          </span>
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
      ) : (
        <>
          <fieldset className="form-group">
            <label>Số điện thoại:</label>
            <input
              type="text"
              className="form-control"
              placeholder="Nhập số điện thoại"
              value={userName}
              onChange={(e) => {
                setUsername(e.target.value);
              }}
            />
            <span style={{ color: "red" }}>{validateMsg.userName}</span>
            {duplicate ? (
              <span style={{ color: "red" }}>
                Số điện thoại đã tồn tại trong hệ thống!
              </span>
            ) : null}
          </fieldset>
          <fieldset className="form-group">
            <label>Mật khẩu:</label>
            <input
              type={showPassword ? "text" : "password"}
              className="form-control"
              placeholder="********"
              value={password}
              onChange={(e) => {
                setPassword(e.target.value);
              }}
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
            <label>Nhập lại mật khẩu:</label>
            <input
              type={showPassword ? "text" : "password"}
              className="form-control"
              placeholder="********"
              value={confirmPassword}
              onChange={(e) => {
                setConfirmPassword(e.target.value);
              }}
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
          <div className="custom-control custom-checkbox">
            <input
              type="checkbox"
              className="custom-control-input"
              id="customCheck2"
              checked={ruleCheckbox}
              onChange={() => setRuleCheckbox(!ruleCheckbox)}
            />
            <label className="custom-control-label" htmlFor="customCheck2">
              Tôi đồng ý với <a href="#">điều khoản sử dụng</a>
            </label>
          </div>
          <span style={{ color: "red" }}>{validateMsg.rule}</span>
          <br />
          <fieldset className="form-group">
            <button
              className="btn btn-lg btn-secondary btn-block"
              onClick={sentOtp}
            >
              Đăng ký
            </button>
          </fieldset>
          <div id="sign-in-button"></div>
        </>
      )}
    </>
  );
};

export default RegisterForm;

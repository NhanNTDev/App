import { useState } from "react";
import { Navigate } from "react-router-dom";
import { Spin, message } from "antd";
import { LoadingOutlined } from "@ant-design/icons";
import userApi from "../../apis/userApi";

const RegisterForm = () => {
  const [userName, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [ruleCheckbox, setRuleCheckbox] = useState(false);
  const [showPassword, setShowPassword] = useState(false);
  const [validateMsg, setValidateMsg] = useState("");
  const antIcon = <LoadingOutlined style={{ fontSize: 32 }} spin />;
  const [loading, setLoading] = useState(false);
  const handleRegister = () => {
    const valid = validateAll();
    if (!valid) {
      return;
    }
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
        message.error({
          duration: 2,
          content: "Đăng ký thất bại!",
        });
        setLoading(false);
        return false;
      });
      if (result !== null && result !== undefined) {
        message.success({
          duration: 2,
          content: "Đăng ký thành công!",
        });
      }
      setLoading(false);
      return true;
    };

    const registerResult = register();
    if (registerResult) {
      window.location.replace("/login?afterRegister=true");
    }
  };
  const validateAll = () => {
    const msg = {};
    if (
      !/^(0?)(3[2-9]|5[6|8|9]|7[0|6-9]|8[0-6|8|9]|9[0-4|6-9])[0-9]{7}$/.test(
        userName
      )
    ) {
      msg.userName = "Số điện thoại không hợp lệ";
    }
    if (!/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/.test(password)) {
      msg.password = "Mật khẩu không hợp lệ";
    }
    if (password !== confirmPassword) {
      msg.confirmPassword = "Mật khẩu không khớp";
    }
    if (!ruleCheckbox) {
      msg.rule = "Chấp nhận điều khoản sử dụng để đăng ký!";
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
      <h5 className="heading-design-h5">Đăng ký tài khoản mới!</h5>
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
          onClick={handleRegister}
        >
          Đăng ký
        </button>
      </fieldset>
    </>
  );
};

export default RegisterForm;

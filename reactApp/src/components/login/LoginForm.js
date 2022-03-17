import validator from "validator";
import { Link, useNavigate, useSearchParams } from "react-router-dom";

import { Spin, message } from "antd";
import userApi from "../../apis/userApi";
import { LoadingOutlined } from "@ant-design/icons";
import { setUser } from "../../state_manager_redux/user/userSlice";
import { useState } from "react";
import { useDispatch } from "react-redux";

const LoginForm = () => {
  const [userName, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [loginFail, setLoginFail] = useState(false);
  const [showPassword, setShowPassword] = useState(false);
  const [validateMsg, setValidateMsg] = useState("");
  const [searchParams] = useSearchParams();
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
      <h5 className="heading-design-h5">Đăng nhập vào tài khoản của bạn</h5>
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
        <span style={{ color: "red" }}>{validateMsg.userName}</span>
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
        <input
          type="checkbox"
          className="custom-control-input"
          id="customCheck1"
        />

        <label className="custom-control-label" htmlFor="customCheck1">
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
    </>
  );
};

export default LoginForm;

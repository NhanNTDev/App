import { useState } from "react";
import { LoadingOutlined } from "@ant-design/icons";
import { notification, Spin } from "antd";
import userApi from "../../apis/userApi";
import { useDispatch, useSelector } from "react-redux";
import { logout } from "../../state_manager_redux/user/userSlice";
import { useNavigate } from "react-router-dom";

const ChangePasswordForm = () => {
  const [currentPassword, setCurrentPassword] = useState("");
  const [newPassword, setNewPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [showPassword, setShowPassword] = useState(false);
  const [validateMsg, setValidateMsg] = useState("");
  const [loading, setLoading] = useState(false);
  const user = useSelector((state) => state.user);
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const antIcon = <LoadingOutlined style={{ fontSize: 32 }} spin />;
  const validateAll = () => {
    const msg = {};
    if (
      !/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/.test(currentPassword)
    ) {
      msg.currentPassword = "Mật khẩu không đúng định dạng!";
    }
    if (!/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/.test(newPassword)) {
      msg.newPassword =
        "Mật khẩu phải bao gồm ít nhất 1 chữ hoa, 1 chữ thường và chứa ít nhất 8 ký tự!";
    }
    if (newPassword !== confirmPassword) {
      msg.confirmPassword = "Mật khẩu không khớp!";
    }
    setValidateMsg(msg);
    if (Object.keys(msg).length > 0) return false;
    return true;
  };

  const handleChangePassword = () => {
    const isValid = validateAll();
    if (!isValid) return;
    setLoading(true);
    const data = {
      id: user.id,
      currentPassword: currentPassword,
      password: newPassword,
    };
    const changePassword = async () => {
      const result = await userApi.changePassword(data).catch((err) => {
        notification.error({
          duration: 2,
          message: err.response.data.error.message,
          style: { fontSize: 16 },
        });
      });
      if (result !== undefined) {
        if (result.succeeded) {
          notification.success({
            duration: 2,
            message: "Đổi mật khẩu thành công",
            style: { fontSize: 16 },
          });
          const logoutAction = logout();
          dispatch(logoutAction);
          navigate("/login");
        }
        if (!result.succeeded) {
          notification.success({
            duration: 2,
            message: result.errors[0].description,
            style: { fontSize: 16 },
          });
        }
      }

      setLoading(false);
    };
    changePassword();
  };

  return (
    <div className="card card-body account-right">
      <div className="d-flex justify-content-center">
        {loading ? (
          <>
            <Spin indicator={antIcon} /> <br /> <br />{" "}
          </>
        ) : null}
      </div>
      <div className="widget">
        <div className="section-header">
          <h5 className="heading-design-h5">Đổi mật khẩu</h5>
        </div>
        <form>
          <div className="row">
            <div className="col-sm-12">
              <fieldset className="form-group">
                <label className="control-label">Mật khẩu hiện tại</label>
                <input
                  type={showPassword ? "text" : "password"}
                  className="form-control"
                  placeholder="Mật khẩu hiện tại"
                  value={currentPassword}
                  onChange={(e) => {
                    setCurrentPassword(e.target.value);
                  }}
                />
                <span
                  id="show-password-btn"
                  onClick={() => {
                    setShowPassword(!showPassword);
                  }}
                  className={showPassword ? "mdi mdi-eye-off" : "mdi mdi-eye"}
                ></span>
                <span style={{ color: "red" }}>
                  {validateMsg.currentPassword}
                </span>
              </fieldset>
            </div>
            <div className="col-sm-12">
              <fieldset className="form-group">
                <label className="control-label">Mật khẩu mới</label>
                <input
                  type={showPassword ? "text" : "password"}
                  className="form-control"
                  placeholder="Mật khẩu mới"
                  value={newPassword}
                  onChange={(e) => {
                    setNewPassword(e.target.value);
                  }}
                />
                <span
                  id="show-password-btn"
                  onClick={() => {
                    setShowPassword(!showPassword);
                  }}
                  className={showPassword ? "mdi mdi-eye-off" : "mdi mdi-eye"}
                ></span>
                <span style={{ color: "red" }}>{validateMsg.newPassword}</span>
              </fieldset>
            </div>
            <div className="col-sm-12">
              <fieldset className="form-group">
                <label className="control-label">Nhập lại mật khẩu mới</label>
                <input
                  type={showPassword ? "text" : "password"}
                  className="form-control"
                  placeholder="Nhập lại mật khẩu mới"
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
                <span style={{ color: "red" }}>
                  {validateMsg.confirmPassword}
                </span>
              </fieldset>
            </div>
          </div>
          <br />
          <div className="row">
            <div className="col-sm-12 text-right">
              <button
                type="button"
                className="btn btn-success btn-lg"
                onClick={() => handleChangePassword()}
              >
                Đổi mật khẩu
              </button>
            </div>
          </div>
        </form>
      </div>
    </div>
  );
};

export default ChangePasswordForm;

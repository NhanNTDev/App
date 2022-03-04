import { useState } from "react";
import { useSelector } from "react-redux";
import { DatePicker } from "antd";
import moment from "moment";

const ProfileRight = () => {
  const user = useSelector((state) => state.user);

  const getLastName = () => {
    return user.name.slice(0, user.name.indexOf(" "));
  };
  const getFirstName = () => {
    return user.name.slice(user.name.indexOf(" "), user.name.length);
  };
  const [lastName, setLastname] = useState(getLastName);
  const [firstName, setFirstName] = useState(getFirstName);
  const [phoneNumber, setPhoneNumber] = useState(user.phoneNumber);

  const handleOnChangeDatePicker = () => {};
  const dateFormat = "DD-MM-YYYY";
  const date = new Date(user.dateOfBirth);
  let dateOfBirth =
    date.getDate() + "-" + (date.getMonth() + 1) + "-" + date.getFullYear();

  return (
    <div className="card card-body account-right">
      <div className="widget">
        <div className="section-header">
          <h5 className="heading-design-h5">Thông Tin Của Tôi</h5>
        </div>
        <form>
          <div className="row">
            <div className="col-sm-6">
              <div className="form-group">
                <label className="control-label">
                  Họ <span className="required">*</span>
                </label>
                <input
                  className="form-control border-form-control"
                  value={lastName}
                  type="text"
                />
              </div>
            </div>
            <div className="col-sm-6">
              <div className="form-group">
                <label className="control-label">
                  Tên <span className="required">*</span>
                </label>
                <input
                  className="form-control border-form-control"
                  value={firstName.slice(1, firstName.length)}
                  type="text"
                />
              </div>
            </div>
          </div>
          <div className="row">
            <div className="col-sm-6">
              <div className="form-group">
                <label className="control-label">
                  Số Điện Thoại <span className="required">*</span>
                </label>
                <input
                  className="form-control border-form-control"
                  value={user.phoneNumber}
                  placeholder="123 456 7890"
                  type="text"
                  disabled="true"
                />
              </div>
            </div>
            <div className="col-sm-6">
              <div className="form-group">
                <label className="control-label">
                  Email
                  <span className="required">*</span>
                </label>
                <input
                  className="form-control border-form-control "
                  value={user.email}
                  placeholder="email"
                  type="email"
                />
              </div>
            </div>
          </div>
          <div className="row">
            <div className="col-sm-6">
              <div className="form-group">
                <label className="control-label">
                  Giới tính <span className="required">*</span>
                </label>
                <select
                  className="form-control"
                  name="gender"
                  id="gender"
                  value={user.gender}
                >
                  <option value="Nam">Nam</option>
                  <option value="Nữ">Nữ</option>
                </select>
              </div>
            </div>
            <div className="col-sm-6">
              <div className="form-group">
                <label className="control-label">
                  Ngày sinh
                  <span className="required">*</span>
                </label>
                <DatePicker
                  onChange={handleOnChangeDatePicker}
                  className="form-control"
                  placeholder="Chọn ngày"
                  format={dateFormat}
                  value={moment(dateOfBirth, dateFormat)}
                />
              </div>
            </div>
          </div>

          <div className="row">
            <div className="col-sm-12 text-right">
              <button type="button" className="btn btn-success btn-lg">
                Cập nhật
              </button>
            </div>
          </div>
        </form>
      </div>
    </div>
  );
};

export default ProfileRight;

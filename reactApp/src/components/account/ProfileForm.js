import { useState } from "react";
import { useSelector } from "react-redux";

const ProfileRight = () => {
  
  const user = useSelector((state) => state.user);
  const getLastName = () => {
    return user.name.slice(0, user.name.indexOf(" "));
  }
  const [lastName, setLastname] = useState(getLastName);
  const getFirstName = () => {
    return user.name.slice(user.name.indexOf(" "), user.name.length);
  }
  const [firstName, setFirstName] = useState(getFirstName);

  
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
                  value=""
                  placeholder={user.email}
                  disabled=""
                  type="email"
                />
              </div>
            </div>
          </div>
          
          <div className="row">
            <div className="col-sm-12 text-right">
              <button type="button" className="btn btn-danger btn-lg">
                Hủy
              </button>
              <button type="button" className="btn btn-success btn-lg">
                Lưu
              </button>
            </div>
          </div>
        </form>
      </div>
    </div>
  );
};

export default ProfileRight;

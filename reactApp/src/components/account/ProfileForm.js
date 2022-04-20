import { useEffect, useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import { DatePicker, Spin, notification, Switch } from "antd";
import { LoadingOutlined } from "@ant-design/icons";
import validator from "validator";
import moment from "moment";
import PlacesAutocomplete from "react-places-autocomplete";
import { updateUser } from "../../state_manager_redux/user/userSlice";
import userApi from "../../apis/userApi";

const ProfileForm = () => {
  const user = useSelector((state) => state.user);
  const [name, setName] = useState(user.name);
  const [email, setEmail] = useState(user.email);
  const [gender, setGender] = useState(user.gender);
  const [address, setAddress] = useState(user.address);
  const [published, setPublished] = useState(user.published);
  const [dateOfBirth, setDateOfBirth] = useState(user.dateOfBirth);
  const [validateMsg, setValidateMsg] = useState("");
  const antIcon = <LoadingOutlined style={{ fontSize: 32 }} spin />;
  const [loading, setLoading] = useState(false);
  const handleOnChangeDatePicker = () => {};
  const dateFormat = "YYYY-MM-DD";
  const dispatch = useDispatch();
  const [gmapsLoaded, setGmapsLoaded] = useState(false);

  useEffect(() => {
    window.initMap = () => setGmapsLoaded(true);
    const currentGmap = document.getElementById("gmapScriptEl");
    if (currentGmap === null) {
      const gmapScriptEl = document.createElement(`script`);
      gmapScriptEl.src = `https://maps.googleapis.com/maps/api/js?key=${process.env.REACT_APP_GOOGLE_MAP_API_KEY}&libraries=places&callback=initMap`;
      gmapScriptEl.id = "gmapScriptEl";
      document
        .querySelector(`body`)
        .insertAdjacentElement(`beforeend`, gmapScriptEl);
    } else {
      setGmapsLoaded(true);
    }
  }, []);
  useEffect(() => {
    if (name === null) {
      setName("");
    }
    if (email === null) {
      setEmail("");
    }
    if (address === null) {
      setAddress("");
    }
    if (gender === null) {
      setGender("Nam");
    }
  }, []);
  const validateAll = () => {
    const msg = {};
    if (validator.isEmpty(name)) {
      msg.name = "Vui lòng nhập mục này!";
    }
    if (!validator.isEmail(email)) {
      msg.email = "Email không hợp lệ!";
    }
    if (validator.isEmpty(address)) {
      msg.address = "Vui lòng nhập mục này!";
    }
    if (dateOfBirth === null) {
      msg.dateOfBirth = "Vui lòng nhập mục này!";
    }

    setValidateMsg(msg);
    if (Object.keys(msg).length > 0) return false;
    return true;
  };

  const handleUpdate = () => {
    const isValid = validateAll();
    const update = async (data) => {
      const result = await userApi.update(data).catch((err) => {
        console.log(err);
      });
      setLoading(false);
      if (result.succeeded) {
        notification.success({
          duration: 3,
          message: "Cập nhật thành công!",
          style:{fontSize: 16},
        });
        return true;
      } else {
        notification.error({
          duration: 3,
          message: "Cập nhật thất bại!",
          style:{fontSize: 16},
        });
        return false;
      }
    };
    if (isValid) {
      const dataUpdate = {
        id: user.id,
        email: email,
        name: name,
        address: address,
        gender: gender,
        dateOfBirth: dateOfBirth,
        published: published,
      };
      setLoading(true);
      const result = update(dataUpdate);
      if (result) {
        const action = updateUser(dataUpdate);
        dispatch(action);
      }
    }
  };

  const handleChange = (address) => {
    setAddress(address);
  };

  const handleSelect = (address) => {
    if(address === undefined || address.trim() === "") return;
    setAddress(address);
  };
  const disableDate = (current) => {
    return current && current > moment().endOf("day");
  }
  const searchOptions = {
    componentRestrictions: { country: ["vn"] },
    types: ["address"],
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
          <h5 className="heading-design-h5">Thông Tin Của Tôi</h5>
        </div>
        <form>
          <div className="row">
            <div className="col-sm-6">
              <div className="form-group">
                <label className="control-label">Họ Và Tên:</label>
                <input
                  className="form-control border-form-control"
                  value={name}
                  onChange={(e) => setName(e.target.value)}
                  placeholder="Họ và tên"
                  type="text"
                />
                <span style={{ color: "red" }}>{validateMsg.name}</span>
              </div>
            </div>
            <div className="col-sm-6">
              <div className="form-group">
                <label className="control-label">Email:</label>
                <input
                  className="form-control border-form-control "
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  placeholder="email"
                  type="email"
                />
                <span style={{ color: "red" }}>{validateMsg.email}</span>
              </div>
            </div>
          </div>
          <div className="row">
            <div className="col-sm-6">
              <div className="form-group">
                <label className="control-label">Giới Tính:</label>
                <select
                  className="form-control"
                  name="gender"
                  id="gender"
                  value={gender}
                  onChange={(e) => setGender(e.target.value)}
                >
                  <option value="Nam">Nam</option>
                  <option value="Nữ">Nữ</option>
                </select>
              </div>
            </div>
            <div className="col-sm-6">
              <div className="form-group">
                <label className="control-label">Ngày Sinh:</label>
                <DatePicker
                  onChange={handleOnChangeDatePicker}
                  className="form-control"
                  placeholder="Chọn ngày"
                  disabledDate={disableDate}
                  format={dateFormat}
                  value={dateOfBirth && moment(dateOfBirth, dateFormat)}
                  defaultValue={dateOfBirth && moment(new Date(), dateFormat)}
                  onChange={(date, dateString) => {
                    date && setDateOfBirth(dateString);
                  }}
                />
                <span style={{ color: "red" }}>{validateMsg.dateOfBirth}</span>
              </div>
            </div>
          </div>
          <div className="row">
          <div className="col-sm-12">
              <div className="form-group">
                <label className="control-label">Công Khai Thông Tin Mua Hàng:</label> {"          "}
                <Switch checked={published} onChange={(checked) => {
                  setPublished(checked);
                }}/>
              </div>
            </div>
          </div>
          <div className="row">
            <div className="col-sm-12">
              <div className="form-group">
                <label className="control-label">Địa Chỉ: </label>
                {gmapsLoaded && <PlacesAutocomplete
                  value={address}
                  onChange={handleChange}
                  onSelect={handleSelect}
                  searchOptions={searchOptions}
                >
                  {({
                    getInputProps,
                    suggestions,
                    getSuggestionItemProps,
                    loading,
                  }) => (
                    <div>
                      <input
                        {...getInputProps({
                          placeholder: "Nhập địa chỉ",
                          className: "form-control",
                        })}
                      />
                      <div className="autocomplete-dropdown-container">
                        {loading && <div>Đang tải...</div>}
                        {suggestions.map((suggestion) => {
                          const className = suggestion.active
                            ? "suggestion-item--active"
                            : "suggestion-item";
                          // inline style for demonstration purpose
                          const style = suggestion.active
                            ? { backgroundColor: "#fafafa", cursor: "pointer" }
                            : { backgroundColor: "#ffffff", cursor: "pointer" };
                          return (
                            <div
                              {...getSuggestionItemProps(suggestion, {
                                className,
                                style,
                              })}
                            >
                              <span>{suggestion.description}</span>
                            </div>
                          );
                        })}
                      </div>
                    </div>
                  )}
                </PlacesAutocomplete> }
                <span style={{ color: "red" }}>{validateMsg.address}</span>
              </div>
            </div>
          </div>

          <div className="row">
            <div className="col-sm-12 text-right">
              <button
                type="button"
                className="btn btn-success btn-lg"
                onClick={handleUpdate}
              >
                Cập nhật
              </button>
            </div>
          </div>
        </form>
      </div>
    </div>
  );
};

export default ProfileForm;

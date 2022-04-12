import { useEffect, useState } from "react";
import { useSelector } from "react-redux";
import { Button, Modal, notification } from "antd";
import validator from "validator";
import PlacesAutocomplete from "react-places-autocomplete";
import addressApi from "../../apis/addressApis";

const UpdateAddressForm = ({ currentValue, callback }) => {
  const user = useSelector((state) => state.user);
  const [name, setName] = useState(currentValue.name);
  const [phone, setPhone] = useState(currentValue.phone);
  const [address, setAddress] = useState(currentValue.address1);
  const [isModalVisible, setIsModalVisible] = useState(false);
  const [validateMsg, setValidateMsg] = useState("");
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
  const showModal = () => {
    setIsModalVisible(true);
  };

  const handleOk = () => {
    const valid = validateAll();
    if (!valid) {
      return;
    }
    const createNewAddress = async () => {
      const data = {
        id: currentValue.id,
        name: name,
        phone: phone,
        address1: address,
        customerId: user.id,
      };
      await addressApi
        .update(data)
        .then((result) => {
          if (result === "Update successfully!") {
            notification.success({
              duration: 3,
              message: "Cập nhật địa chỉ thành công!",
              style: { fontSize: 16 },
            });
          } else {
            notification.error({
              duration: 3,
              message: "Cập nhật địa chỉ thất bại!",
              style: { fontSize: 16 },
            });
          }
        })
        .catch(() => {
          notification.error({
            duration: 3,
            message: "Cập nhật địa chỉ thất bại!",
            style: { fontSize: 16 },
          });
        });
      setIsModalVisible(false);
      callback();
    };
    createNewAddress();
  };

  const handleCancel = () => {
    setIsModalVisible(false);
  };
  const handleChange = (address) => {
    setAddress(address);
  };

  const handleSelect = (address) => {
    setAddress(address);
  };
  const searchOptions = {
    componentRestrictions: { country: ["vn"] },
    types: ["address"],
  };
  const validateAll = () => {
    const msg = {};
    if (validator.isEmpty(name)) {
      msg.name = "Vui lòng nhập mục này";
    }
    if (
      !/^(0?)(3[2-9]|5[6|8|9]|7[0|6-9]|8[0-6|8|9]|9[0-4|6-9])[0-9]{7}$/.test(
        phone
      )
    ) {
      msg.phone = "Số điện thoại không hợp lệ";
    }
    if (validator.isEmpty(address)) {
      msg.address = "Vui lòng nhập mục này";
    }
    setValidateMsg(msg);
    if (Object.keys(msg).length > 0) return false;
    return true;
  };
  return (
    <>
      <Button className="btn" onClick={showModal}>
        {" "}
        Cập Nhật{" "}
      </Button>
      <Modal
        centered
        title="Cập nhật địa chỉ"
        visible={isModalVisible}
        onOk={handleOk}
        onCancel={handleCancel}
        cancelText="Hủy"
        okText="Cập nhật"
      >
        <div className="row">
          <div className="col-sm-6">
            <div className="form-group">
              <label className="control-label">Tên người nhận</label>
              <input
                className="form-control border-form-control"
                value={name}
                placeholder="Tên nhận hàng"
                type="text"
                onChange={(e) => {
                  setName(e.target.value);
                }}
              />
              <span style={{ color: "red" }}>{validateMsg.name}</span>
            </div>
          </div>
          <div className="col-sm-6">
            <div className="form-group">
              <label className="control-label">Số Điện Thoại</label>
              <input
                className="form-control border-form-control"
                value={phone}
                placeholder="Nhập số điện thoại"
                onChange={(e) => {
                  setPhone(e.target.value);
                }}
              />
              <span style={{ color: "red" }}>{validateMsg.phone}</span>
            </div>
          </div>
        </div>

        <div className="row">
          <div className="col-sm-12">
            <div className="form-group">
              <label className="control-label">Địa Chỉ</label>
              {gmapsLoaded && (
                <PlacesAutocomplete
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
                </PlacesAutocomplete>
              )}
              <span style={{ color: "red" }}>{validateMsg.address}</span>
            </div>
          </div>
        </div>
      </Modal>
    </>
  );
};

export default UpdateAddressForm;

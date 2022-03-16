import { useState } from "react";
import { useSelector } from "react-redux";
import { Spin, Radio, Space, Button, Modal } from "antd";
import validator from "validator";
import PlacesAutocomplete from "react-places-autocomplete";

const CreateAddressForm = () => {
  const location = useSelector((state) => state.location);
  const user = useSelector((state) => state.user);
  const [name, setName] = useState(user.name);
  const [phone, setPhone] = useState(user.phoneNumber);
  const [address, setAddress] = useState(location);
  const [isModalVisible, setIsModalVisible] = useState(false);
  const [validateMsg, setValidateMsg] = useState("");
  const showModal = () => {
    setIsModalVisible(true);
  };

  const handleOk = () => {
    setIsModalVisible(false);
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
      <div className="row d-flex justify-content-center">
        <Button onClick={showModal}>
          {" "}
          <i className="mdi mdi-plus"></i> Thêm địa chỉ mới
        </Button>
        <Modal
          centered
          title="Thêm địa chỉ mới"
          visible={isModalVisible}
          onOk={handleOk}
          onCancel={handleCancel}
          cancelText="Hủy"
          okText="Tiếp tục"
          onOk={validateAll}
        >
          <div className="row">
            <div className="col-sm-6">
              <div className="form-group">
                <label className="control-label">Tên người nhận</label>
                <input
                  className="form-control border-form-control"
                  value={name}
                  placeholder={name}
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
                <span style={{ color: "red" }}>{validateMsg.address}</span>
              </div>
            </div>
          </div>
        </Modal>
      </div>
    </>
  );
};

export default CreateAddressForm;

import { useEffect, useState } from "react";
import MenuAccountLeft from "../components/account/MenuAccountLeft";
import addressApi from "../apis/addressApis";
import { useSelector } from "react-redux";
import CreateAddressForm from "../components/address/CreateAddressFrom";
import { Modal, Button, message, notification } from "antd";
import { ExclamationCircleOutlined } from "@ant-design/icons";
import UpdateAddressForm from "../components/address/UpdateAddressFrom";

const { confirm } = Modal;

const Address = () => {
  const [addresses, setAddresses] = useState([]);
  const user = useSelector((state) => state.user);
  const [updateFlag, setUpdateFlag] = useState(true);
  useEffect(() => {
    const fetchAddess = async () => {
      const result = await addressApi
        .getAll(user.id)
        .catch((err) => console.log(err));
      if (result !== null) {
        setAddresses(result);
      }
    };
    fetchAddess();
  }, [updateFlag]);

  const changeFlagCallback = () => {
    setUpdateFlag(!updateFlag);
  };

  function showDeleteConfirm(addressId) {
    confirm({
      title: "Bạn có chắc muốn xóa địa chỉ này?",
      icon: <ExclamationCircleOutlined />,
      content: "Sau khi xóa sẽ không thể khôi phục!",
      okText: "Xóa",
      okType: "danger",
      cancelText: "Hủy",
      onOk() {
        const deleteAddress = async () => {
          const result = await addressApi.delete(addressId).catch((err) => {
            console.log(err);
            notification.error({
              duration: 3,
              message: "Xóa không thành công!",
              style:{fontSize: 16},
            });
          });
          if (result === "Delete successfully!") {
            notification.success({
              duration: 3,
              message: "Xóa thành công!",
              style:{fontSize: 16},
            });
            setUpdateFlag(!updateFlag);
          }
        };
        deleteAddress();
      },
      onCancel() {},
    });
  }

  const renderAddressItem = (props) => {
    return (
      <>
        <div className="border">
          <br />
          <div className="col">
            <strong>Tên người nhận: </strong> {props.name}
            <br />
          </div>
          <div className="col">
            <strong>Số điện thoại: </strong> {props.phone}
            <br />
          </div>
          <div className="col">
            <strong>Địa chỉ: </strong> {props.address1}
            <br />
          </div>
          <br />
          <div className="row">
            <div className="col-sm-12 text-right mb-2">
              <Button
                className="btn"
                style={{ marginRight: 10 }}
                onClick={() => showDeleteConfirm(props.id)}
              >
                {" "}
                Xóa{" "}
              </Button>
              <UpdateAddressForm currentValue= {props} callback= {changeFlagCallback}/>
            </div>
          </div>
        </div>
      </>
    );
  };
  return (
    <section className="account-page section-padding">
      <div className="container">
        <div className="row">
          <div className="col-lg-12 mx-auto">
            <div className="row no-gutters">
              <div className="col-md-4">
                <MenuAccountLeft type="address" />
              </div>
              <div className="col-md-8">
                {addresses.map((address) => renderAddressItem(address))}
                <br />
                <CreateAddressForm
                  currentPage="address"
                  callback={changeFlagCallback}
                />
                <br />
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};

export default Address;

import { useEffect, useState } from "react";
import MenuAccountLeft from "../components/account/MenuAccountLeft";
import AddressForm from "../components/account/AddressForm";
import addressApi from "../apis/addressApis";
import { useSelector } from "react-redux";
import CreateAddressForm from "../components/address/CreateAddressFrom";
import { Button } from "antd";

const Address = () => {
  const [addresses, setAddresses] = useState([]);
  const user = useSelector((state) => state.user);
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
  }, []);

  const renderAddressItem = (props) => {
    return (
      <>
        <div className="border">
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
            <div className="col-sm-12 text-right">
              <Button className="btn" style={{ marginRight: 10 }}>
                {" "}
                Xóa{" "}
              </Button>
              <Button className="btn"> Cập Nhật </Button>
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
          <div className="col-lg-9 mx-auto">
            <div className="row no-gutters">
              <div className="col-md-4">
                <MenuAccountLeft type="address" />
              </div>
              <div className="col-md-8">
                {addresses.map((address) => renderAddressItem(address))}
                {/* <AddressForm /> */}
                <br />
                <CreateAddressForm />
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};

export default Address;

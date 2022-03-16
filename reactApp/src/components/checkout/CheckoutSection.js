import { useEffect, useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import { Link, useNavigate } from "react-router-dom";
import orderApi from "../../apis/orderApi";
import cartApi from "../../apis/cartApi";
import { Spin, Radio, Space} from "antd";
import { LoadingOutlined } from "@ant-design/icons";
import { setCart } from "../../state_manager_redux/cart/cartSlice";
import addressApi from "../../apis/addressApis";
import { getOrderCouter } from "../../state_manager_redux/cart/cartSelector";
import CreateAddressForm from "../address/CreateAddressFrom";

const CheckoutSection = () => {
  const order = useSelector((state) => state.order);
  const cart = useSelector((state) => state.cart);
  const user = useSelector((state) => state.user);
  const [loading, setLoading] = useState(false);
  const antIcon = <LoadingOutlined style={{ fontSize: 32 }} spin />;
  const [addresses, setAddresses] = useState([]);
  const orderCount = useSelector(getOrderCouter);
  const [selectedAddress, setSelectedAddress] = useState();
  const navigate = useNavigate();
  const dispatch = useDispatch();


  useEffect(() => {
    const fetchAddess = async () => {
      const result = await addressApi
        .getAll(user.id)
        .catch((err) => console.log(err));
      if (result !== null) {
        setAddresses(result);
        setSelectedAddress(result[0]);
      }
    };
    fetchAddess();
  }, []);


  const renderCampaign = (props) => {
    return props.harvestCampaigns.map((harvest) =>
      renderHarvestCampaign({ ...harvest })
    );
  };
  

  const onChangeRadio = (e) => {
    setSelectedAddress(e.target.value);
  };

  const renderHarvestCampaign = (props) => {
    if (props.checked) {
      return (
        <div className="card-body pt-0 pr-0 pl-0 pb-0">
          <div className="cart-list-product">
            <a className="float-right remove-cart" href="#">
              <i className="mdi mdi-close"></i>
            </a>
            <img className="img-fluid" src={props.harvest.image1} alt="" />
            <h5>
              <a href="#">{props.productName}</a>
            </h5>
            <h6>
              <strong>Số lượng:</strong> {props.itemCarts[0].quantity}{" "}
              {props.unit}
            </h6>
            <p className="offer-price mb-0">
              {props.price.toLocaleString()}{" "}
              <i className="mdi mdi-tag-outline"></i>{" "}
            </p>
          </div>
        </div>
      );
    }
  };

  const renderAddressRadioItem = (props) => {
    return (
      <Radio key={props.id} value={props}>
        <>
          <strong>{props.name}</strong> - <strong>{props.phone}</strong> <br /> {props.address1}
        </>
      </Radio>
    );
  };

  const handleCheckout = () => {
    setLoading(true);
    const checkout = async () => {
      const data = {
        phone: selectedAddress.phone,
        email: user.email,
        address: selectedAddress.address1,
        customerId: user.id,
        paymentId: 1,
        campaign: order,
      };
      await orderApi.post(data).catch((err) => console.log(err));
    };
    const fetchCartItems = async () => {
      const cartItemsResponse = await cartApi.getAll(user.id);
      const action = setCart(cartItemsResponse);
      dispatch(action);
      setLoading(false);
    };
    checkout();
    fetchCartItems();
  };
 
  return (
    <>
      <section className="checkout-page section-padding">
        <div className="container">
          <div className="row">
            <div className="col-md-8">
              <div className="checkout-step">
                <div className="accordion" id="accordionExample">
                  <div className="card checkout-step-two">
                    <div className="card-header" id="headingTwo">
                      <h5 className="mb-0">
                        <button
                          className="btn btn-link"
                          type="button"
                          aria-expanded="true"
                          aria-controls="collapseTwo"
                        >
                          <span className="number">1</span>Xác Nhận Địa Chỉ Giao
                          Hàng
                        </button>
                      </h5>
                    </div>
                    <div
                      id="collapseTwo"
                      className="collapse show"
                      aria-labelledby="headingTwo"
                      data-parent="#accordionExample"
                    >
                      <div className="card-body">
                        <div className="row">
                          <Radio.Group onChange={onChangeRadio} value={selectedAddress}>
                            <Space direction="vertical">
                              {addresses.map((address) =>
                                renderAddressRadioItem(address)
                              )}
                            </Space>
                          </Radio.Group>
                        </div>
                        <br />
                        <CreateAddressForm/>
                        <br />

                        <button
                          type="button"
                          data-toggle="collapse"
                          data-target="#collapsefour"
                          aria-expanded="false"
                          aria-controls="collapsefour"
                          className="btn btn-secondary mb-2 btn-lg"
                          onClick={handleCheckout}
                        >
                          Tiếp
                        </button>
                        <button
                          type="button"
                          onClick={() => navigate("/cart")}
                          style={{ marginLeft: 30 }}
                          className="btn btn-secondary mb-2 btn-lg"
                        >
                          Trở về
                        </button>
                      </div>
                    </div>
                  </div>

                  <div className="card">
                    <div className="card-header" id="headingThree">
                      <h5 className="mb-0">
                        <button
                          className="btn btn-link collapsed"
                          type="button"
                          aria-expanded="false"
                          aria-controls="collapsefour"
                        >
                          <span className="number">2</span> Hoàn Tất Đặt Hàng
                        </button>
                      </h5>
                    </div>
                    <div
                      id="collapsefour"
                      className="collapse"
                      aria-labelledby="headingThree"
                      data-parent="#accordionExample"
                    >
                      <div className="card-body">
                        <div className="text-center">
                          {loading ? (
                            <>
                              <Spin indicator={antIcon} /> <br /> <br />{" "}
                            </>
                          ) : (
                            <>
                              <div className="col-lg-10 col-md-10 mx-auto order-done">
                                <i className="mdi mdi-check-circle-outline text-secondary"></i>

                                <h4 className="text-success">
                                  Chúc mừng! Đơn hàng của bạn đã thành công.
                                </h4>
                              </div>
                              <div className="text-center">
                                <Link to="/">
                                  <button
                                    type="submit"
                                    className="btn btn-secondary mb-2 btn-lg"
                                  >
                                    Về Trang chủ
                                  </button>
                                </Link>
                              </div>
                            </>
                          )}
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div className="col-md-4">
              <div className="card">
                <h5 className="card-header">
                  Giỏ Hàng
                  <span className="text-secondary float-right">
                    {orderCount} sản phẩm
                  </span>
                </h5>
                {Object.values(cart).map((campaign) =>
                  renderCampaign({ ...campaign })
                )}
              </div>
            </div>
          </div>
        </div>
      </section>
    </>
  );
};

export default CheckoutSection;

import { Button, message, notification, Result } from "antd";
import { reload } from "firebase/auth";
import { useEffect, useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import { Link, useNavigate } from "react-router-dom";
import cartApi from "../apis/cartApi";
import TableBody from "../components/cart/TableBody";
import TableFoot from "../components/cart/TableFoot";
import TableHead from "../components/cart/TableHead";
import {
  getCartTotal,
  getOrderCouter,
  getShipcost,
} from "../state_manager_redux/cart/cartSelector";
import { setCart } from "../state_manager_redux/cart/cartSlice";
import { setOrder } from "../state_manager_redux/order/orderSlice";

const Cart = () => {
  const cart = useSelector((state) => state.cart);
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const cartTotal = useSelector(getCartTotal);
  const orderCount = useSelector(getOrderCouter);
  const shipCost = useSelector(getShipcost);
  const total = parseInt(shipCost) + parseInt(cartTotal);
  const [loadErr, setLoadErr] = useState(false);
  const [reload, setReload] = useState(true);
  const user = useSelector((state) => state.user);
  // Get cart from server
  useEffect(() => {
    const fetchCartItems = async () => {
      setLoadErr(false);
      await cartApi
        .getAll(user.id)
        .then((result) => {
          const action = setCart(result);
          dispatch(action);
        })
        .catch((err) => {
          if (err.message === "Network Error") {
            notification.error({
              duration: 3,
              message: "Mất kết nối mạng!",
              style: { fontSize: 16 },
            });
          } else {
            notification.error({
              duration: 3,
              message: "Có lỗi xảy ra trong quá trình xử lý!",
              style: { fontSize: 16 },
            });
          }
          setLoadErr(true);
        });
    };
    if (user !== null) fetchCartItems();
  }, [reload]);
  const handleOrders = () => {
    if (orderCount === 0) {
      notification.error({
        duration: 3,
        message: "Vui lòng chọn sản phẩm!",
        style: { fontSize: 16 },
      });
      return;
    }
    const action = setOrder({
      cart: cart,
    });
    dispatch(action);
    navigate("/checkout");
  };

  const renderCartForCampaign = () => {
    return (
      <>
        <div className="table-responsive">
          <div className="cart-campaign-header text-left">
            <h5>{cart.campaignName}</h5>
          </div>
          <table className="table cart_summary">
            <TableHead campaignId={cart.campaignId} checked={cart.checked} />
            <tbody>
              {cart.farms.map((farm) => (
                <TableBody farm={farm} campaignId={cart.campaignId} />
              ))}
            </tbody>
            <TableFoot />
          </table>
        </div>
      </>
    );
  };

  return (
    <>
      {loadErr ? (
        <Result
          status="error"
          title="Đã có lỗi xảy ra!"
          subTitle="Rất tiếc đã có lỗi xảy ra trong quá trình tải dữ liệu, quý khách vui lòng kiểm tra lại kết nối mạng và thử lại."
          extra={[
            <Button
              type="primary"
              key="console"
              onClick={() => {
                setReload(!reload);
              }}
            >
              Tải lại
            </Button>,
          ]}
        ></Result>
      ) : (
        <>
          {cart === null || Object.entries(cart).length === 0 ? (
            <>
              <div className="d-flex justify-content-center">
                <Result
                  status="warning"
                  title="Giỏ hàng của bạn đang trống!"
                  extra={
                    <Button
                      type="default"
                      className="btn btn-secondary"
                      onClick={() => {
                        navigate("/home");
                      }}
                    >
                      {" "}
                      Tiếp tục mua hàng
                    </Button>
                  }
                />
              </div>
              <br />
              <br />
            </>
          ) : (
            <>
              <section className="pt-3 pb-3 page-info section-padding border-bottom bg-white">
                <div className="container">
                  <div className="row">
                    <div className="col-md-12">
                      <Link to="/home">
                        <strong>
                          <span className="mdi mdi-home"></span> Trang chủ
                        </strong>
                      </Link>{" "}
                      <span className="mdi mdi-chevron-right"></span>{" "}
                      <span>Giỏ hàng</span>
                    </div>
                  </div>
                </div>
              </section>
              <section className="cart-page section-padding">
                <div className="container">
                  <div className="row">
                    <div className="col-md-12">
                      <div className="card card-body cart-table">
                        {renderCartForCampaign({ ...cart })}
                        <button
                          className="btn btn-secondary btn-lg btn-block text-left"
                          type="button"
                          onClick={handleOrders}
                        >
                          <span className="float-left">
                            <i className="mdi mdi-cart-outline"></i> Thanh toán{" "}
                          </span>
                          <span className="float-right">
                            <strong>{total.toLocaleString()} VNĐ</strong>{" "}
                            <span className="mdi mdi-chevron-right"></span>
                          </span>
                        </button>
                      </div>
                    </div>
                  </div>
                </div>
              </section>
            </>
          )}
        </>
      )}
    </>
  );
};

export default Cart;

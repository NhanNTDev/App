import { message, notification } from "antd";
import { useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";
import { Link, useNavigate } from "react-router-dom";
import cartApi from "../apis/cartApi";
import TableBody from "../components/cart/TableBody";
import TableFoot from "../components/cart/TableFoot";
import TableHead from "../components/cart/TableHead";
import {
  getCartTotal,
  getOrderCouter,
} from "../state_manager_redux/cart/cartSelector";
import { setCart } from "../state_manager_redux/cart/cartSlice";
import { setOrder } from "../state_manager_redux/order/orderSlice";

const Cart = () => {
  const cart = useSelector((state) => state.cart);
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const cartTotal = useSelector(getCartTotal);
  const orderCount = useSelector(getOrderCouter);
  const user = useSelector((state) => state.user);
  // Get cart from server
  useEffect(() => {
    const fetchCartItems = async () => {
      const cartItemsResponse = await cartApi.getAll(user.id);
      const action = setCart(cartItemsResponse);
      dispatch(action);
    };
    if (user !== null) fetchCartItems();
  }, []);
  const handleOrders = () => {
    if (orderCount === 0) {
      notification.error({
        duration: 3,
        message: "Vui lòng chọn sản phẩm!",
        style:{fontSize: 16},
      });
      return;
    }
    const action = setOrder({
      cart: cart,
    });
    dispatch(action);
    navigate("/checkout");
  };

  const renderCartForCampaign = (props) => {
    // var result = props.harvestCampaigns.reduce(function (r, a) {
    //   r[a.harvest.farmId] = r[a.harvest.farmId] || [];
    //   r[a.harvest.farmId].push(a);
    //   return r;
    // }, Object.create(null));
    // const newObject = Object.entries(result);
    return (
      <>
        <div className="table-responsive">
          <div className="cart-campaign-header text-left">
            <h5>{cart.campaignName}</h5>
          </div>
          <table className="table cart_summary">
            <TableHead campaignId={cart.campaignId} checked={cart.checked} />
            <tbody>
              {cart.farms.map(farm => <TableBody farm= {farm} campaignId= {cart.campaignId}/>)}
            </tbody>
            <TableFoot />
          </table>
        </div>
      </>
    );
  };

  return cart === null || Object.entries(cart).length === 0 ? (
    <>
      <h1 className="d-flex justify-content-center">
        Giỏ hàng của bạn đang trống!
      </h1>
      <span className="d-flex justify-content-center">
        <button
          className="btn btn-secondary"
          onClick={() => {
            navigate("/home");
          }}
        >
          {" "}
          Tiếp tục mua hàng
        </button>
      </span>
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
                

                {/* <Link to="/checkout"> */}
                <button
                  className="btn btn-secondary btn-lg btn-block text-left"
                  type="button"
                  onClick={handleOrders}
                >
                  <span className="float-left">
                    <i className="mdi mdi-cart-outline"></i> Thanh toán{" "}
                  </span>
                  <span className="float-right">
                    <strong>{cartTotal.toLocaleString()} VNĐ</strong>{" "}
                    <span className="mdi mdi-chevron-right"></span>
                  </span>
                </button>
                {/* </Link> */}
              </div>
            </div>
          </div>
        </div>
      </section>
    </>
  );
};

export default Cart;

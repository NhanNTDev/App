/* eslint-disable array-callback-return */
/* eslint-disable no-lone-blocks */
import { useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import { Link, useNavigate } from "react-router-dom";
import TableBody from "../components/cart/TableBody";
import TableFoot from "../components/cart/TableFoot";
import TableHead from "../components/cart/TableHead";
import { setOrder } from "../state_manager_redux/order/orderSlice";

const Cart = () => {
  const cart = useSelector((state) => state.cart);
  const [totalAll, setTotalAll] = useState(0);
  const dispatch = useDispatch();
  const navigate = useNavigate();

  const calculateTotal = (props) => {
    setTotalAll(totalAll + props)
  }

  const handleOrders = () => {
    const action = setOrder({
      cart: cart
    });
    dispatch(action);
  }

  const renderCartForCampaign = (props) => {
    var result = props.harvestCampaigns.reduce(function (r, a) {
      r[a.harvest.farmId] = r[a.harvest.farmId] || [];
      r[a.harvest.farmId].push(a);
      return r;
    }, Object.create(null));
    const newObject = Object.entries(result);
    console.log(newObject);
    return (
      <>
        <div className="table-responsive">
          <div className="cart-campaign-header text-left">
            <h5>{props.name}</h5>
          </div>
          <table className="table cart_summary">
            <TableHead />
            <tbody>
              {newObject.map(([key, value], index) => {
                return <TableBody farm={value} calculateTotal={calculateTotal}/>;
              })}
            </tbody>
            <TableFoot />
          </table>
        </div>
      </>
    );
  };

  return cart === null ? (
    <>
      <h1 className="d-flex justify-content-center">Giỏ hàng của bạn đang trống!</h1>
      <span className="d-flex justify-content-center"><button onClick={() => {navigate("/home")}}> Quay về trang chủ</button></span>
      <br/>
      <br/>
      
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
                {Object.values(cart).map((campaign) =>
                  renderCartForCampaign({ ...campaign })
                )}

                <Link to="/checkout">
                  <button
                    className="btn btn-secondary btn-lg btn-block text-left"
                    type="button"
                    onClick={handleOrders}
                  >
                    <span className="float-left">
                      <i className="mdi mdi-cart-outline"></i> Thanh toán{" "}
                    </span>
                    <span className="float-right">
                      <strong>{totalAll.toLocaleString()} VNĐ</strong>{" "}
                      <span className="mdi mdi-chevron-right"></span>
                    </span>
                  </button>
                </Link>
              </div>
            </div>
          </div>
        </div>
      </section>
    </>
  );
};

export default Cart;

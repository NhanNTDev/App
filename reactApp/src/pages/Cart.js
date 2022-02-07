import { useState } from "react";
import { useSelector } from "react-redux";
import { Link } from "react-router-dom";
import TableBody from "../components/cart/TableBody";
import TableFoot from "../components/cart/TableFoot";
import TableHead from "../components/cart/TableHead";

const Cart = () => {
  const cart = useSelector((state) => state.cart);

  const [totalAll, setTotalAll] = useState(0);

  const renderCartForCampaign = (props) => {
    var result = props.harvestCampaigns.reduce(function (r, a) {
      r[a.harvest.farmId] = r[a.harvest.farmId] || [];
      r[a.harvest.farmId].push(a);
      return r;
    }, Object.create(null));
    const newObject = Object.entries(result);
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
                return <TableBody farm={value} />;
              })}
            </tbody>
            <TableFoot />
          </table>
        </div>
      </>
    );
  };

  return cart == null ? (
    <h1>giỏ hàng trống</h1>
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

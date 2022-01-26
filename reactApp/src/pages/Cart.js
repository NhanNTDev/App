import { Checkbox } from "antd";
import { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import cartApi from "../apis/cartApi";
import CartItem from "../components/cart/CartItem";
import TableBody from "../components/cart/TableBody";
import TableFoot from "../components/cart/TableFoot";
import TableHead from "../components/cart/TableHead";
import Farm from "./Farm";

const Cart = () => {
  const [cart, setCart] = useState([]);
  const [totalAll, setTotalAll] = useState(0);
  const [cartItems, setCartItems] = useState([]);
  const [harvestCampaigns, setHarvestCampaigns] = useState([]);
  // const caculateTotalAll = () => {
  //   let result = 0;
  //   cart.map(
  //     (campaign) =>
  //       (result =
  //         result + caculateTotal({ ...campaign }) - campaign.campaignDiscount)
  //   );
  //   return result;
  // };

  useEffect(() => {
    const fetchCartItems = async () => {
      const cartItemsResponse = await cartApi.getAll();
      setCart(cartItemsResponse);
    };
    fetchCartItems();
  }, []);

  // useEffect(() => {
  //   setTotalAll(caculateTotalAll());
  // }, [cart]);

  // const caculateTotal = (props) => {
  //   let result = 0;
  //   props.farms.map((farm) =>
  //     farm.products.map(
  //       (product) =>
  //         (result = result + product.productPrice * product.productQuantity)
  //     )
  //   );
  //   return result;
  // };

  const renderCartForCampaign = (props) => {
    var result = props.harvestCampaigns.reduce(function (r, a) {
      r[a.harvest.farmId] = r[a.harvest.farmId] || [];
      r[a.harvest.farmId].push(a);
      return r;
    }, Object.create(null));
    const newObject = Object.entries(result);
    // let total = caculateTotal({ ...props });
    // let discount = props.campaignDiscount;
    // console.log(props.campaignDiscount);
    // let mustPay = total - discount;
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
                return (
                  <TableBody farm={value}/>
                );
              })}
            </tbody>
            <TableFoot />
          </table>
        </div>
      </>
    );
  };

  return (
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
                {cart.map((campaign) => renderCartForCampaign({ ...campaign }))}

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

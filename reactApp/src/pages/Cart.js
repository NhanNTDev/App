import { Checkbox } from "antd";
import { useEffect, useState } from "react";
import { Link } from "react-router-dom";

const Cart = () => {
  const cartDefault = [
    {
      campaignId: "1",
      campaignName: "Đà Lạt - Hồ Chí Minh",
      farms: [
        {
          farmId: "1",
          farmName: "Lâm Đồng Milk Farm",
          address: "Thôn Cầu Sắt, xã Tu Tra, TP.Đà Lạt, Lâm Đồng",  
          products: [
            {
              productId: "1",
              productName: "Cà Chua bi",
              productImage: "/img/categories/rau_hoa_qua.PNG",
              productPrice: 10000,
              productQuantity: 10,
              productUnit: "kg",
            },
            {
              productId: "2",
              productName: "Cà Chua bi",
              productImage: "/img/categories/rau_hoa_qua.PNG",
              productPrice: 10000,
              productQuantity: 10,
              productUnit: "kg",
            },
          ],
        },
        {
          farmId: "2",
          farmName: "Amavi Farm Bảo Lộc",
          address: "99A Lê Thị Pha, Phường 1, TP.Bảo Lộc, Lâm Đồng",  
          products: [
            {
              productId: "3",
              productName: "Cà Chua bi",
              productImage: "/img/categories/rau_hoa_qua.PNG",
              productPrice: 10000,
              productQuantity: 10,
              productUnit: "kg",
            },
            {
              productId: "4",
              productName: "Cà Chua bi",
              productImage: "/img/categories/rau_hoa_qua.PNG",
              productPrice: 10000,
              productQuantity: 10,
              productUnit: "kg",
            },
          ],
        },
      ],
      campaignDiscount: 10000,
    },
    {
      campaignId: "2",
      campaignName: "Đà Lạt - Bình Dương",
      farms: [
        {
          farmId: "3",
          farmName: "Midori Coffee Farm",
          address: "235 Thôn 3, Huyện Lâm Hà, Lâm Đống",  
          products: [
            {
              productId: "5",
              productName: "Cà Chua bi",
              productImage: "/img/categories/rau_hoa_qua.PNG",
              productPrice: 10000,
              productQuantity: 10,
              productUnit: "kg",
            },
            {
              productId: "6",
              productName: "Cà Chua bi",
              productImage: "/img/categories/rau_hoa_qua.PNG",
              productPrice: 10000,
              productQuantity: 10,
              productUnit: "kg",
            },
          ],
        },
        {
          farmId: "4",
          farmName: "EdnaFarm",
          address: "503 Nguyên Tử Lực, Phường 8, TP.Đà Lạt, Lâm Đồng",  
          products: [
            {
              productId: "7",
              productName: "Cà Chua bi",
              productImage: "/img/categories/rau_hoa_qua.PNG",
              productPrice: 10000,
              productQuantity: 10,
              productUnit: "kg",
            },
            {
              productId: "8",
              productName: "Cà Chua bi",
              productImage: "/img/categories/rau_hoa_qua.PNG",
              productPrice: 10000,
              productQuantity: 10,
              productUnit: "kg",
            },
          ],
        },
      ],
      campaignDiscount: 10000,
    },
  ];

  const [cart, setCart] = useState(cartDefault);
  const [totalAll, setTotalAll] = useState(0);
  const caculateTotalAll = () => {
    let result = 0;
    cart.map(
      (campaign) =>
        (result =
          result + caculateTotal({ ...campaign }) - campaign.campaignDiscount)
    );
    return result;
  };

  useEffect(() => {
    setTotalAll(caculateTotalAll());
  }, [cart]);

  const caculateTotal = (props) => {
    let result = 0;
    props.farms.map((farm) =>
      farm.products.map(
        (product) =>
          (result = result + product.productPrice * product.productQuantity)
      )
    );
    return result;
  };

  const renderCartForCampaign = (props) => {
    let total = caculateTotal({ ...props });
    let discount = props.campaignDiscount;
    console.log(props.campaignDiscount);
    let mustPay = total - discount;
    return (
      <>
        <div className="table-responsive">
          <div className="cart-campaign-header text-left">
            <h5>{props.campaignName}</h5>
          </div>
          <table className="table cart_summary">
            {renderTableHead()}
            <tbody>
              {props.farms.map((farm) => renderCartForFarm({ ...farm }))}
            </tbody>
            {renderTableFoot()}
          </table>
        </div>
      </>
    );
  };

  const renderCartForFarm = (props) => {
    return (
      <>   
        {props.products.map((product) => renderTableItem({ ...product }))}
        <tr>
          <td colSpan="8">
            <div className="cart-farm-header">
              <h5>{props.farmName}</h5>
              <h6>
                <i>
                  <span className="mdi mdi-map-marker"></span> Địa Chỉ:
                </i>{" "}
                {props.address}
              </h6>
              <h6>
                <i>
                  Đánh giá:{" "}
                  <span
                    className="mdi mdi-star"
                    style={{ color: "#ebd428" }}
                  ></span>
                  <span
                    className="mdi mdi-star"
                    style={{ color: "#ebd428" }}
                  ></span>
                  <span
                    className="mdi mdi-star"
                    style={{ color: "#ebd428" }}
                  ></span>
                  <span
                    className="mdi mdi-star"
                    style={{ color: "#ebd428" }}
                  ></span>
                </i>{" "}
              </h6>
            </div>
          </td>
        </tr>
      </>
    );
  };

  const renderTableFoot = (props) => {
    return (
      <tfoot>
        <tr>
          <td colSpan="3"></td>
          <td colSpan="2">
            <input
              type="text"
              placeholder="Nhập mã giảm giá"
              className="form-control border-form-control"
            />
          </td>
          <td colSpan="3">
            <button className="btn btn-success float-left" onClick={() => {}}>
              Áp dụng
            </button>
          </td>
        </tr>
      </tfoot>
    );
  };

  const renderTableHead = () => {
    return (
      <thead>
        <tr>
          <th>
            <Checkbox />
          </th>
          <th className="cart_product">Sản phẩm</th>
          <th></th>
          <th>Đơn giá</th>
          <th>Số lượng</th>
          <th>Đơn vị</th>
          <th>Thành Tiền</th>
          <th className="text-center">Thao tác</th>
        </tr>
      </thead>
    );
  };

  const renderTableItem = (props) => {
    return (
      <tr>
        <td className="cart_checkbox">
          <Checkbox />
        </td>
        <td className="cart_product">
          <a href="#">
            <img alt="Product" src={props.productImage} />
          </a>
        </td>
        <td className="cart_description">
          <h5 className="product_name">{props.productName}</h5>
        </td>
        <td className="price">
          <span>{props.productPrice.toLocaleString()} VNĐ</span>
        </td>
        <td className="qty">
          <div className="input-group">
            <span className="input-group-btn">
              <button
                disabled="disabled"
                className="btn btn-theme-round btn-number"
                type="button"
              >
                -
              </button>
            </span>
            <input
              type="Number"
              min="1"
              max="10"
              value={props.productQuantity}
              className="form-control border-form-control form-control-sm input-number"
            />
            <span className="input-group-btn">
              <button className="btn btn-theme-round btn-number" type="button">
                +
              </button>
            </span>
          </div>
        </td>
        <td className="productUnit">
          <span>{props.productUnit}</span>
        </td>
        <td className="total_item">
          <span>
            {(props.productPrice * props.productQuantity).toLocaleString()} VNĐ
          </span>
        </td>
        <td className="action text-center">
          <a
            className="btn btn-sm btn-danger"
            data-original-title="Remove"
            href="#"
            title=""
            data-placement="top"
            data-toggle="tooltip"
          >
            <i className="mdi mdi-close-circle-outline"></i>
          </a>
        </td>
      </tr>
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

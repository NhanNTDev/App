import { Link } from "react-router-dom";

const Cart = () => {
  const renderCampaignHeader = () => {
    return (
      <div className="cart-campaign-header text-left">
        <strong>Chiến dịch:</strong>
        {"   "}
        Đà Lạt - Hồ Chí Minh
      </div>
    );
  };
  const renderFarmHeader = () => {
    return (
      <tr>
        <td colSpan="6">
          <div
            className="cart-farm-header text-center"
            style={{ background: "green" }}
          >
            <strong>Nông trại:</strong>
            {"   "}
            Nguyễn Thành Nhân
          </div>
        </td>
      </tr>
    );
  };
  const renderTableFoot = () => {
    return (
      <tfoot>
        <tr className="form-group">
          <td colSpan="2"></td>
          <td colSpan="1">
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
        <tr>
          <td colSpan="2"></td>
          <td colSpan="1" className="font-weight-bold">
            {" "}
            Giảm giá:{" "}
          </td>
          <td colSpan="3"> 10000 VNĐ </td>
        </tr>
        <tr>
          <td colSpan="2"></td>
          <td colSpan="1" className="font-weight-bold">
            {" "}
            Thành tiền:{" "}
          </td>
          <td colSpan="3"> 300000 VNĐ </td>
        </tr>
        <tr>
          <td colSpan="2"></td>
          <td colSpan="1" className="font-weight-bold">
            {" "}
            Tiền phải trả:{" "}
          </td>
          <td colSpan="3"> 290000 VNĐ </td>
        </tr>
      </tfoot>
    );
  };

  const renderTableHead = () => {
    return (
      <thead>
        <tr>
          <th className="cart_product">Hình ảnh</th>
          <th>Tên sản phẩm</th>
          <th>Đơn giá</th>
          <th>Số lượng</th>
          <th>Thành Tiền</th>
          <th className="text-center">Hành động</th>
          {/* <th className="action">
            <i className="mdi mdi-delete-forever"></i>
          </th> */}
        </tr>
      </thead>
    );
  };

  const renderTableItem = () => {
    return (
      <tr>
        <td className="cart_product">
          <a href="#">
            <img alt="Product" src="img/categories/rau_hoa_qua.PNG" />
          </a>
        </td>
        <td className="cart_description">
          <h5 className="product-name">
            <a href="#">Cà chua bi </a>
          </h5>
        </td>
        <td className="price">
          <span>10000 VNĐ</span>
        </td>
        <td className="qty">
          <div className="input-group">
            <input
              type="Number"
              min="1"
              max="10"
              className="form-control border-form-control form-control-sm input-number"
              name="quant[1]"
            />
          </div>
        </td>
        <td className="price">
          <span>100000 VNĐ</span>
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
      <section class="pt-3 pb-3 page-info section-padding border-bottom bg-white">
        <div class="container">
          <div class="row">
            <div class="col-md-12">
              <Link to="/home">
                <strong>
                  <span class="mdi mdi-home"></span> Home
                </strong>
              </Link>{" "}
              <span class="mdi mdi-chevron-right"></span> <span>Cart</span>
            </div>
          </div>
        </div>
      </section>
      <section className="cart-page section-padding">
        <div className="container">
          <div className="row">
            <div className="col-md-12">
              <div className="card card-body cart-table">
                <div className="table-responsive">
                  {renderCampaignHeader()}
                  <table className="table cart_summary">
                    {renderTableHead()}
                    <tbody>
                      {renderFarmHeader()}
                      {renderTableItem()}
                      {renderTableItem()}
                      {renderFarmHeader()}
                      {renderTableItem()}
                      {renderTableItem()}
                      {renderFarmHeader()}
                      {renderTableItem()}
                      {renderTableItem()}
                    </tbody>
                    {renderTableFoot()}
                  </table>
                  <Link to="/checkout">
                    <button
                      className="btn btn-secondary-sm btn-block text-left"
                      type="button"
                    >
                      <span className="float-left">
                        <i className="mdi mdi-cart-outline"></i> Tiến hành thanh
                        toán{" "}
                      </span>
                      <span className="float-right">
                        <strong>290000 VNĐ</strong>{" "}
                        <span className="mdi mdi-chevron-right"></span>
                      </span>
                    </button>
                  </Link>
                </div>
                <br />
                <br />
                <div className="table-responsive">
                  {renderCampaignHeader()}
                  <table className="table cart_summary">
                    {renderTableHead()}
                    <tbody>
                      {renderFarmHeader()}
                      {renderTableItem()}
                      {renderTableItem()}
                      {renderFarmHeader()}
                      {renderTableItem()}
                      {renderTableItem()}
                      {renderFarmHeader()}
                      {renderTableItem()}
                      {renderTableItem()}
                    </tbody>
                    {renderTableFoot()}
                  </table>
                  <Link to="/checkout">
                    <button
                      className="btn btn-secondary-sm btn-block text-left"
                      type="button"
                    >
                      <span className="float-left">
                        <i className="mdi mdi-cart-outline"></i> Tiến hành thanh
                        toán{" "}
                      </span>
                      <span className="float-right">
                        <strong>290000 VNĐ</strong>{" "}
                        <span className="mdi mdi-chevron-right"></span>
                      </span>
                    </button>
                  </Link>
                </div>

                <br />
                <br />
                <Link to="/checkout">
                  <button
                    className="btn btn-secondary btn-lg btn-block text-left"
                    type="button"
                  >
                    <span className="float-left">
                      <i className="mdi mdi-cart-outline"></i> Thanh toán tất cả{" "}
                    </span>
                    <span className="float-right">
                      <strong>580000 VNĐ</strong>{" "}
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

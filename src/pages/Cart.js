import { render } from "@testing-library/react";
import { Link } from "react-router-dom";

const Cart = () => {
  const renderTableFoot = () => {
    return (
      <tfoot>
        <tr>
          <td colspan="1"></td>
          <td colspan="4">
            <form className="form-inline float-right">
              <div className="form-group">
                <input
                  type="text"
                  placeholder="Enter discount code"
                  className="form-control border-form-control form-control-sm"
                />
              </div>
              &nbsp;
              <button
                className="btn btn-success float-left btn-sm"
                type="submit"
              >
                Apply
              </button>
            </form>
          </td>
          <td colspan="2">Discount : $237.88 </td>
        </tr>
        <tr>
          <td colspan="2"></td>
          <td className="text-right" colspan="3">
            Total products (tax incl.)
          </td>
          <td colspan="2">$437.88 </td>
        </tr>
        <tr>
          <td className="text-right" colspan="5">
            <strong>Total</strong>
          </td>
          <td className="text-danger" colspan="2">
            <strong>$337.88 </strong>
          </td>
        </tr>
      </tfoot>
    );
  };

  const renderTableHead = () => {
    return (
      <thead>
        <tr>
          <th className="cart_product">Product</th>
          <th>Description</th>
          <th>Avail.</th>
          <th>Unit price</th>
          <th>Qty</th>
          <th>Total</th>
          <th className="action">
            <i className="mdi mdi-delete-forever"></i>
          </th>
        </tr>
      </thead>
    );
  };

  const renderTableItem = () => {
    return (
      <tr>
        <td className="cart_product">
          <a href="#">
            <img alt="Product" src="img/item/10.jpg" className="img-fluid" />
          </a>
        </td>
        <td className="cart_description">
          <h5 className="product-name">
            <a href="#">Ipsums Dolors Untra </a>
          </h5>
          <h6>
            <strong>
              <span className="mdi mdi-approval"></span> Available in
            </strong>{" "}
            - 500 gm
          </h6>
        </td>
        <td className="availability out-of-stock">
          <span className="badge badge-primary">No stock</span>
        </td>
        {/* <td class="availability in-stock"><span class="badge badge-success">In stock</span></td> */}
        <td className="price">
          <span>$00.00</span>
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
              type="text"
              max="10"
              min="1"
              value="1"
              className="form-control border-form-control form-control-sm input-number"
              name="quant[1]"
            />
            <span className="input-group-btn">
              <button className="btn btn-theme-round btn-number" type="button">
                +
              </button>
            </span>
          </div>
        </td>
        <td className="price">
          <span>00.00</span>
        </td>
        <td className="action">
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
                  <table className="table cart_summary">
                    {renderTableHead()}
                    <tbody>
                      {renderTableItem()}
                      {renderTableItem()}
                      {renderTableItem()}
                      {renderTableItem()}
                      {renderTableItem()}
                      {renderTableItem()}
                    </tbody>
                    {renderTableFoot()}
                  </table>
                </div>
                <Link to="/checkout">
                  <button
                    className="btn btn-secondary btn-lg btn-block text-left"
                    type="button"
                  >
                    <span className="float-left">
                      <i className="mdi mdi-cart-outline"></i> Proceed to
                      Checkout{" "}
                    </span>
                    <span className="float-right">
                      <strong>$1200.69</strong>{" "}
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

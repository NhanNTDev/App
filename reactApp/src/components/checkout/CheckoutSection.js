import { useSelector } from "react-redux";
import orderApi from "../../apis/orderApi";

const CheckoutSection = () => {
  const order = useSelector((state) => state.order);
  const cart = useSelector((state) => state.cart);
  const address= useSelector((state) => state.location);
  const user = useSelector(state => state.user)
  
  const handleCheckout = () => {
    const data = {
      phone: user.phoneNumber,
      email: user.email,
      address: address,
      customerId: user.id,
      deliveryZoneId: 1,
      campaign: order
    };
    console.log(data);
    orderApi.post(data);
  }
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
                          data-toggle="collapse"
                          data-target="#collapseTwo"
                          aria-expanded="true"
                          aria-controls="collapseTwo"
                        >
                          <span className="number">1</span> Địa Chỉ Giao Hàng
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
                        <form>
                          <div className="row">
                            <div className="col-sm-6">
                              <div className="form-group">
                                <label className="control-label">
                                  Tên khách hàng <span className="required">*</span>
                                </label>
                                <input
                                  className="form-control border-form-control"
                                  value={user.name}
                                  placeholder={user.name}
                                  type="text"
                                  onChange={() => {}}
                                />
                              </div>                             
                            </div>
                            <div className="col-sm-6">
                              <div className="form-group">
                                <label className="control-label">
                                  Số Điện Thoại{" "}
                                  <span className="required">*</span>
                                </label>
                                <input
                                  className="form-control border-form-control"
                                  value={user.phoneNumber}
                                  placeholder={user.phoneNumber}
                                  type="number"
                                  onChange={() => {}}
                                />
                              </div>
                            </div>
                          </div>

                          <div className="row">
                          <div className="col-sm-6">
                              <div className="form-group">
                                <label className="control-label">
                                  Email <span className="required">*</span>
                                </label>
                                <input
                                  className="form-control border-form-control "
                                  value=""
                                  placeholder={user.email}
                                  disabled=""
                                  type="email"
                                  onChange={() => {}}
                                />
                              </div>
                            </div>
                            <div className="col-sm-6">
                              <div className="form-group">
                                <label className="control-label">
                                  Khu Vực <span className="required">*</span>
                                </label>
                                <select className="select2 form-control border-form-control">
                                  <option value="">Chọn Quận</option>
                                  <option value="AF">Thủ Đức</option>
                                  <option value="AX">Quận 7</option>
                                  <option value="AL">Bình Thạnh</option>
                                  <option value="DZ">Quận 1</option>
                                </select>
                              </div>
                            </div>
                          </div>

                          <div className="row">
                            <div className="col-sm-12">
                              <div className="form-group">
                                <label className="control-label">
                                  Địa Chỉ <span className="required">*</span>
                                </label>
                                <textarea className="form-control border-form-control">{address}</textarea>
                                <small className="text-danger">
                                  Vui lòng cung cấp tên đường và số nhà.
                                </small>
                              </div>
                            </div>
                          </div>

                          <button
                            type="button"
                            data-toggle="collapse"
                            data-target="#collapsefour"
                            aria-expanded="false"
                            aria-controls="collapsefour"
                            className="btn btn-secondary mb-2 btn-lg"
                            onClick={handleCheckout}
                          >
                            TIẾP
                          </button>
                        </form>
                      </div>
                    </div>
                  </div>

                  {/* <div className="card">
                    <div className="card-header" id="headingThree">
                      <h5 className="mb-0">
                        <button
                          className="btn btn-link collapsed"
                          type="button"
                          data-toggle="collapse"
                          data-target="#collapseThree"
                          aria-expanded="false"
                          aria-controls="collapseThree"
                        >
                          <span className="number">3</span> Thanh Toán
                        </button>
                      </h5>
                    </div>
                    <div
                      id="collapseThree"
                      className="collapse"
                      aria-labelledby="headingThree"
                      data-parent="#accordionExample"
                    >
                      <div className="card-body">
                        <form className="col-lg-8 col-md-8 mx-auto">
                          <div className="form-group">
                            <label className="control-label">Số Thẻ</label>
                            <input
                              className="form-control border-form-control"
                              value=""
                              placeholder="0000 0000 0000 0000"
                              type="text"
                              onChange={()=>{}}
                            />
                          </div>
                          <div className="row">
                            <div className="col-sm-3">
                              <div className="form-group">
                                <label className="control-label">Tháng</label>
                                <input
                                  className="form-control border-form-control"
                                  value=""
                                  placeholder="01"
                                  type="text"
                                  onChange={()=>{}}
                                />
                              </div>
                            </div>
                            <div className="col-sm-3">
                              <div className="form-group">
                                <label className="control-label">Năm</label>
                                <input
                                  className="form-control border-form-control"
                                  value=""
                                  placeholder="15"
                                  type="text"
                                  onChange={()=>{}}
                                />
                              </div>
                            </div>
                            <div className="col-sm-3"></div>
                            <div className="col-sm-3">
                              <div className="form-group">
                                <label className="control-label">CVV</label>
                                <input
                                  className="form-control border-form-control"
                                  value=""
                                  placeholder="135"
                                  type="text"
                                  onChange={()=>{}}
                                />
                              </div>
                            </div>
                          </div>

                          <div className="custom-control custom-radio">
                            <input
                              type="radio"
                              id="customRadio1"
                              name="customRadio"
                              className="custom-control-input"
                              onChange={()=>{}}
                            />
                            <label
                              className="custom-control-label"
                              htmlFor="customRadio1"
                            >
                              Bạn có muốn thanh toán bằng tiền mặt không?
                            </label>
                          </div>
                          <button
                            type="button"
                            data-toggle="collapse"
                            data-target="#collapsefour"
                            aria-expanded="false"
                            aria-controls="collapsefour"
                            className="btn btn-secondary mb-2 btn-lg"
                          >
                            TIẾP
                          </button>
                        </form>
                      </div>
                    </div>
                  </div> */}

                  <div className="card">
                    <div className="card-header" id="headingThree">
                      <h5 className="mb-0">
                        <button
                          className="btn btn-link collapsed"
                          type="button"
                          // data-toggle="collapse"
                          // data-target="#collapsefour"
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
                          <div className="col-lg-10 col-md-10 mx-auto order-done">
                            <i className="mdi mdi-check-circle-outline text-secondary"></i>
                            <h4 className="text-success">
                              Chúc mừng! Đơn hàng của bạn đã thành công.
                            </h4>
                          </div>
                          <div className="text-center">
                            <a href="shop.html">
                              <button
                                type="submit"
                                className="btn btn-secondary mb-2 btn-lg"
                              >
                                Về Cửa Hàng
                              </button>
                            </a>
                          </div>
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
                  <span className="text-secondary float-right">(5 item)</span>
                </h5>
                <div className="card-body pt-0 pr-0 pl-0 pb-0">
                  <div className="cart-list-product">
                    <a className="float-right remove-cart" href="#">
                      <i className="mdi mdi-close"></i>
                    </a>
                    <img className="img-fluid" src="img/item/11.jpg" alt="" />
                    <h5>
                      <a href="#">Dâu Tây</a>
                    </h5>
                    <h6>
                      <strong>
                        <span className="mdi mdi-approval"></span> Có sẵn
                      </strong>{" "}
                      - 500 gm
                    </h6>
                    <p className="offer-price mb-0">
                      32.000 VNĐ <i className="mdi mdi-tag-outline"></i>{" "}
                      <span className="regular-price">36.000 VNĐ</span>
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </>
  );
};

export default CheckoutSection;

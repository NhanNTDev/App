const CheckoutSection = () => {
  return (
    <>
      <section className="checkout-page section-padding">
        <div className="container">
          <div className="row">
            <div className="col-md-8">
              <div className="checkout-step">
                <div className="accordion" id="accordionExample">
                  <div className="card checkout-step-one">
                    <div className="card-header" id="headingOne">
                      <h5 className="mb-0">
                        <button
                          className="btn btn-link"
                          type="button"
                          data-toggle="collapse"
                          data-target="#collapseOne"
                          aria-expanded="true"
                          aria-controls="collapseOne"
                        >
                          <span className="number">1</span> Xác Minh Số Điện Thoại
                        </button>
                      </h5>
                    </div>

                    <div
                      id="collapseOne"
                      className="collapse show"
                      aria-labelledby="headingOne"
                      data-parent="#accordionExample"
                    >
                      <div className="card-body">
                        <p>
                          Chúng tôi cần số điện thoại để cập nhật cho bạn trạng thái đơn hàng. 
                        </p>
                        <form>
                          <div className="form-row align-items-center">
                            <div className="col-auto">
                              <label className="sr-only">phone number</label>
                              <div className="input-group mb-2">
                                <div className="input-group-prepend">
                                  <div className="input-group-text">
                                    <span className="mdi mdi-cellphone-iphone"></span>
                                  </div>
                                </div>
                                <input
                                  value=""
                                  type="text"
                                  className="form-control"
                                  placeholder="Nhập số điện thoại"
                                  onChange={()=>{}}
                                />
                              </div>
                            </div>
                            <div className="col-auto">
                              <button
                                type="button"
                                data-toggle="collapse"
                                data-target="#collapseTwo"
                                aria-expanded="false"
                                aria-controls="collapseTwo"
                                className="btn btn-secondary mb-2 btn-lg"
                              >
                                TIẾP
                              </button>
                            </div>
                          </div>
                        </form>
                      </div>
                    </div>
                  </div>

                  <div className="card checkout-step-two">
                    <div className="card-header" id="headingTwo">
                      <h5 className="mb-0">
                        <button
                          className="btn btn-link collapsed"
                          type="button"
                          data-toggle="collapse"
                          data-target="#collapseTwo"
                          aria-expanded="false"
                          aria-controls="collapseTwo"
                        >
                          <span className="number">2</span> Địa Chỉ Giao Hàng
                        </button>
                      </h5>
                    </div>
                    <div
                      id="collapseTwo"
                      className="collapse"
                      aria-labelledby="headingTwo"
                      data-parent="#accordionExample"
                    >
                      <div className="card-body">
                        <form>
                          <div className="row">
                            <div className="col-sm-6">
                              <div className="form-group">
                                <label className="control-label">
                                  Họ <span className="required">*</span>
                                </label>
                                <input
                                  className="form-control border-form-control"
                                  value=""
                                  placeholder="Nguyen"
                                  type="text"
                                  onChange={()=>{}}
                                />
                              </div>
                            </div>
                            <div className="col-sm-6">
                              <div className="form-group">
                                <label className="control-label">
                                  Tên <span className="required">*</span>
                                </label>
                                <input
                                  className="form-control border-form-control"
                                  value=""
                                  placeholder="Tam"
                                  type="text"
                                  onChange={()=> {}}
                                />
                              </div>
                            </div>
                          </div>

                          <div className="row">
                            <div className="col-sm-6">
                              <div className="form-group">
                                <label className="control-label">
                                  Số Điện Thoại <span className="required">*</span>
                                </label>
                                <input
                                  className="form-control border-form-control"
                                  value=""
                                  placeholder="123 456 7890"
                                  type="number"
                                  onChange={()=>{}}
                                />
                              </div>
                            </div>
                            <div className="col-sm-6">
                              <div className="form-group">
                                <label className="control-label">
                                  Email <span className="required">*</span>
                                </label>
                                <input
                                  className="form-control border-form-control "
                                  value=""
                                  placeholder="nguyenxuanlinhtam0205@gmail.com"
                                  disabled=""
                                  type="email"
                                  onChange={()=>{}}
                                />
                              </div>
                            </div>
                          </div>

                          <div className="row">
                            <div className="col-sm-6">
                              <div className="form-group">
                                <label className="control-label">
                                  Zip Code <span className="required">*</span>
                                </label>
                                <input
                                  className="form-control border-form-control"
                                  value=""
                                  placeholder="123456"
                                  type="number"
                                  onChange={()=>{}}
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
                                <textarea className="form-control border-form-control"></textarea>
                                <small className="text-danger">
                                  Vui lòng cung cấp tên đường và số nhà.
                                </small>
                              </div>
                            </div>
                          </div>

                          <button
                            type="button"
                            data-toggle="collapse"
                            data-target="#collapseThree"
                            aria-expanded="false"
                            aria-controls="collapseThree"
                            className="btn btn-secondary mb-2 btn-lg"
                          >
                            TIẾP
                          </button>
                        </form>
                      </div>
                    </div>
                  </div>

                  <div className="card">
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
                  </div>

                  <div className="card">
                    <div className="card-header" id="headingThree">
                      <h5 className="mb-0">
                        <button
                          className="btn btn-link collapsed"
                          type="button"
                          data-toggle="collapse"
                          data-target="#collapsefour"
                          aria-expanded="false"
                          aria-controls="collapsefour"
                        >
                          <span className="number">4</span> Hoàn Tất Đặt Hàng
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
                    <span className="badge badge-success">50% OFF</span>
                    <h5>
                      <a href="#">Product Title Here</a>
                    </h5>
                    <h6>
                      <strong>
                        <span className="mdi mdi-approval"></span> Available in
                      </strong>{" "}
                      - 500 gm
                    </h6>
                    <p className="offer-price mb-0">
                      $450.99 <i className="mdi mdi-tag-outline"></i>{" "}
                      <span className="regular-price">$800.99</span>
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

const ProfileRight = () => {
    return (
        <div className="card card-body account-right">
                  <div className="widget">
                    <div className="section-header">
                      <h5 className="heading-design-h5">Thông Tin Của Tôi</h5>
                    </div>
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
                            />
                          </div>
                        </div>
                        <div className="col-sm-6">
                          <div className="form-group">
                            <label className="control-label">
                              Email
                              <span className="required">*</span>
                            </label>
                            <input
                              className="form-control border-form-control "
                              value=""
                              placeholder="nguyenxuanlinhtam0205@gmail.com"
                              disabled=""
                              type="email"
                            />
                          </div>
                        </div>
                      </div>
                      <div className="row">
                        <div className="col-sm-6">
                          <div className="form-group">
                            <label className="control-label">
                              Khu Vực <span className="required">*</span>
                            </label>
                            <select className="select2 form-control border-form-control">
                              <option value="">Chọn Khu Vực</option>
                              <option value="AF">1</option>
                            </select>
                          </div>
                        </div>
                        <div className="col-sm-6">
                          <div className="form-group">
                            <label className="control-label">
                              Thành phố <span className="required">*</span>
                            </label>
                            <select className="select2 form-control border-form-control">
                              <option value="">Chọn Quận</option>
                              <option value="AF">1</option>
                              <option value="AX">2</option>
                              <option value="AL">7</option>
                              <option value="DZ">Thủ Đức</option>
                            </select>
                          </div>
                        </div>
                      </div>

                      <div className="row">
                        <div className="col-sm-12">
                          <div className="form-group">
                            <label className="control-label">
                              Address <span className="required">*</span>
                            </label>
                            <textarea className="form-control border-form-control"></textarea>
                          </div>
                        </div>
                      </div>
                      <div className="row">
                        <div className="col-sm-12 text-right">
                          <button
                            type="button"
                            className="btn btn-danger btn-lg"
                          >
                            Hủy
                          </button>
                          <button
                            type="button"
                            className="btn btn-success btn-lg"
                          >
                            Lưu
                          </button>
                        </div>
                      </div>
                    </form>
                  </div>
                </div>
    )
}

export default ProfileRight

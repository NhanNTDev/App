const AddressForm = () => {
  return (
    <div className="card card-body account-right">
      <div className="widget">
        <div className="section-header">
          <h5 className="heading-design-h5">Địa Chỉ Liên Hệ</h5>
        </div>
        <form>
          <div className="row">
            <div className="col-sm-6">
              <div className="form-group">
                <label className="control-label">
                  Thành Phố <span className="required">*</span>
                </label>
                <select className="select2 form-control border-form-control">
                  <option value="">Chọn Thành Phố</option>
                  <option value="HCM">Hồ Chí Minh</option>
                  <option value="HN">Hà Nội</option>
                  <option value="ĐN">Đà Nẵng</option>
                </select>
              </div>
            </div>
            <div className="col-sm-6">
              <div className="form-group">
                <label className="control-label">
                  City <span className="required">*</span>
                </label>
                <select className="select2 form-control border-form-control">
                  <option value="">Chọn Khu Vực</option>
                  <option value="1">1</option>
                  <option value="2">2</option>
                  <option value="3">3</option>
                  <option value="4">4</option>
                </select>
              </div>
            </div>
          </div>
          
          <div className="row">
            <div className="col-sm-12">
              <div className="form-group">
                <label className="control-label">
                  Địa chỉ 1 <span className="required">*</span>
                </label>
                <textarea className="form-control border-form-control"></textarea>
              </div>
            </div>
          </div>
          <div className="row">
            <div className="col-sm-12">
              <div className="form-group">
                <label className="control-label">
                  Địa chỉ 2 <span className="required">*</span>
                </label>
                <textarea className="form-control border-form-control"></textarea>
              </div>
            </div>
          </div>
          <div className="row">
            <div className="col-sm-12">
              <div className="custom-control custom-checkbox mb-3">
                <input
                  type="checkbox"
                  className="custom-control-input"
                  id="customCheck1"
                />
                <label className="custom-control-label" for="customCheck1">
                  Giống Địa Chỉ Liên Hệ
                </label>
              </div>
            </div>
          </div>
          <div className="row">
            <div className="col-sm-12 text-right">
              <button type="button" className="btn btn-danger btn-lg">
                {" "}
                Hủy{" "}
              </button>
              <button type="button" className="btn btn-success btn-lg">
                {" "}
                Cập Nhật{" "}
              </button>
            </div>
          </div>
        </form>
      </div>
    </div>
  );
};

export default AddressForm;

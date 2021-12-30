const WistlistTable = () => {
  return (
    <div className="card card-body account-right">
      <div className="widget">
        <div className="section-header">
          <h5 className="heading-design-h5">Mục Yêu Thích</h5>
        </div>
        <div className="row no-gutters">
          <div className="col-md-6">
            <div className="product">
              <a href="#">
                <div className="product-header">
                  <span className="badge badge-success">50% OFF</span>
                  <img alt="" src="img/item/1.jpg" className="img-fluid" />
                  <span className="veg text-success mdi mdi-circle"></span>
                </div>
                <div className="product-body">
                  <h5>Tên Sản Phẩm</h5>
                  <h6>
                    <strong>
                      <span className="mdi mdi-approval"></span> Available in
                    </strong>{" "}
                    - 500 gm
                  </h6>
                </div>
                <div className="product-footer">
                  <button
                    className="btn btn-secondary btn-sm float-right"
                    type="button"
                  >
                    <i className="mdi mdi-cart-outline"></i> Thêm Vào Giỏ Hàng
                  </button>
                  <p className="offer-price mb-0">
                    $450.99 <i className="mdi mdi-tag-outline"></i>
                    <br />
                    <span className="regular-price">$800.99</span>
                  </p>
                </div>
              </a>
            </div>
          </div>
          <div className="col-md-6">
            <div className="product">
              <a href="#">
                <div className="product-header">
                  <span className="badge badge-success">50% OFF</span>
                  <img alt="" src="img/item/2.jpg" className="img-fluid" />
                  <span className="veg text-success mdi mdi-circle"></span>
                </div>
                <div className="product-body">
                  <h5>Tên Sản Phẩm</h5>
                  <h6>
                    <strong>
                      <span className="mdi mdi-approval"></span> Available in
                    </strong>{" "}
                    - 500 gm
                  </h6>
                </div>
                <div className="product-footer">
                  <button
                    className="btn btn-secondary btn-sm float-right"
                    type="button"
                  >
                    <i className="mdi mdi-cart-outline"></i> Thêm Vào Giỏ Hàng
                  </button>
                  <p className="offer-price mb-0">
                    $450.99 <i className="mdi mdi-tag-outline"></i>
                    <br />
                    <span className="regular-price">$800.99</span>
                  </p>
                </div>
              </a>
            </div>
          </div>
        </div>
        <div className="row no-gutters">
          <div className="col-md-6">
            <div className="product">
              <a href="#">
                <div className="product-header">
                  <span className="badge badge-success">50% OFF</span>
                  <img alt="" src="img/item/9.jpg" className="img-fluid" />
                  <span className="veg text-success mdi mdi-circle"></span>
                </div>
                <div className="product-body">
                  <h5>Tên Sản Phẩm</h5>
                  <h6>
                    <strong>
                      <span className="mdi mdi-approval"></span> Available in
                    </strong>{" "}
                    - 500 gm
                  </h6>
                </div>
                <div className="product-footer">
                  <button
                    className="btn btn-secondary btn-sm float-right"
                    type="button"
                  >
                    <i className="mdi mdi-cart-outline"></i> Thêm Vào Giỏ Hàng
                  </button>
                  <p className="offer-price mb-0">
                    $450.99 <i className="mdi mdi-tag-outline"></i>
                    <br />
                    <span className="regular-price">$800.99</span>
                  </p>
                </div>
              </a>
            </div>
          </div>
          <div className="col-md-6">
            <div className="product">
              <a href="#">
                <div className="product-header">
                  <span className="badge badge-success">50% OFF</span>
                  <img alt="" src="img/item/5.jpg" className="img-fluid" />
                  <span className="veg text-success mdi mdi-circle"></span>
                </div>
                <div className="product-body">
                  <h5>Tên Sản Phẩm</h5>
                  <h6>
                    <strong>
                      <span className="mdi mdi-approval"></span> Available in
                    </strong>{" "}
                    - 500 gm
                  </h6>
                </div>
                <div className="product-footer">
                  <button
                    className="btn btn-secondary btn-sm float-right"
                    type="button"
                  >
                    <i className="mdi mdi-cart-outline"></i> Thêm Vào Giỏ Hàng
                  </button>
                  <p className="offer-price mb-0">
                    $450.99 <i className="mdi mdi-tag-outline"></i>
                    <br />
                    <span className="regular-price">$800.99</span>
                  </p>
                </div>
              </a>
            </div>
          </div>
        </div>
        <nav>
          <ul className="pagination justify-content-center mt-4">
            <li className="page-item disabled">
              <span className="page-link">Previous</span>
            </li>
            <li className="page-item">
              <a href="#" className="page-link">
                1
              </a>
            </li>
            <li className="page-item active">
              <span className="page-link">
                2<span className="sr-only">(current)</span>
              </span>
            </li>
            <li className="page-item">
              <a href="#" className="page-link">
                3
              </a>
            </li>
            <li className="page-item">
              <a href="#" className="page-link">
                Next
              </a>
            </li>
          </ul>
        </nav>
      </div>
    </div>
  );
};

export default WistlistTable;

import ItemGroup from "./ItemGroup";

const Shop = () => {
  let Campaigns = [
    {
      id: "1",
      title: "Rau củ",
      countFarm: "10",
      location: "Đà Lạt",
    },
    {
      id: "2",
      title: "Quả",
      countFarm: "10",
      location: "Đà Lạt",
    },
    {
      id: "3",
      title: "Hoa Tươi",
      countFarm: "10",
      location: "Đà Lạt",
    },
    {
      id: "4",
      title: "Rau củ sạch",
      countFarm: "10",
      location: "Đà Lạt",
    },
    {
      id: "5",
      title: "Rau sạch",
      countFarm: "10",
      location: "Đà Lạt",
    },
    {
      id: "6",
      title: "Hoa tươi",
      countFarm: "10",
      location: "Đà Lạt",
    },
    {
      id: "7",
      title: "Rau củ sạch",
      countFarm: "10",
      location: "Đà Lạt",
    },
    {
      id: "8",
      title: "Rau sạch",
      countFarm: "10",
      location: "Đà Lạt",
    },
    {
      id: "9",
      title: "Hoa tươi",
      countFarm: "10",
      location: "Đà Lạt",
    },
  ];

  const categorys = [
    {
      id: "1",
      title: "All Fruits",
      tag: "50% sale",
    },
    {
      id: "2",
      title: "All Fruits",
      tag: "5% sale",
    },
    {
      id: "3",
      title: "All Fruits",
      tag: "new",
    },
    {
      id: "4",
      title: "All Fruits",
      tag: "new",
    },
    {
      id: "5",
      title: "All Fruits",
      tag: "new",
    },
    {
      id: "6",
      title: "All Fruits",
      tag: "new",
    },
    {
      id: "7",
      title: "All Fruits",
      tag: "new",
    },
    {
      id: "8",
      title: "All Fruits",
      tag: "new",
    },
  ];

  const prices = [
    {
      id: "1",
      title: "0-100.000",
      tag: "50% sale of",
    },
    {
      id: "2",
      title: "0-100.000",
      tag: "50% sale of",
    },
    {
      id: "3",
      title: "0-100.000",
      tag: "",
    },
    {
      id: "4",
      title: "0-100.000",
      tag: "",
    },
  ];

  const sortTitles = ["Giá (thấp đến cao)", "Giá (cao xuống thấp)", "Tên (A - Z)"];

  const renderDropCategory = () => {
    return (
      <div
        id="collapseOne"
        className="collapse show"
        aria-labelledby="headingOne"
        data-parent="#accordion"
      >
        <div className="card-body card-shop-filters">
          <form className="form-inline mb-3">
            <div className="form-group">
              <input
                type="text"
                className="form-control"
                placeholder="Tìm kiếm theo loại"
              />
              <button type="submit" className="pl-2 pr-2 btn btn-secondary btn-lg">
                <i className="mdi mdi-file-find"></i>
              </button>
            </div>
          </form>
          {categorys.map((category) => (
            <div className="custom-control custom-checkbox" key={category.id}>
              <input
                type="checkbox"
                className="custom-control-input"
                id={category.id}
              />
              <label className="custom-control-label" htmlFor={category.id}>
                {category.title}{" "}
                <span className="badge badge-primary">{category.tag}</span>
              </label>
            </div>
          ))}
        </div>
      </div>
    );
  };

  const renderDropPrice = () => {
    return (
      <div
        id="collapseTwo"
        className="collapse"
        aria-labelledby="headingTwo"
        data-parent="#accordion"
      >
        <div className="card-body card-shop-filters">
          {prices.map((price) => (
            <div className="custom-control custom-checkbox" key={price.id}>
              <input
                type="checkbox"
                className="custom-control-input"
                id={price.id}
              />
              <label className="custom-control-label" htmlFor={price.id}>
                {price.title}{" "}
                <span className="badge badge-warning">{price.tag}</span>
              </label>
            </div>
          ))}
        </div>
      </div>
    );
  };

  const renderSortDrop = () => {
    return (
      <div className="btn-group float-right mt-2">
        <button
          type="button"
          className="btn btn-dark dropdown-toggle"
          data-toggle="dropdown"
          aria-haspopup="true"
          aria-expanded="false"
        >
          Sort by Products &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </button>
        <div className="dropdown-menu dropdown-menu-right">
          {sortTitles.map((sortTitle, index) => (
            <button className="dropdown-item" key={index} onClick={()=>{}}>
              {sortTitle}
            </button>
          ))}
        </div>
      </div>
    );
  };

  return (
    <>
      <section className="pt-3 pb-3 page-info section-padding border-bottom bg-white">
        <div className="container">
          <div className="row">
            <div className="col-md-12">
              <a href="/home">
                <strong>
                  <span className="mdi mdi-home"></span> Home
                </strong>
              </a>{" "}
              <span className="mdi mdi-chevron-right"></span> <a href="#">Tên Shop</a>
            </div>
          </div>
        </div>
      </section>
      <section className="shop-list section-padding">
        <div className="container">
          <div className="row">
            <div className="col-md-3">
              <div className="shop-filters">
                <div id="accordion">
                  <div className="card">
                    <div className="card-header" id="headingOne">
                      <h5 className="mb-0">
                        <button
                          className="btn btn-link"
                          data-toggle="collapse"
                          data-target="#collapseOne"
                          aria-expanded="true"
                          aria-controls="collapseOne"
                        >
                          Category{" "}
                          <span className="mdi mdi-chevron-down float-right"></span>
                        </button>
                      </h5>
                    </div>
                    {renderDropCategory()}
                  </div>
                  <div className="card">
                    <div className="card-header" id="headingTwo">
                      <h5 className="mb-0">
                        <button
                          className="btn btn-link collapsed"
                          data-toggle="collapse"
                          data-target="#collapseTwo"
                          aria-expanded="false"
                          aria-controls="collapseTwo"
                        >
                          Price{" "}
                          <span className="mdi mdi-chevron-down float-right"></span>
                        </button>
                      </h5>
                    </div>
                    {renderDropPrice()}
                  </div>
                </div>
              </div>
              <div className="left-ad mt-4">
                <img
                  className="img-fluid"
                  src="http://via.placeholder.com/254x557"
                  alt=""
                />
              </div>
            </div>
            <div className="col-md-9">
              <a href="#">
                <img className="img-fluid mb-3" src="img/shop.jpg" alt="" />
              </a>
              <div className="shop-head">
                {renderSortDrop()}
                <h5 className="mb-3">Tên Shop</h5>
              </div>
              <div className="row no-gutters">
                <div className="col-md-4">
                  <div className="product">
                    <a href="single.html">
                      <div className="product-header">
                        <span className="badge badge-success">50% OFF</span>
                        <img className="img-fluid" src="img/item/1.jpg" alt="" />
                        <span className="veg text-success mdi mdi-circle"></span>
                      </div>
                      <div className="product-body">
                        <h5>Product Title Here</h5>
                        <h6>
                          <strong>
                            <span className="mdi mdi-approval"></span> Available in
                          </strong>{" "}
                          - 500 gm
                        </h6>
                      </div>
                      <div className="product-footer">
                        <button
                          type="button"
                          className="btn btn-secondary btn-sm float-right"
                        >
                          <i className="mdi mdi-cart-outline"></i> Add To Cart
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
                <div className="col-md-4">
                  <div className="product">
                    <a href="single.html">
                      <div className="product-header">
                        <span className="badge badge-success">50% OFF</span>
                        <img className="img-fluid" src="img/item/2.jpg" alt="" />
                        <span className="veg text-success mdi mdi-circle"></span>
                      </div>
                      <div className="product-body">
                        <h5>Product Title Here</h5>
                        <h6>
                          <strong>
                            <span className="mdi mdi-approval"></span> Available in
                          </strong>{" "}
                          - 500 gm
                        </h6>
                      </div>
                      <div className="product-footer">
                        <button
                          type="button"
                          className="btn btn-secondary btn-sm float-right"
                        >
                          <i className="mdi mdi-cart-outline"></i> Add To Cart
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
                <div className="col-md-4">
                  <div className="product">
                    <a href="single.html">
                      <div className="product-header">
                        <span className="badge badge-success">50% OFF</span>
                        <img className="img-fluid" src="img/item/3.jpg" alt="" />
                        <span className="veg text-success mdi mdi-circle"></span>
                      </div>
                      <div className="product-body">
                        <h5>Product Title Here</h5>
                        <h6>
                          <strong>
                            <span className="mdi mdi-approval"></span> Available in
                          </strong>{" "}
                          - 500 gm
                        </h6>
                      </div>
                      <div className="product-footer">
                        <button
                          type="button"
                          className="btn btn-secondary btn-sm float-right"
                        >
                          <i className="mdi mdi-cart-outline"></i> Add To Cart
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
                <div className="col-md-4">
                  <div className="product">
                    <a href="single.html">
                      <div className="product-header">
                        <span className="badge badge-success">50% OFF</span>
                        <img className="img-fluid" src="img/item/4.jpg" alt="" />
                        <span className="veg text-success mdi mdi-circle"></span>
                      </div>
                      <div className="product-body">
                        <h5>Product Title Here</h5>
                        <h6>
                          <strong>
                            <span className="mdi mdi-approval"></span> Available in
                          </strong>{" "}
                          - 500 gm
                        </h6>
                      </div>
                      <div className="product-footer">
                        <button
                          type="button"
                          className="btn btn-secondary btn-sm float-right"
                        >
                          <i className="mdi mdi-cart-outline"></i> Add To Cart
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
                <div className="col-md-4">
                  <div className="product">
                    <a href="single.html">
                      <div className="product-header">
                        <span className="badge badge-success">50% OFF</span>
                        <img className="img-fluid" src="img/item/5.jpg" alt="" />
                        <span className="veg text-success mdi mdi-circle"></span>
                      </div>
                      <div className="product-body">
                        <h5>Product Title Here</h5>
                        <h6>
                          <strong>
                            <span className="mdi mdi-approval"></span> Available in
                          </strong>{" "}
                          - 500 gm
                        </h6>
                      </div>
                      <div className="product-footer">
                        <button
                          type="button"
                          className="btn btn-secondary btn-sm float-right"
                        >
                          <i className="mdi mdi-cart-outline"></i> Add To Cart
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
                <div className="col-md-4">
                  <div className="product">
                    <a href="single.html">
                      <div className="product-header">
                        <span className="badge badge-success">50% OFF</span>
                        <img className="img-fluid" src="img/item/6.jpg" alt="" />
                        <span className="veg text-success mdi mdi-circle"></span>
                      </div>
                      <div className="product-body">
                        <h5>Product Title Here</h5>
                        <h6>
                          <strong>
                            <span className="mdi mdi-approval"></span> Available in
                          </strong>{" "}
                          - 500 gm
                        </h6>
                      </div>
                      <div className="product-footer">
                        <button
                          type="button"
                          className="btn btn-secondary btn-sm float-right"
                        >
                          <i className="mdi mdi-cart-outline"></i> Add To Cart
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
                <div className="col-md-4">
                  <div className="product">
                    <a href="single.html">
                      <div className="product-header">
                        <span className="badge badge-success">50% OFF</span>
                        <img className="img-fluid" src="img/item/7.jpg" alt="" />
                        <span className="veg text-success mdi mdi-circle"></span>
                      </div>
                      <div className="product-body">
                        <h5>Product Title Here</h5>
                        <h6>
                          <strong>
                            <span className="mdi mdi-approval"></span> Available in
                          </strong>{" "}
                          - 500 gm
                        </h6>
                      </div>
                      <div className="product-footer">
                        <button
                          type="button"
                          className="btn btn-secondary btn-sm float-right"
                        >
                          <i className="mdi mdi-cart-outline"></i> Add To Cart
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
                <div className="col-md-4">
                  <div className="product">
                    <a href="single.html">
                      <div className="product-header">
                        <span className="badge badge-success">50% OFF</span>
                        <img className="img-fluid" src="img/item/8.jpg" alt="" />
                        <span className="veg text-success mdi mdi-circle"></span>
                      </div>
                      <div className="product-body">
                        <h5>Product Title Here</h5>
                        <h6>
                          <strong>
                            <span className="mdi mdi-approval"></span> Available in
                          </strong>{" "}
                          - 500 gm
                        </h6>
                      </div>
                      <div className="product-footer">
                        <button
                          type="button"
                          className="btn btn-secondary btn-sm float-right"
                        >
                          <i className="mdi mdi-cart-outline"></i> Add To Cart
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
                <div className="col-md-4">
                  <div className="product">
                    <a href="single.html">
                      <div className="product-header">
                        <span className="badge badge-success">50% OFF</span>
                        <img className="img-fluid" src="img/item/9.jpg" alt="" />
                        <span className="veg text-success mdi mdi-circle"></span>
                      </div>
                      <div className="product-body">
                        <h5>Product Title Here</h5>
                        <h6>
                          <strong>
                            <span className="mdi mdi-approval"></span> Available in
                          </strong>{" "}
                          - 500 gm
                        </h6>
                      </div>
                      <div className="product-footer">
                        <button
                          type="button"
                          className="btn btn-secondary btn-sm float-right"
                        >
                          <i className="mdi mdi-cart-outline"></i> Add To Cart
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
                    <a className="page-link" href="#">
                      1
                    </a>
                  </li>
                  <li className="page-item active">
                    <span className="page-link">
                      2<span className="sr-only">(current)</span>
                    </span>
                  </li>
                  <li className="page-item">
                    <a className="page-link" href="#">
                      3
                    </a>
                  </li>
                  <li className="page-item">
                    <a className="page-link" href="#">
                      Next
                    </a>
                  </li>
                </ul>
              </nav>
            </div>
          </div>
        </div>
      </section>
      <ItemGroup title="Chiến dịch hot"></ItemGroup>
    </>
  );
};

export default Shop;

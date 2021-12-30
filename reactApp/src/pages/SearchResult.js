import { useEffect, useState } from "react";
import { RECORD_PER_PAGE } from "../constants/Constants";
import { productsList } from "../constants/Data";
import { Pagination } from "antd";
import { Link, useSearchParams } from "react-router-dom";

const ViewAllCampaigns = () => {
  const [page, setPage] = useState(1);
  const [totalRecord, setTotalRecords] = useState(1);
  const [products, setProducts] = useState([]);
  let [searchParams] = useSearchParams();

  useEffect(() => {
    setTotalRecords(36);
  }, []);

  useEffect(() => {
    setProducts(productsList);
  }, [page]);

  const renderPagination = () => {
    return (
      <div className="pagination justify-content-center mt-4">
        <Pagination
          showSizeChanger={false}
          pageSize={RECORD_PER_PAGE}
          defaultCurrent={page}
          total={totalRecord}
          onChange={(pageNumber) => setPage(pageNumber)}
        />
      </div>
    );
  };
  const sortTitles = [
    "Giá (thấp đến cao)",
    "Giá (cao xuống thấp)",
    "Tên (A - Z)",
  ];

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
            <button className="dropdown-item" key={index} onClick={() => {}}>
              {sortTitle}
            </button>
          ))}
        </div>
      </div>
    );
  };

  const renderCampaignItem = (props) => {
    return (
      <div className="col-md-3">
        <div className="product">
          <Link to="/product">
            <div className="product-header">
              {/* <span className="badge badge-success">50% OFF</span> */}
              <img className="img-fluid" src="img/item/3.jpg" alt="" />
              <span className="veg text-success mdi mdi-circle"></span>
            </div>
            <div className="product-body">
              <div style={{ height: 80 }}>
                <h4>{props.name}</h4>
                <h6>
                  <strong>
                    <span class="mdi mdi-approval"></span> Còn lại:
                  </strong>{" "}
                  {props.available} {" / "} {props.maxQuantity} {props.unit}
                </h6>
              </div>
              <div style={{ height: 80 }}>
                <h5>
                  <strong>
                    <span className="mdi mdi-map-marker-circle"></span> Chiến
                    dịch:
                  </strong>{" "}
                  {props.campaignName}
                </h5>
                <h5>
                  <strong>
                    <span className="mdi mdi-flower"></span> Nông trại:
                  </strong>{" "}
                  {props.farmName}
                </h5>
                <br />
              </div>
              <br />
            </div>
          </Link>
          <div className="product-footer">
           
            <button
              type="button"
              className="btn btn-secondary btn-sm float-right"
              onClick={() => {}}
            >
              <i className="mdi mdi-cart"></i> Thêm vào giỏ hàng
            </button>
            <p class="offer-price mb-0">
            <i class="mdi mdi-tag-outline"></i> {props.price.toLocaleString()} {" VNĐ / "} {props.unit} 
                       
                      </p>
            <br />
          </div>
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
                  <span className="mdi mdi-home"></span> Trang chủ
                </strong>
              </a>{" "}
              <span className="mdi mdi-chevron-right"></span>{" "}
              <span>Kết quả tìm kiếm</span>
            </div>
          </div>
        </div>
      </section>
      <section className="shop-list section-padding">
        <div className="container">
          <div className="row">
            <div className="col-md-12">
              <div className="shop-head">
                {renderSortDrop()}
                <h5 className="mb-4">Kết quả cho SearchString</h5>
              </div>
              <div className="row no-gutters">
                {products.map((product) => renderCampaignItem({ ...product }))}
              </div>
              {renderPagination()}
            </div>
          </div>
        </div>
      </section>
    </>
  );
};

export default ViewAllCampaigns;

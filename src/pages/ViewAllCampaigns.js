import { useEffect, useState, useLayoutEffect } from "react";
import { PAGINATION_MAX, RECORD_PER_PAGE } from "../constants/Constants";
import { hotCampaign } from "../constants/Data";

const ViewAllCampaigns = () => {
  const [page, setPage] = useState(1);
  const [pageNumbers, setPageNumbers] = useState([1]);
  const [totalRecord, setTotalRecords] = useState(1);
  const [pageNumbersView, setPageNumbersView] = useState([1]);
  useEffect(() => {
    setTotalRecords(200);
  }, []);

  useEffect(() => {
    let listPage = [];
    for (let i = 1; i <= Math.ceil(totalRecord / RECORD_PER_PAGE); i++) {
      listPage.push(i);
    }
    setPageNumbers(listPage);
  }, [totalRecord]);

  useLayoutEffect(() => {
    let TotalPage = Math.ceil(totalRecord / RECORD_PER_PAGE);
    let listNumbers = [];
    let startNumber = 1;
    let endNumber = TotalPage;
    if (TotalPage > PAGINATION_MAX) {
      if (page < PAGINATION_MAX/2 + 1) {
        endNumber = PAGINATION_MAX;
      }
      if (page >= PAGINATION_MAX/2 + 1) {
        if (page <= TotalPage - PAGINATION_MAX/2) {
          startNumber = page - PAGINATION_MAX/2 - 1;
          endNumber = page + PAGINATION_MAX/2;
        } else {
          startNumber = TotalPage - PAGINATION_MAX - 1;
          endNumber = TotalPage;
        }
      }
    }
    for (startNumber; startNumber <= endNumber; startNumber++) {
      listNumbers.push(startNumber);
    }
    setPageNumbersView(listNumbers);
  }, [pageNumbers, page]);

  const renderPagination = () => {
    return (
      <nav>
        <ul className="pagination justify-content-center mt-4">
          <li className={page === 1 ? "page-item disabled" : "page-item"}>
            <button
              className="page-link"
              onClick={() => {
                setPage(page - 1);
              }}
            >
              Previous
            </button>
          </li>
          {pageNumbersView.map((pageNum) => (
            <li
              className={pageNum === page ? "page-item active" : "page-item"}
              key={pageNum}
            >
              <button
                className="page-link"
                onClick={() => {
                  setPage(pageNum);
                }}
              >
                {pageNum}
              </button>
            </li>
          ))}
          <li
            className={
              page === Math.ceil(totalRecord / RECORD_PER_PAGE)
                ? "page-item disabled"
                : "page-item"
            }
          >
            <button className="page-link" onClick={() => setPage(page + 1)}>
              Next
            </button>
          </li>
        </ul>
      </nav>
    );
  };
  const sortTitles = [
    "Giá (thấp đến cao)",
    "Giá (cao xuống thấp)",
    "Tên (A - Z)",
  ];
  const hotCampaigns = hotCampaign;

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
          <a href="single.html">
            <div className="product-header">
              <span className="badge badge-success">50% OFF</span>
              <img className="img-fluid" src="img/item/3.jpg" alt="" />
              <span className="veg text-success mdi mdi-circle"></span>
            </div>
            <div className="product-body">
              <h4 style={{ height: 80 }}>{props.name}</h4>
              <h5>
                <strong>
                  <span className="mdi mdi-flower"></span> Tổng nông trại:
                </strong>{" "}
                {props.farmJoined}
              </h5>
              <h5>
                <strong>
                  <span className="mdi mdi-map-marker-circle"></span> Từ:
                </strong>{" "}
                {props.from}
              </h5>
              <h5>
                <strong>
                  <span className="mdi mdi-map-marker-circle"></span> Đến:
                </strong>{" "}
                {props.to}
              </h5>
              <br />
            </div>
          </a>
          <div className="product-footer">
            <button
              type="button"
              className="btn btn-secondary btn-sm float-right"
              onClick={() => {}}
            >
              <i className="mdi mdi-eye"></i> Xem chiến dịch
            </button>
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
                  <span className="mdi mdi-home"></span> Home
                </strong>
              </a>{" "}
              <span className="mdi mdi-chevron-right"></span>{" "}
              <span>Tên Shop</span>
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
                <h5 className="mb-4">Tên Shop</h5>
              </div>
              <div className="row no-gutters">
                {hotCampaigns.map((campaign) =>
                  renderCampaignItem({ ...campaign })
                )}
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

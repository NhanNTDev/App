import { useEffect, useState, useLayoutEffect } from "react";
import { RECORD_PER_PAGE } from "../constants/Constants";
import { page1, page2, page3 } from "../constants/Data";
import { Pagination } from "antd";
import { useSearchParams } from "react-router-dom";
import "antd/dist/antd.css";

const ViewAllCampaigns = () => {
  const [page, setPage] = useState(1);
  const [totalRecord, setTotalRecords] = useState(1);
  const [campaigns, setCampaigns] = useState([]);
  let [searchParams] = useSearchParams();
  useEffect(() => {
    setTotalRecords(36);
  }, []);


  useEffect(() => {
    switch (page) {
      case 1:
        setCampaigns(page1);
        break;
      case 2:
        setCampaigns(page2);
        break;
      case 3:
        setCampaigns(page3);
        break;
    }
  }, [page]);

  const renderPagination = () => {
    return (
        <div className="pagination justify-content-center mt-4">
          <Pagination
            showSizeChanger={false}
            pageSize={RECORD_PER_PAGE}
            defaultCurrent={1}
            total={totalRecord}
            onChange = {(pageNumber) => setPage(pageNumber)}
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
              <span>
                {searchParams.get("type") === "hot"
                  ? "Chiến dịch hot"
                  : "Chiến dịch trong tuần"}
              </span>
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
                <h5 className="mb-4">
                  {searchParams.get("type") === "hot"
                    ? "Chiến dịch hot"
                    : "Chiến dịch trong tuần"}
                </h5>
              </div>
              <div className="row no-gutters">
                {campaigns.map((campaign) =>
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

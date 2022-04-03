import { useEffect, useState } from "react";
import { RECORD_PER_PAGE } from "../constants/Constants";
import { Pagination } from "antd";
import { useSearchParams } from "react-router-dom";
import CampaignItem from "../components/campaign/CampaignItem";
import campaignsApi from "../apis/campaignsApi";
import Skeleton from "react-loading-skeleton";
import "react-loading-skeleton/dist/skeleton.css";
import { useSelector } from "react-redux";

const ViewAllCampaigns = () => {
  const [page, setPage] = useState(1);
  const [totalRecord, setTotalRecords] = useState(1);
  const [campaigns, setCampaigns] = useState([]);
  const [loading, setLoading] = useState(true);
  let [searchParams] = useSearchParams();
  const  address = useSelector(state => state.location);

  useEffect(() => {
    const params = {
      address: address,
      page: page,
      size: RECORD_PER_PAGE,
    };
    const fetchCampaigns = async () => {
      const campaignsResponse = await campaignsApi.getAll(params);
      setCampaigns(campaignsResponse.data);
      setTotalRecords(campaignsResponse.metadata.total);
      setLoading(false);
    };

    fetchCampaigns();
  }, [page, address]);

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
              <span>
                {searchParams.get("type") === "other"
                  ? "Chiến dịch khác"
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
                  {searchParams.get("type") === "other"
                    ? "Chiến dịch khác"
                    : "Chiến dịch trong tuần"}
                </h5>
              </div>
              {loading && (
                <Skeleton count={12} width="25%" inline={true} height={250} />
              )}
              <div className="row no-gutters">
                {campaigns.map((campaign) => (
                  <CampaignItem {...campaign} />
                ))}
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

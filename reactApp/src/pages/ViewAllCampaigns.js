import { useEffect, useState } from "react";
import { Button, notification, Pagination, Result } from "antd";
import { useNavigate, useSearchParams } from "react-router-dom";
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
  const [noResult, setNoResult] = useState(false);
  const [networkErr, setNetworkErr] = useState(false);
  const [reload, setReload] = useState(true);
  let [searchParams] = useSearchParams();
  const type = searchParams.get("type");
  const zoneId = useSelector(state => state.zone);
  const navigate = useNavigate();

  useEffect(() => {
    setNoResult(false);
    setNetworkErr(false);
    const params = {
      "delivery-zone-id": parseInt(zoneId),
      type: type,
      page: page,
      size: 12,
    };
    const fetchCampaigns = async () => {
      setLoading(true);
      await campaignsApi
        .getAll(params)
        .then((result) => {
          if (Object.entries(result).length === 0) {
            setNoResult(true);
            return;
          }
          setCampaigns(result.data);
          setTotalRecords(result.metadata.total);
        })
        .catch((err) => {
          if (err.message === "Network Error") {
            notification.error({
              duration: 3,
              message: "Mất kết nối mạng!",
              style: { fontSize: 16 },
            });
            setNetworkErr(true);
            return;
          } else if (err.response.status === 400) {
            notification.error({
              duration: 2,
              message: "Không tồn tại chiến dịch cho địa chỉ của bạn!",
              style: { fontSize: 16 },
            });
          } else {
            notification.error({
              duration: 3,
              message: "Có lỗi xảy ra trong quá trình xử lý!",
              style: { fontSize: 16 },
            });
          }
          setNoResult(true);
        });

      setLoading(false);
    };

    fetchCampaigns();
  }, [page, zoneId, reload, searchParams]);

  const renderPagination = () => {
    return (
      <div className="pagination justify-content-center mt-4">
        <Pagination
          showSizeChanger={false}
          pageSize={12}
          defaultCurrent={1}
          current={page}
          total={totalRecord}
          onChange={(pageNumber) => setPage(pageNumber)}
        />
      </div>
    );
  };

  return (
    <>
      {networkErr ? (
        <Result
          status="error"
          title="Đã có lỗi xảy ra!"
          subTitle="Rất tiếc đã có lỗi xảy ra trong quá trình tải dữ liệu, quý khách vui lòng kiểm tra lại kết nối mạng và thử lại."
          extra={[
            <Button
              type="primary"
              key="console"
              onClick={() => {
                setReload(!reload);
              }}
            >
              Tải lại
            </Button>,
          ]}
        ></Result>
      ) : (
        <>
          {noResult ? (
            <div className="d-flex justify-content-center">
              <Result
                status="warning"
                title="Không tồn tại chiến dịch hổ trợ vị trí của bạn!"
                extra={
                  <Button
                    type="primary"
                    key="console"
                    onClick={() => {
                      navigate("/home");
                    }}
                  >
                    Về trang chủ
                  </Button>
                }
              />
            </div>
          ) : (
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
                        {searchParams.get("type") === "Hàng tuần"
                          ? "Chiến dịch hàng tuần"
                          : "Chiến dịch sự kiện"}
                      </span>
                    </div>
                  </div>
                </div>
              </section>

              <section className="shop-list section-padding">
                <div className="container">
                  <div className="row">
                    <div className="col-md-12">
                      {loading ? (
                        <Skeleton
                          count={12}
                          width="25%"
                          inline={true}
                          height={250}
                        />
                      ) : (
                        <>
                          <div className="row no-gutters">
                            {campaigns.map((campaign) => (
                              <CampaignItem {...campaign} />
                            ))}
                          </div>
                          {renderPagination()}
                        </>
                      )}
                    </div>
                  </div>
                </div>
              </section>
            </>
          )}
        </>
      )}
    </>
  );
};

export default ViewAllCampaigns;

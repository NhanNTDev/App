import { useEffect, useState } from "react";
import { Link, useParams } from "react-router-dom";
import CampaignPicture from "../components/campaign/CampaignPicture";
import CampaignDetail from "../components/campaign/CampaignDetail";
import campaignsApi from "../apis/campaignsApi";
import ProductList from "../components/product/ProductList";
import { runScript } from "../utils/Common";
import LoadingPage from "./LoadingPage";
import { Button, notification, Result } from "antd";

const Campaign = () => {
  const params = useParams();
  const [campaign, setCampaign] = useState(null);
  const [loadingCampaign, setLoadingCampaign] = useState(true);
  const [loadErr, setloadErr] = useState(false);
  const [reload, setReload] = useState(true);
  const campaignId = params.id;

  useEffect(() => {
    const fetchCampaign = async () => {
      setloadErr(false);
      await campaignsApi
        .get(campaignId)
        .then((result) => {
          setCampaign(result);
        })
        .catch((err) => {
          if (err.message === "Network Error") {
            notification.error({
              duration: 3,
              message: "Mất kết nối mạng!",
              style: { fontSize: 16 },
            });
          } else {
            notification.error({
              duration: 3,
              message: "Có lỗi xảy ra trong quá trình xử lý!",
              style: { fontSize: 16 },
            });
          }
          setloadErr(true);
        });

      setLoadingCampaign(false);
      runScript();
    };
    fetchCampaign();
  }, [reload]);

  return (
    <>
      {loadErr ? (
        <Result
          status="error"
          title="Đã có lỗi xảy ra!"
          subTitle="Rất tiếc đã có lỗi xảy ra trong quá trình tải dữ liệu, quý khách vui lòng kiểm tra lại kết nối mạng và thử lại."
          extra={[
            <Button type="primary" key="console" onClick={() => {
              setReload(!reload);
            }}>
              Tải lại
            </Button>,
          ]}
        ></Result>
      ) : (
        <>
          {loadingCampaign ? (
            <LoadingPage />
          ) : (
            <>
              <div className="container">
                <section className="pt-3 pb-3 page-info section-padding border-bottom bg-white">
                  <div className="row">
                    <div className="col-md-12">
                      <Link to="/home">
                        <strong>
                          <span className="mdi mdi-home"></span> Trang chủ
                        </strong>
                      </Link>{" "}
                      <span className="mdi mdi-chevron-right"></span>{" "}
                      <a href="#">{campaign !== null ? campaign.name : ""}</a>
                    </div>
                  </div>
                </section>
              </div>
              <div className="container">
                <section className="shop-single section-padding pt-3">
                  <div className="row">
                    <div className="col-md-3">
                      <CampaignDetail campaign={{ ...campaign }} />
                      <CampaignPicture campaign={{ ...campaign }} />
                    </div>
                    <div className="col-md-9">
                      <ProductList />
                    </div>
                  </div>
                </section>
              </div>
            </>
          )}
        </>
      )}
    </>
  );
};

export default Campaign;

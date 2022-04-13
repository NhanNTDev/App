import { useEffect, useState } from "react";
import ProductDetail from "../components/product/ProductDetail";
import ProductPicture from "../components/product/ProductPicture";
import harvestCampaignApi from "../apis/harvestCampaignApi";
import { Link, useParams } from "react-router-dom";
import { Button, notification, Result } from "antd";
import LoadingPage from "./LoadingPage";

const Product = () => {
  const params = useParams();
  const [harvestCampaign, setHarvestCampaign] = useState(null);
  const [loading, setLoading] = useState(true);
  const [loadErr, setLoadErr] = useState(false);
  const [reload, setReload] = useState(true);
  useEffect(() => {
    setLoadErr(false);
    const fetchProducts = async () => {
      await harvestCampaignApi
        .get(params.productId)
        .then((result) => {
          setHarvestCampaign(result);
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
          setLoadErr(true);
        });
      setLoading(false);
    };
    fetchProducts();
  }, [reload]);

  return (
    <>
      {loadErr ? (
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
          {loading ? (
            <LoadingPage />
          ) : (
            <>
              <section className="pt-3 pb-3 page-info section-padding border-bottom bg-white">
                <div className="container">
                  <div className="row">
                    <div className="col-md-12">
                      <Link to="/home">
                        <strong>
                          <span className="mdi mdi-home"></span> Trang chủ
                        </strong>
                      </Link>
                      <span className="mdi mdi-chevron-right"></span>{" "}
                      <Link to={`/campaign/${harvestCampaign.campaign.id}`}>
                        {harvestCampaign && harvestCampaign.campaign.name}
                      </Link>
                      <span className="mdi mdi-chevron-right"></span>{" "}
                      <a href="#">
                        {harvestCampaign && harvestCampaign.productName}
                      </a>
                    </div>
                  </div>
                </div>
              </section>
              <section className="shop-single section-padding pt-3">
                <div className="container">
                  <div className="row">
                    <div className="col-md-4">
                      {harvestCampaign && (
                        <ProductPicture {...harvestCampaign} />
                      )}
                    </div>
                    <div className="col-md-8">
                      {harvestCampaign && (
                        <ProductDetail {...harvestCampaign} />
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

export default Product;

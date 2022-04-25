import { useEffect, useState } from "react";
import { Button, notification, Rate, Result } from "antd";
import { useSearchParams } from "react-router-dom";
import harvestCampaignApi from "../apis/harvestCampaignApi";
import { parseTimeDMY } from "../utils/Common";

const ProductOrigin = () => {
  const [productOrigin, setProductOrigin] = useState();
  const [networkErr, setNetworkErr] = useState(false);
  const [reload, setReload] = useState(true);
  const [searchParams] = useSearchParams();
  const productId = searchParams.get("id");
  useEffect(() => {
    const getOrigin = async () => {
      setNetworkErr(false);
      await harvestCampaignApi
        .getOrigin(productId)
        .then((result) => {
          setProductOrigin(result);
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
          setNetworkErr(true);
        });
    };
    getOrigin();
  }, [reload]);
  return (
    <>
      <div className="container">
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
            {productOrigin && (
              <>
                <h2
                  className="heading-design-h4"
                  style={{ marginBottom: 30, marginTop: 30 }}
                >
                  I. Thông tin nông trại
                </h2>
                <div className="row">
                  <div className="col-lg-4">
                    <div
                      id="carouselExampleIndicators"
                      class="carousel slide"
                      data-ride="carousel"
                    >
                      <ol class="carousel-indicators">
                        {productOrigin.harvest.farm.image1 && (
                          <li
                            data-target="#carouselExampleIndicators"
                            data-slide-to="0"
                            class="active"
                          ></li>
                        )}
                        {productOrigin.harvest.farm.image2 && (
                          <li
                            data-target="#carouselExampleIndicators"
                            data-slide-to="1"
                          ></li>
                        )}
                        {productOrigin.harvest.farm.image3 && (
                          <li
                            data-target="#carouselExampleIndicators"
                            data-slide-to="2"
                          ></li>
                        )}
                        {productOrigin.harvest.farm.image4 && (
                          <li
                            data-target="#carouselExampleIndicators"
                            data-slide-to="3"
                          ></li>
                        )}
                        {productOrigin.harvest.farm.image5 && (
                          <li
                            data-target="#carouselExampleIndicators"
                            data-slide-to="4"
                          ></li>
                        )}
                      </ol>
                      <div class="carousel-inner">
                        {productOrigin.harvest.farm.image1 && (
                          <div class="carousel-item active">
                            <img
                              style={{
                                objectFit: "cover",
                                backgroundSize: "cover",
                                width: "100%",
                                height: 300,
                                borderRadius: 30,
                              }}
                              class="d-block w-100"
                              src={productOrigin.harvest.farm.image1}
                            />
                          </div>
                        )}
                        {productOrigin.harvest.farm.image2 && (
                          <div class="carousel-item">
                            <img
                              style={{
                                objectFit: "cover",
                                backgroundSize: "cover",
                                width: "100%",
                                height: 300,
                                borderRadius: 30,
                              }}
                              class="d-block w-100"
                              src={productOrigin.harvest.farm.image2}
                            />
                          </div>
                        )}
                        {productOrigin.harvest.farm.image3 && (
                          <div class="carousel-item">
                            <img
                              style={{
                                objectFit: "cover",
                                backgroundSize: "cover",
                                width: "100%",
                                height: 300,
                                borderRadius: 30,
                              }}
                              class="d-block w-100"
                              src={productOrigin.harvest.farm.image3}
                            />
                          </div>
                        )}
                        {productOrigin.harvest.farm.image4 && (
                          <div class="carousel-item">
                            <img
                              style={{
                                objectFit: "cover",
                                backgroundSize: "cover",
                                width: "100%",
                                height: 300,
                                borderRadius: 30,
                              }}
                              class="d-block w-100"
                              src={productOrigin.harvest.farm.image4}
                            />
                          </div>
                        )}
                        {productOrigin.harvest.farm.image5 && (
                          <div class="carousel-item">
                            <img
                              style={{
                                objectFit: "cover",
                                backgroundSize: "cover",
                                width: "100%",
                                height: 300,
                                borderRadius: 30,
                              }}
                              class="d-block w-100"
                              src={productOrigin.harvest.farm.image5}
                            />
                          </div>
                        )}
                      </div>
                      <a
                        class="carousel-control-prev"
                        href="#carouselExampleIndicators"
                        role="button"
                        data-slide="prev"
                      >
                        <span
                          class="carousel-control-prev-icon"
                          aria-hidden="true"
                        ></span>
                        <span class="sr-only">Trước</span>
                      </a>
                      <a
                        class="carousel-control-next"
                        href="#carouselExampleIndicators"
                        role="button"
                        data-slide="next"
                      >
                        <span
                          class="carousel-control-next-icon"
                          aria-hidden="true"
                        ></span>
                        <span class="sr-only">Sau</span>
                      </a>
                    </div>
                  </div>
                  <div className="col-lg-8">
                    <div style={{ margin: 20 }}>
                      <h5 className="heading-design-h5">
                        <strong>Tên nông trại: </strong>{" "}
                        {productOrigin.harvest.farm.name}{" "}
                        <Rate
                          value={productOrigin.harvest.farm.totalStar}
                          allowHalf
                          disabled={true}
                          style={{ marginLeft: 10 }}
                        />{" "}
                        {productOrigin.harvest.farm.totalStar + "/5"}
                        {" ( " +
                          productOrigin.harvest.farm.feedbacks +
                          " đánh giá )"}
                      </h5>
                      <h5 className="heading-design-h5">
                        <strong>Địa chỉ: </strong>{" "}
                        {productOrigin.harvest.farm.address}
                      </h5>
                      <h5 className="heading-design-h5">
                        <strong>Chủ nông trại: </strong>
                        {productOrigin.harvest.farm.farmer.name}
                      </h5>
                      <h5 className="heading-design-h5">
                        <strong>Số điện thoại: </strong>
                        {productOrigin.harvest.farm.farmer.phoneNumber}
                      </h5>
                      <h5 className="heading-design-h5">
                        <strong>Mô tả: </strong>
                        {productOrigin.harvest.farm.description === null ||
                        productOrigin.harvest.farm.description === ""
                          ? "Chưa có mô tả!"
                          : productOrigin.harvest.farm.description}
                      </h5>
                    </div>
                  </div>
                </div>
                <h2
                  className="heading-design-h4"
                  style={{ marginTop: 30, marginBottom: 30 }}
                >
                  II. Thông tin mùa vụ
                </h2>
                <div className="row">
                  <div className="col-lg-4">
                    <div
                      id="carouselExampleIndicators1"
                      class="carousel slide"
                      data-ride="carousel"
                    >
                      <ol class="carousel-indicators">
                        {productOrigin.harvest.farm.image1 && (
                          <li
                            data-target="#carouselExampleIndicators1"
                            data-slide-to="0"
                            class="active"
                          ></li>
                        )}
                        {productOrigin.harvest.farm.image2 && (
                          <li
                            data-target="#carouselExampleIndicators1"
                            data-slide-to="1"
                          ></li>
                        )}
                        {productOrigin.harvest.farm.image3 && (
                          <li
                            data-target="#carouselExampleIndicators1"
                            data-slide-to="2"
                          ></li>
                        )}
                        {productOrigin.harvest.farm.image4 && (
                          <li
                            data-target="#carouselExampleIndicators1"
                            data-slide-to="3"
                          ></li>
                        )}
                        {productOrigin.harvest.farm.image5 && (
                          <li
                            data-target="#carouselExampleIndicators1"
                            data-slide-to="4"
                          ></li>
                        )}
                      </ol>
                      <div class="carousel-inner">
                        {productOrigin.harvest.farm.image1 && (
                          <div class="carousel-item active">
                            <img
                              style={{
                                objectFit: "cover",
                                backgroundSize: "cover",
                                width: "100%",
                                height: 300,
                                borderRadius: 30,
                              }}
                              class="d-block w-100"
                              src={productOrigin.harvest.image1}
                            />
                          </div>
                        )}
                        {productOrigin.harvest.image2 && (
                          <div class="carousel-item">
                            <img
                              style={{
                                objectFit: "cover",
                                backgroundSize: "cover",
                                width: "100%",
                                height: 300,
                                borderRadius: 30,
                              }}
                              class="d-block w-100"
                              src={productOrigin.harvest.image2}
                            />
                          </div>
                        )}
                        {productOrigin.harvest.image3 && (
                          <div class="carousel-item">
                            <img
                              style={{
                                objectFit: "cover",
                                backgroundSize: "cover",
                                width: "100%",
                                height: 300,
                                borderRadius: 30,
                              }}
                              class="d-block w-100"
                              src={productOrigin.harvest.image3}
                            />
                          </div>
                        )}
                        {productOrigin.harvest.image4 && (
                          <div class="carousel-item">
                            <img
                              style={{
                                objectFit: "cover",
                                backgroundSize: "cover",
                                width: "100%",
                                height: 300,
                                borderRadius: 30,
                              }}
                              class="d-block w-100"
                              src={productOrigin.harvest.image4}
                            />
                          </div>
                        )}
                        {productOrigin.harvest.image5 && (
                          <div class="carousel-item">
                            <img
                              style={{
                                objectFit: "cover",
                                backgroundSize: "cover",
                                width: "100%",
                                height: 300,
                                borderRadius: 30,
                              }}
                              class="d-block w-100"
                              src={productOrigin.harvest.image5}
                            />
                          </div>
                        )}
                      </div>
                      <a
                        class="carousel-control-prev"
                        href="#carouselExampleIndicators1"
                        role="button"
                        data-slide="prev"
                      >
                        <span
                          class="carousel-control-prev-icon"
                          aria-hidden="true"
                        ></span>
                        <span class="sr-only">Trước</span>
                      </a>
                      <a
                        class="carousel-control-next"
                        href="#carouselExampleIndicators1"
                        role="button"
                        data-slide="next"
                      >
                        <span
                          class="carousel-control-next-icon"
                          aria-hidden="true"
                        ></span>
                        <span class="sr-only">Sau</span>
                      </a>
                    </div>
                  </div>
                  <div className="col-lg-8">
                    <div style={{ margin: 20 }}>
                      <h5 className="heading-design-h5">
                        <strong>Tên mùa vụ: </strong>{" "}
                        {productOrigin.harvest.name}
                      </h5>
                      <h5 className="heading-design-h5">
                        <strong>Sản phẩm: </strong>{" "}
                        {productOrigin.harvest.productName}
                      </h5>
                      <h5 className="heading-design-h5">
                        <strong>Ngày bắt đầu: </strong>
                        {parseTimeDMY(productOrigin.harvest.startAt)}
                      </h5>
                      <h5 className="heading-design-h5">
                        <strong>Ngày thu hoặch (dự kiến): </strong>
                        {parseTimeDMY(productOrigin.harvest.estimatedTime)}
                      </h5>
                      <h5 className="heading-design-h5">
                        <strong>Sản lượng (dự kiến): </strong>
                        {productOrigin.harvest.estimatedProduction +
                          " " +
                          productOrigin.harvest.productSystem.unit}
                      </h5>
                      <h5 className="heading-design-h5">
                        <strong>Sản lượng (thực tế): </strong>
                        {productOrigin.harvest.actualProduction !== null
                          ? productOrigin.harvest.actualProduction +
                            " " +
                            productOrigin.harvest.productSystem.unit
                          : "Chưa xác đ"}
                      </h5>
                      <h5 className="heading-design-h5">
                        <strong>Mô tả: </strong>
                        {productOrigin.harvest.description === null ||
                        productOrigin.harvest.description === ""
                          ? "Chưa có mô tả!"
                          : productOrigin.harvest.description}
                      </h5>
                    </div>
                  </div>
                </div>
              </>
            )}
          </>
        )}
      </div>
    </>
  );
};

export default ProductOrigin;

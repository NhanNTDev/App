import { useEffect, useState } from "react";
import ProductDetail from "../components/product/ProductDetail";
import ProductPicture from "../components/product/ProductPicture";
import { deleteScript, runScript } from "../utils/Common";
import * as productService from "../apis/product-service";
import productApi from "../apis/productApi";
import harvestApi from "../apis/harvestApi";
import ProductSlider from "../components/product/ProductSlider";
import { useParams } from "react-router-dom";

const Product = () => {
  const params = useParams();
  const [harvests, setHarvests] = useState([]);
  const [harvest, setHarvest] = useState(null);

  useEffect(() => {
    const fetchProducts = async () => {
      const param = {
        page: 1,
        size: 12,
      };
      const harvestsResponse = await harvestApi.getAll(param);
      setHarvests(harvestsResponse.data);
    };
    fetchProducts();
  }, []);

  useEffect(() => {
    console.log(harvests);
    setHarvest(harvests.find((c) => c.id.toString() === params.productId));
  }, [harvests]);

  return (
    <>
      <section className="pt-3 pb-3 page-info section-padding border-bottom bg-white">
        <div className="container">
          <div className="row">
            <div className="col-md-12">
              <a href="#">
                <strong>
                  <span className="mdi mdi-home"></span> Trang chủ
                </strong>
              </a>{" "}
              <span className="mdi mdi-chevron-right"></span>{" "}
              <a href="#">Đà Lạt - Hồ Chí Minh</a>
              <span className="mdi mdi-chevron-right"></span>{" "}
              <a href="#">Nguyễn Thành Nhân Farm</a>
              <span className="mdi mdi-chevron-right"></span>{" "}
              <a href="#">{harvest && harvest.harvest.name}</a>
            </div>
          </div>
        </div>
      </section>
      <section className="shop-single section-padding pt-3">
        <div className="container">
          <div className="row">
            <div className="col-md-6">
              <ProductPicture harvest={{...harvest}} />
            </div>
            <div className="col-md-6">
              <ProductDetail harvest={{...harvest}} />
            </div>
          </div>
        </div>
      </section>
      {/* {products.length > 0 ? (
        <ProductSlider
          title="Sản phẩm khác trong nông trại"
          listProduct={products}
        />
      ) : null} */}
    </>
  );
};

export default Product;

import { useEffect, useState } from "react";
import ProductDetail from "../components/product/ProductDetail";
import ProductPicture from "../components/product/ProductPicture";
import { deleteScript, runScript } from "../utils/Common";
import * as productService from "../apis/product-service";
import ProductSlider from "../components/product/ProductSlider";

const Product = () => {
  const [products, setProducts] = useState([]);

  useEffect(() => {
    deleteScript();
  }, []);
  useEffect(() => {
    const fetchProducts = async () => {
      const productsResponse = await productService.getListProduct();
      setProducts(productsResponse);
    };
    fetchProducts();
  }, []);
  useEffect(() => {
    runScript();
  }, []);

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
              <span>Hồng giòn Đà Lạt</span>
            </div>
          </div>
        </div>
      </section>
      <section className="shop-single section-padding pt-3">
        <div className="container">
          <div className="row">
            <div className="col-md-6">
              <ProductPicture />
            </div>
            <div className="col-md-6">
              <ProductDetail />
            </div>
          </div>
        </div>
      </section>
      {products.length > 0 ? (
        <ProductSlider
          title="Sản phẩm khác trong nông trại"
          listProduct={products}
        />
      ) : null}
    </>
  );
};

export default Product;

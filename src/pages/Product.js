import ItemGroup from "../components/ItemGroup";
import ProductDetail from "../components/ProductDetail";
import ProductPicture from "../components/ProductPicture";

const Product = () => {
  return (
    <>
      <section class="pt-3 pb-3 page-info section-padding border-bottom bg-white">
        <div class="container">
          <div class="row">
            <div class="col-md-12">
              <a href="#">
                <strong>
                  <span class="mdi mdi-home"></span> Home
                </strong>
              </a>{" "}
              <span class="mdi mdi-chevron-right"></span>{" "}
              <a href="#">Fruits & Vegetables</a>{" "}
              <span class="mdi mdi-chevron-right"></span> <a href="#">Fruits</a>
            </div>
          </div>
        </div>
      </section>
      <section class="shop-single section-padding pt-3">
        <div class="container">
          <div class="row">
            <div class="col-md-6">
              <ProductPicture/>
            </div>
            <div class="col-md-6">
              <ProductDetail/>
            </div>
          </div>
        </div>
      </section>
      <ItemGroup title="Chiến dịch trong tuần"></ItemGroup>
    </>
  );
};

export default Product;

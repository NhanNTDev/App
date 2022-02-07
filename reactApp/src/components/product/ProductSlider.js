
import { useEffect } from "react";
import { Link } from "react-router-dom";
import { deleteScript, runScript } from "../../utils/Common";
import ProductSliderItem from "./ProductItemShort";


const ProductSlider = (props) => {
  useEffect(()=>{
    deleteScript();
    runScript();
  }, []);
  
  return (
    <section className="product-items-slider section-padding">
      <div className="container">
        <div className="section-header">
          <h5 className="heading-design-h5">
            {props.title}{" "}
            <Link className="float-right text-secondary" to={`/campaign/1/1`}>
              Xem tất cả
            </Link>
          </h5>
        </div>
        <div className="owl-carousel owl-carousel-featured">
          {props.listProduct &&
            props.listProduct.map((harvest) => <ProductSliderItem harvest = {{...harvest}}/>)}
        </div>
      </div>
    </section>
  );
};

export default ProductSlider;

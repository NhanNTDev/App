
import { useEffect } from "react";
import { Link } from "react-router-dom";
import { deleteScript, runScript } from "../../utils/Common";
import ProductSliderItem from "./ProductSliderItem";


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
            <Link className="float-right text-secondary" to={`/farm?id=`}>
              Xem tất cả
            </Link>
          </h5>
        </div>
        <div className="owl-carousel owl-carousel-featured">
          {props.listProduct &&
            props.listProduct.map((product) => <ProductSliderItem {...product}/>)}
        </div>
      </div>
    </section>
  );
};

export default ProductSlider;

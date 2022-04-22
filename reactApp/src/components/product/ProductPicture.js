import { useEffect } from "react";
import { runCaroselScript } from "../../utils/Common";

const ProductPicture = (props) => {
  useEffect(() => {
    runCaroselScript();
  }, []);
  return (
    <div className="shop-detail-left">
      <div className="shop-detail-slider">
        <div id="sync1" className="owl-carousel">
          <div className="item">
            <img
              alt=""
              src={props.image1}
              className="img-fluid img-center"
            />
          </div>
          {props.image2 && (
            <div className="item">
              <img
                alt=""
                src={props.image2}
                className="img-fluid img-center"
              />
            </div>
          ) }

          {props.image3 && (
            <div className="item">
              <img
                alt=""
                src={props.image3}
                className="img-fluid img-center"
              />
            </div>
          ) }

          {props.image4 && (
            <div className="item">
              <img
                alt=""
                src={props.image4}
                className="img-fluid img-center"
              />
            </div>
          ) }

          {props.image5 && (
            <div className="item">
              <img
                alt=""
                src={props.image5}
                className="img-fluid img-center"
              />
            </div>
          ) }
        </div>
      </div>
    </div>
  );
};

export default ProductPicture;

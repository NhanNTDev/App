import { useEffect } from "react";
import { deleteScript, runScript } from "../../utils/Common";

const ProductPicture = (props) => {
  useEffect(() => {
    deleteScript();
    runScript();
  }, []);
  return (
    <div className="shop-detail-left">
      <div className="shop-detail-slider">
        <div id="sync1" className="owl-carousel">
          <div className="item">
            <img alt="" src={props.harvest.harvest.product.image1} className="img-fluid img-center" />
          </div>
          <div className="item">
            <img alt="" src={props.harvest.harvest.product.image2} className="img-fluid img-center" />
          </div>
          <div className="item">
            <img alt="" src={props.harvest.harvest.product.image3} className="img-fluid img-center" />
          </div>
          <div className="item">
            <img alt="" src={props.harvest.harvest.product.image4} className="img-fluid img-center" />
          </div>
          <div className="item">
            <img alt="" src={props.harvest.harvest.product.image5} className="img-fluid img-center" />
          </div>
        </div>
        {/* <div id="sync2" className="owl-carousel">
          <div className="item">
            <img alt="" src={props.harvest.harvest.product.image1} className="img-fluid img-center" />
          </div>
          <div className="item">
            <img alt="" src={props.harvest.harvest.product.image2} className="img-fluid img-center" />
          </div>
          <div className="item">
            <img alt="" src={props.harvest.harvest.product.image3} className="img-fluid img-center" />
          </div>
          <div className="item">
            <img alt="" src={props.harvest.harvest.product.image4} className="img-fluid img-center" />
          </div>
          <div className="item">
            <img alt="" src={props.harvest.harvest.product.image5} className="img-fluid img-center" />
          </div>
        </div> */}
      </div>
    </div>
  );
};

export default ProductPicture;

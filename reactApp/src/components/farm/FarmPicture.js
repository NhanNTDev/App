import { useEffect } from "react";
import { deleteScript, runScript } from "../../utils/Common";

const FarmPicture = (props) => {
    useEffect(() => {
      deleteScript();
      runScript();
    }, [])
    return (
      <div className="shop-detail-left">
        <div className="shop-detail-slider">
          <div className="favourite-icon">
              <i className="mdi mdi-tag-outline"></i>
          </div>
          <div id="sync1" className="owl-carousel">
            <div className="item">
              <img alt="" src={props.farm.image1} className="img-fluid img-center" />
            </div>
            <div className="item">
              <img alt="" src={props.farm.image2} className="img-fluid img-center" />
            </div>
            <div className="item">
              <img alt="" src={props.farm.image3} className="img-fluid img-center" />
            </div>
            <div className="item">
              <img alt="" src={props.farm.image4} className="img-fluid img-center" />
            </div>
            <div className="item">
              <img alt="" src={props.farm.image5} className="img-fluid img-center" />
            </div>
          </div>
        </div>
      </div>
    );
  };
  
  export default FarmPicture;
  
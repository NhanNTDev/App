import { useEffect } from "react";
import { deleteScript, runScript } from "../../utils/Common";

const CampaignPicture = (props) => {
  useEffect(() => {
    deleteScript();
    runScript();
  }, []);
  return (
    <div className="shop-detail-left">
      <div className="shop-detail-slider">
        <div id="sync1" className="owl-carousel">
          <div className="item">
            <img
              alt=""
              src={props.campaign.image1}
              className="img-fluid img-center"
            />
          </div>
            {/* {props.campaign.image2 !== null ? (
              <div className="item">
                <img
                  alt=""
                  src={props.campaign.image2}
                  className="img-fluid img-center"
                />
              </div>
            ) : null} */}

          {/* {props.campaign.image3 !== null ? (
            <div className="item">
              <img
                alt=""
                src={props.campaign.image3}
                className="img-fluid img-center"
              />
            </div>
          ) : null}

          {props.campaign.image4 !== null ? (
            <div className="item">
              <img
                alt=""
                src={props.campaign.image4}
                className="img-fluid img-center"
              />
            </div>
          ) : null}
          {props.campaign.image5 !== null ? (
            <div className="item">
              <img
                alt=""
                src={props.campaign.image5}
                className="img-fluid img-center"
              />
            </div>
          ) : null}
          {props.campaign.image6 !== null ? (
            <div className="item">
              <img
                alt=""
                src={props.campaign.image6}
                className="img-fluid img-center"
              />
            </div>
          ) : null} */}
        </div>
      </div>
    </div>
  );
};

export default CampaignPicture;

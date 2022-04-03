import { useEffect } from "react";
import { deleteScript, runScript } from "../../utils/Common";

const CampaignPicture = (props) => {
  return (
    <div className="shop-detail-left">
      <div className="shop-detail-slider">
        <div id="sync1" className="owl-carousel">
          <div className="item">
            <img
              alt=""
              src={props.campaign.image1}
              className="img-fluid img-center"
              style={{
                objectFit: "contain",
                backgroundSize: "cover",
                width: "100%",
              }}
            />
          </div>
          {props.campaign.image2 && (
            <div className="item">
              <img
                alt=""
                src={props.campaign.image2}
                className="img-fluid img-center"
                style={{
                  objectFit: "contain",
                  backgroundSize: "cover",
                  width: "100%",
                }}
              />
            </div>
          )}

          {props.campaign.image3 && (
            <div className="item">
              <img
                alt=""
                src={props.campaign.image3}
                className="img-fluid img-center"
                style={{
                  objectFit: "contain",
                  backgroundSize: "cover",
                  width: "100%",
                }}
              />
            </div>
          )}

          {props.campaign.image4 && (
            <div className="item">
              <img
                alt=""
                src={props.campaign.image4}
                className="img-fluid img-center"
                style={{
                  objectFit: "contain",
                  backgroundSize: "cover",
                  width: "100%",
                }}
              />
            </div>
          )}
          {props.campaign.image5 && (
            <div className="item">
              <img
                alt=""
                src={props.campaign.image5}
                className="img-fluid img-center"
                style={{
                  objectFit: "contain",
                  backgroundSize: "cover",
                  width: "100%",
                }}
              />
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default CampaignPicture;

import { Link } from "react-router-dom";
import { parseTimeDMY } from "../../utils/Common";

const CampaignItem = (props) => {
  // const date = new Date(props.endAt);
  // const endDate = date.getDate() + "-" + (date.getMonth()+1)  + "-" + date.getFullYear();
  return (
    <div className="col-md-3">
      <div className="product">
        <Link to={`/campaign/${props.id}`}>
          <div className="product-header">
            <img className="img-fluid" src={props.image1} alt="" />
            <span className="veg text-success mdi mdi-circle"></span>
          </div>
          <div className="product-body">
            <h4
              style={{
                height: 60,
                overflow: "hidden",
                textOverflow: "ellipsis",
              }}
            >
              {props.name}
            </h4>
            <h5>
              <strong>
                <span className="mdi mdi-flower"></span> Tổng nông trại:
              </strong>{" "}
              {props.farmInCampaign}
            </h5>
            <h5>
              <strong>
                <span className="mdi mdi-map-marker-circle"></span> Từ:
              </strong>{" "}
              {props.campaignZoneName}
            </h5>
            <h5>
              <strong>
                <span className="mdi mdi-calendar"></span> Kết thúc:
              </strong>{" "}
              {parseTimeDMY(props.endAt)}
            </h5>
            <h5>
              <strong>
                <span className="mdi mdi-car"></span> Giao hàng dự kiến:
              </strong>{" "}
              {parseTimeDMY(props.expectedDeliveryTime)}
            </h5>
            <br />
          </div>
        </Link>
        <div className="product-footer">
          <Link
            to={`/campaign/${props.id}`}
            className="btn btn-secondary btn-sm float-right"
          >
            <i className="mdi mdi-eye"></i> Xem chiến dịch
          </Link>
          <br />
        </div>
      </div>
    </div>
  );
};

export default CampaignItem;

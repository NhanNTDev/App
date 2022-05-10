import { Tag } from "antd";
import { parseTimeDMY } from "../../utils/Common"
const CampaignDetail = (props) => {
  return (
    <div className="shop-detail-right">
      <h2>{props.campaign.name}</h2>
      <h6>
        {props.campaign.description === "" ? "Chưa có mô tả" : props.campaign.description}
      </h6>
      <h6>
          <span className="mdi mdi-corn"></span> Tổng nông trại tham gia: {props.campaign.farmInCampaign}
      </h6>
      <h6>
          Giao hàng đến: {props.campaign.campaignDeliveryZones.map(zone => <Tag color="green" key={zone.id}>{zone.deliveryZoneName}</Tag>)} 
      </h6>
      <h6>
          Giao hàng dự kiến vào ngày {parseTimeDMY(props.campaign.expectedDeliveryTime)} 
      </h6>
    </div>
  );
};

export default CampaignDetail;

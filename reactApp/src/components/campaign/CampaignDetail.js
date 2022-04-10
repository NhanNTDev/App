
const CampaignDetail = (props) => {
  return (
    <div className="shop-detail-right">
      <h2>{props.campaign.name}</h2>
      <h6>
        {props.campaign.description}
      </h6>
      <h6>
          <span className="mdi mdi-corn"></span> Tổng nông trại tham gia: {props.campaign.farmInCampaign}
      </h6>
    </div>
  );
};

export default CampaignDetail;

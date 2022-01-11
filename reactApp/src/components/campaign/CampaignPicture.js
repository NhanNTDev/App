const CampaignPicture = (props) => {
  return (
    <div className="shop-detail-left">
      <div className="shop-detail-slider">
        <div className="favourite-icon">
          <a
            className="fav-btn"
            title=""
            data-placement="bottom"
            data-toggle="tooltip"
            href="#"
            data-original-title="59% OFF"
          >
            <i className="mdi mdi-tag-outline"></i>
          </a>
        </div>
        <div id="sync1" className="owl-carousel">
          <div className="item">
            <img alt="" src={props.campaign.image1} className="img-fluid img-center" />
          </div>
          <div className="item">
            <img alt="" src={props.campaign.image2} className="img-fluid img-center" />
          </div>
          <div className="item">
            <img alt="" src={props.campaign.image3} className="img-fluid img-center" />
          </div>
          <div className="item">
            <img alt="" src={props.campaign.image4} className="img-fluid img-center" />
          </div>
          <div className="item">
            <img alt="" src={props.campaign.image5} className="img-fluid img-center" />
          </div>
          <div className="item">
            <img alt="" src={props.campaign.image6} className="img-fluid img-center" />
          </div>
        </div>
      </div>
    </div>
  );
};

export default CampaignPicture;

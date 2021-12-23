const CampaignPicture = () => {
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
              <img alt="" src="/img/item/1.jpg" className="img-fluid img-center" />
            </div>
            <div className="item">
              <img alt="" src="/img/item/2.jpg" className="img-fluid img-center" />
            </div>
            <div className="item">
              <img alt="" src="/img/item/3.jpg" className="img-fluid img-center" />
            </div>
            <div className="item">
              <img alt="" src="/img/item/4.jpg" className="img-fluid img-center" />
            </div>
            <div className="item">
              <img alt="" src="/img/item/5.jpg" className="img-fluid img-center" />
            </div>
          </div>
          <div id="sync2" className="owl-carousel">
            <div className="item">
              <img alt="" src="/img/item/1.jpg" className="img-fluid img-center" />
            </div>
            <div className="item">
              <img alt="" src="/img/item/2.jpg" className="img-fluid img-center" />
            </div>
            <div className="item">
              <img alt="" src="/img/item/3.jpg" className="img-fluid img-center" />
            </div>
            <div className="item">
              <img alt="" src="/img/item/4.jpg" className="img-fluid img-center" />
            </div>
            <div className="item">
              <img alt="" src="/img/item/5.jpg" className="img-fluid img-center" />
            </div>
          </div>
        </div>
      </div>
    );
  };
  
  export default CampaignPicture;
  
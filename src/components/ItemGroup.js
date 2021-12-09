const ItemGroup = () => {
  let Campaigns = [
    {
      id: "1",
      title: "Rau củ",
      countFarm: "10",
      location: "Đà Lạt",
    },
    {
      id: "2",
      title: "Quả",
      countFarm: "10",
      location: "Đà Lạt",
    },
    {
      id: "3",
      title: "Hoa Tươi",
      countFarm: "10",
      location: "Đà Lạt",
    },
    {
      id: "4",
      title: "Rau củ sạch",
      countFarm: "10",
      location: "Đà Lạt",
    },
    {
      id: "5",
      title: "Rau sạch",
      countFarm: "10",
      location: "Đà Lạt",
    },
    {
      id: "6",
      title: "Hoa tươi",
      countFarm: "10",
      location: "Đà Lạt",
    },
  ];

  function renderCampaignItem(props) {
    return (
      <div className="item" key={props.id}>
        <div className="product">
          <a href="single.html">
            <div className="product-header">
              <span className="badge badge-success">50% OFF</span>
              <img className="img-fluid" src="img/item/1.jpg" alt="" />
              <span className="veg text-success mdi mdi-circle"></span>
            </div>
            <div className="product-body">
              <h4>{props.title}</h4>
              <h5>
                <strong>
                  <span className="mdi mdi-approval"></span> Tổng nông trại
                </strong>{" "}
                - {props.countFarm}
              </h5>
              <h5>
                <strong>
                  <span className="mdi mdi-map-marker-circle"></span>{" "}
                  {props.location}
                </strong>
              </h5>
              <br />
            </div>
            <div className="product-footer">
              <button
                type="button"
                className="btn btn-secondary btn-sm float-right"
              >
                <i className="mdi mdi-cart-outline"></i> Xem chiến dịch
              </button>
              <br />
            </div>
          </a>
        </div>
      </div>
    );
  }

  return (
    <section className="product-items-slider section-padding">
      <div className="container">
        <div className="section-header">
          <h5 className="heading-design-h5">
            Chiến dịch trong tuần
            <span className="badge badge-primary">Đang hot</span>
            <a className="float-right text-secondary" href="shop.html">
              Xem tất cả
            </a>
          </h5>
        </div>
        <div className="owl-carousel owl-carousel-featured">
          {Campaigns.map((campaign) => renderCampaignItem({...campaign}))}
        </div>
      </div>
    </section>
  );
};

export default ItemGroup;

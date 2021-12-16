import { Link } from "react-router-dom";

const ItemGroup = (props) => {
  function renderCampaignItem(props) {
    return (
      <div className="item" key={props.id}>
        <div className="product">
          <Link to="/product">
            <div className="product-header">
              <span className="badge badge-success">50% OFF</span>
              <img className="img-fluid" src="img/item/1.jpg" alt="" />
              <span className="veg text-success mdi mdi-circle"></span>
            </div>
            <div className="product-body" >
              <h4 style={{ height: 80 }}>{props.name}</h4>
              <h5>
                <strong>
                  <span className="mdi mdi-flower"></span> Tổng nông trại:
                </strong>{" "}
                {props.farmJoined}
              </h5>
              <h5>
                <strong>
                  <span className="mdi mdi-map-marker-circle"></span> Từ:
                </strong>{" "}
                {props.from}
              </h5>
              <h5>
                <strong>
                  <span className="mdi mdi-map-marker-circle"></span> Đến:
                </strong>{" "}
                {props.to}
              </h5>
              <br />
            </div>
          </Link>
          <div className="product-footer">
            <button
              type="button"
              className="btn btn-secondary btn-sm float-right"
              onClick={()=>{}}
            >
              <i className="mdi mdi-eye"></i> Xem chiến dịch
            </button>
            <br />
          </div>
        </div>
      </div>
    );
  }

  return (
    <section className="product-items-slider section-padding bg-white border-top">
      <div className="container">
        <div className="section-header">
          <h5 className="heading-design-h5">
            {props.title}{" "}
            {props.type === "hot" && (
              <span className="badge badge-primary">Đang hot</span>
            )}
            <Link
              className="float-right text-secondary"
              to={`/shop?type=${props.type}`}
            >
              Xem tất cả
            </Link>
          </h5>
        </div>
        <div className="owl-carousel owl-carousel-featured">
          {props.listCampaigns &&
            props.listCampaigns.map((campaign) =>
              renderCampaignItem({ ...campaign })
            )}
        </div>
      </div>
    </section>
  );
};

export default ItemGroup;



const CampaignItem = (props) => {
    return (
        <div className="col-md-3">
          <div className="product">
            <a href="single.html">
              <div className="product-header">
                <img className="img-fluid" src="img/item/3.jpg" alt="" />
                <span className="veg text-success mdi mdi-circle"></span>
              </div>
              <div className="product-body">
                <h4 style={{height: 60, overflow: "hidden", textOverflow: "ellipsis"}}>{props.name}</h4>
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
            </a>
            <div className="product-footer">
              <button
                type="button"
                className="btn btn-secondary btn-sm float-right"
                onClick={() => {}}
              >
                <i className="mdi mdi-eye"></i> Xem chiến dịch
              </button>
              <br />
            </div>
          </div>
        </div>
      );
}

export default CampaignItem;
import React from 'react'
import { Link } from 'react-router-dom'

const FarmItem = (props) => {
    return (
        <div className="item">
        <div className="product">
          <Link to={`/campaign/${props.campaignId}/${props.farm.id}`}>
            <div className="product-header">
              <img className="img-fluid" src={props.farm.image1} alt="" />
              <span className="veg text-success mdi mdi-circle"></span>
            </div>
            <div className="product-body">
              <div className="title">
                <h4>{props.farm.name}</h4>
              </div>
              <div className="detail">
                <h5>
                  <i>
                    <span className="mdi mdi-map-marker"></span> Địa Chỉ:
                  </i>{" "}
                  {props.farm.address}
                </h5>
                <h5>
                  <i>
                    <span className=" "></span> Số điện thoại:
                  </i>{" "}
                  {props.phone}
                </h5>
                <h5>
                  <i>
                    <span className="mdi mdi-email"></span> Email:
                  </i>{" "}
                  {props.email}
                </h5>
              </div>
              <br />
            </div>
          </Link>
          <div className="product-footer">
            <Link
              to={`/campaign/${props.campaignId}/${props.id}`}
              type="button"
              className="btn btn-secondary btn-sm float-right"
              onClick={() => {}}
            >
              <i className="mdi mdi-eye"></i> Xem Quầy Bán
            </Link>
            <br />
          </div>
        </div>
      </div>
    )
}

export default FarmItem

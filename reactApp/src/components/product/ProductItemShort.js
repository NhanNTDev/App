import { Link } from "react-router-dom";

const ProductItemShort = (props) => {
  return (
    <div className="item" style={{ width: 231 }}>
      <div className="product">
        <Link to="/product">
          <div className="product-header">
            {props.harvest.harvest.product.image1 !== null ? (
              <img
                className="img-fluid"
                src={props.harvest.harvest.product.image1}
                alt=""
              />
            ) : (
              <img className="img-fluid" src="/img/item/1.jpg" alt="" />
            )}

            <span className="veg text-success mdi mdi-circle"></span>
          </div>
          <div className="product-body">
            <div style={{ height: 80 }}>
              <h4>{props.harvest.harvest.name}</h4>
              <h6>
                <strong>
                  <span class="mdi mdi-approval"></span> Còn lại:
                </strong>{" "}
                {props.harvest.inventory} {" / "} {props.harvest.unit}
              </h6>
            </div>
            <br />
            <p className="offer-price">
              <i className="mdi mdi-tag-outline"></i>{" "}
              {props.harvest.price.toLocaleString()} {" VNĐ / "}{" "}
              {props.harvest.unit}
            </p>
          </div>
        </Link>
        <div className="product-footer">
          <button
            type="button"
            className="btn btn-secondary btn-sm float-right"
            onClick={() => {}}
          >
            <i className="mdi mdi-cart"></i> Thêm vào giỏ hàng
          </button>

          <br />
        </div>
      </div>
    </div>
  );
};

export default ProductItemShort;

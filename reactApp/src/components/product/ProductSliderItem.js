import { Link } from "react-router-dom";

const ProductSliderItem = (props) => {
    console.log("1111")
  return (
    <div className="item">
      <div className="product">
        <Link to="/product">
          <div className="product-header">
            <img className="img-fluid" src="img/item/3.jpg" alt="" />
            <span className="veg text-success mdi mdi-circle"></span>
          </div>
          <div className="product-body">
            <div style={{ height: 80 }}>
              <h4>{props.productName}</h4>
              <h6>
                <strong>
                  <span class="mdi mdi-approval"></span> Còn lại:
                </strong>{" "}
                {props.available} {" / "} {props.maxQuantity} {props.unit}
              </h6>
            </div>
            <br />
            <p className="offer-price">
            <i className="mdi mdi-tag-outline"></i>{" "}
            {props.price.toLocaleString()} {" VNĐ / "} {props.unit}
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

export default ProductSliderItem;

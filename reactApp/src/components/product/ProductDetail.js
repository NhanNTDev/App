import { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import * as productService from "../../services/product-service";

const ProductDetail = () => {
  const [product, setProduct] = useState(null);
  useEffect(() => {
    const fetchProduct = async () => {
      const productResponse = await productService.getProduct();
      setProduct(productResponse);
    };
    fetchProduct();
  }, []);
  return (
    <div className="shop-detail-right">
      <h2>{product && product.productName}</h2>
      <h6>
        <strong>
          <span className="mdi mdi-approval"></span> Còn lại:
        </strong>{" "}
        {product && product.available}
        {" / "}
        {product && product.maxQuantity} {product && product.unit}
      </h6>
      <p className="offer-price mb-0">
        <span className="mdi mdi-tag"></span>{" "}
        <span className="price-offer">
          {product && product.price.toLocaleString()}
          {" VNĐ / "}{product && product.unit}
        </span>
      </p>
      <Link to="/checkout">
        <button type="button" className="btn btn-secondary btn-lg">
          <i className="mdi mdi-cart-outline"></i> Thêm vào giỏ hàng
        </button>{" "}
      </Link>
      <div className="short-description">
        <h5>
          Mô tả:
        </h5>
        <p style={{overflow: "hidden", textOverflow: "ellipsis", maxHeight: 150}}>{product && product.productDescription}</p>
        <p className="mb-0" style={{overflow: "hidden", textOverflow: "ellipsis", maxHeight: 150}}>
          {" "}
          <strong>Mùa vụ: </strong> {product && product.harverst}
          <br />
          {product && product.harverstDescription}
        </p>
      </div>
      
    </div>
  );
};

export default ProductDetail;

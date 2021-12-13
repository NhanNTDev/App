import { Link } from "react-router-dom";

const CartPopup = () => {
    return (
        <>
            <div className="cart-sidebar">
                <div className="cart-sidebar-header">
                    <h5>
                        My Cart <span className="text-success">(5 item)</span>{" "}
                        <a data-toggle="offcanvas" className="float-right" href="#">
                            <i className="mdi mdi-close"></i>
                        </a>
                    </h5>
                </div>
                <div className="cart-sidebar-body">
                    <div className="cart-list-product">
                        <a className="float-right remove-cart" href="#">
                            <i className="mdi mdi-close"></i>
                        </a>
                        <img className="img-fluid" src="img/item/11.jpg" alt="" />
                        <span className="badge badge-success">50% OFF</span>
                        <h5>
                            <a href="#">Product Title Here</a>
                        </h5>
                        <h6>
                            <strong>
                                <span className="mdi mdi-approval"></span> Available in
                            </strong>{" "}
                            - 500 gm
                        </h6>
                        <p className="offer-price mb-0">
                            $450.99 <i className="mdi mdi-tag-outline"></i>{" "}
                            <span className="regular-price">$800.99</span>
                        </p>
                    </div>
                    <div className="cart-list-product">
                        <a className="float-right remove-cart" href="#">
                            <i className="mdi mdi-close"></i>
                        </a>
                        <img className="img-fluid" src="img/item/7.jpg" alt="" />
                        <span className="badge badge-success">50% OFF</span>
                        <h5>
                            <a href="#">Product Title Here</a>
                        </h5>
                        <h6>
                            <strong>
                                <span className="mdi mdi-approval"></span> Available in
                            </strong>{" "}
                            - 500 gm
                        </h6>
                        <p className="offer-price mb-0">
                            $450.99 <i className="mdi mdi-tag-outline"></i>{" "}
                            <span className="regular-price">$800.99</span>
                        </p>
                    </div>
                    <div className="cart-list-product">
                        <a className="float-right remove-cart" href="#">
                            <i className="mdi mdi-close"></i>
                        </a>
                        <img className="img-fluid" src="img/item/9.jpg" alt="" />
                        <span className="badge badge-success">50% OFF</span>
                        <h5>
                            <a href="#">Product Title Here</a>
                        </h5>
                        <h6>
                            <strong>
                                <span className="mdi mdi-approval"></span> Available in
                            </strong>{" "}
                            - 500 gm
                        </h6>
                        <p className="offer-price mb-0">
                            $450.99 <i className="mdi mdi-tag-outline"></i>{" "}
                            <span className="regular-price">$800.99</span>
                        </p>
                    </div>
                    <div className="cart-list-product">
                        <a className="float-right remove-cart" href="#">
                            <i className="mdi mdi-close"></i>
                        </a>
                        <img className="img-fluid" src="img/item/1.jpg" alt="" />
                        <span className="badge badge-success">50% OFF</span>
                        <h5>
                            <a href="#">Product Title Here</a>
                        </h5>
                        <h6>
                            <strong>
                                <span className="mdi mdi-approval"></span> Available in
                            </strong>{" "}
                            - 500 gm
                        </h6>
                        <p className="offer-price mb-0">
                            $450.99 <i className="mdi mdi-tag-outline"></i>{" "}
                            <span className="regular-price">$800.99</span>
                        </p>
                    </div>
                    <div className="cart-list-product">
                        <a className="float-right remove-cart" href="#">
                            <i className="mdi mdi-close"></i>
                        </a>
                        <img className="img-fluid" src="img/item/2.jpg" alt="" />
                        <span className="badge badge-success">50% OFF</span>
                        <h5>
                            <a href="#">Product Title Here</a>
                        </h5>
                        <h6>
                            <strong>
                                <span className="mdi mdi-approval"></span> Available in
                            </strong>{" "}
                            - 500 gm
                        </h6>
                        <p className="offer-price mb-0">
                            $450.99 <i className="mdi mdi-tag-outline"></i>{" "}
                            <span className="regular-price">$800.99</span>
                        </p>
                    </div>
                </div>
                <div className="cart-sidebar-footer">
                    <div className="cart-store-details">
                        <p>
                            Sub Total <strong className="float-right">$900.69</strong>
                        </p>
                        <p>
                            Delivery Charges{" "}
                            <strong className="float-right text-danger">+ $29.69</strong>
                        </p>
                        <h6>
                            Your total savings{" "}
                            <strong className="float-right text-danger">$55 (42.31%)</strong>
                        </h6>
                    </div>
                    <Link to="/checkout">
                        <button
                            className="btn btn-secondary btn-lg btn-block text-left"
                            type="button"
                        >
                            <span className="float-left">
                                <i className="mdi mdi-cart-outline"></i> Proceed to Checkout{" "}
                            </span>
                            <span className="float-right">
                                <strong>$1200.69</strong>{" "}
                                <span className="mdi mdi-chevron-right"></span>
                            </span>
                        </button>
                    </Link>
                </div>
            </div>
        </>
    )
}


export default CartPopup;
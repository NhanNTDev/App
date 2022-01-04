import { Pagination } from "antd";
import { useEffect, useState } from "react";
import {RECORD_PER_PAGE} from "../../constants/Constants"
import {page1_product, page2_product, page3_product} from "../../constants/Data";
import ProductItem from "./ProductItem";
import ProductSliderItem from "./ProductSliderItem";

const ProductList = () => {
  const [page, setPage] = useState(1);
  const [totalRecord, setTotalRecords] = useState(1);
  const [products, setProducts] = useState([]);

  useEffect(() => {
    setTotalRecords(36);
  }, []);

  useEffect(() => {
    switch (page) {
      case 1:
        setProducts(page1_product);
        break;
      case 2:
        setProducts(page2_product);
        break;
      case 3:
        setProducts(page3_product);
        break;
    }
  }, [page]);

  const renderPagination = () => {
    return (
      <div className="pagination justify-content-center mt-4">
        <Pagination
          showSizeChanger={false}
          pageSize={RECORD_PER_PAGE}
          defaultCurrent={1}
          total={totalRecord}
          onChange={(pageNumber) => setPage(pageNumber)}
        />
      </div>
    );
  };

  const sortTitles = [
    "Giá (thấp đến cao)",
    "Giá (cao xuống thấp)",
    "Tên (A - Z)",
  ];

  const renderSortDrop = () => {
    return (
      <div className="btn-group float-right mt-2">
        <button
          type="button"
          className="btn btn-dark dropdown-toggle"
          data-toggle="dropdown"
          aria-haspopup="true"
          aria-expanded="false"
        >
          Sort by Products &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </button>
        <div className="dropdown-menu dropdown-menu-right">
          {sortTitles.map((sortTitle, index) => (
            <button className="dropdown-item" key={index} onClick={() => {}}>
              {sortTitle}
            </button>
          ))}
        </div>
      </div>
    );
  };

  return (
    <>
    <section className="shop-list">
      <div className="container">
        <div className="row">
          <div className="col-md-12">
            <div className="shop-head">
              {renderSortDrop()}
              <h5 className="mb-4">
                {/* {searchParams.get("type") === "hot"
                  ? "Chiến dịch hot"
                  : "Chiến dịch trong tuần"} */}
                Danh Sách Sản Phẩm
              </h5>
            </div>
            <div className="row no-gutters">
              {products.map((product) =>
                <ProductSliderItem product={{...product}}/>
              )}
            </div>
            {renderPagination()}
          </div>
        </div>
      </div>
    </section>
  </>
  );
};

export default ProductList;

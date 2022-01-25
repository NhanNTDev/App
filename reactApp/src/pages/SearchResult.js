import { useEffect, useState } from "react";
import { RECORD_PER_PAGE } from "../constants/Constants";
import { Pagination } from "antd";
import {useSearchParams } from "react-router-dom";
import ProductItem from "../components/product/ProductItem";
import harvestApi from "../apis/harvestApi";

const SearchResult = () => {
  const [page, setPage] = useState(1);
  const [totalRecord, setTotalRecords] = useState(12);
  const [searchProducts, setSearchProducts] = useState([]);
  let [searchParams, setSearchParam] = useSearchParams();
  const [searchValue, setSearchValue] = useState('');

  useEffect(() => {
    setSearchValue(searchParams.get('searchValue'));
  }, [searchParams]);

  useEffect(() => {
    const fetchProducts = async () => {
      const params = {
        page: page,
        size: 12,
        'product-name': searchValue,
      };
      const productsResponse = await harvestApi.getAll(params);
      setSearchProducts(productsResponse.data);
      setTotalRecords(productsResponse.metadata.total);
    };
    fetchProducts();
  }, [searchValue, page]);

  console.log(searchProducts);

  const renderPagination = () => {
    return (
      <div className="pagination justify-content-center mt-4">
        <Pagination
          showSizeChanger={false}
          pageSize={RECORD_PER_PAGE}
          defaultCurrent={page}
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
      <section className="pt-3 pb-3 page-info section-padding border-bottom bg-white">
        <div className="container">
          <div className="row">
            <div className="col-md-12">
              <a href="/home">
                <strong>
                  <span className="mdi mdi-home"></span> Trang chủ
                </strong>
              </a>{" "}
              <span className="mdi mdi-chevron-right"></span>{" "}
              <span>Kết quả tìm kiếm</span>
            </div>
          </div>
        </div>
      </section>
      <section className="shop-list section-padding">
        <div className="container">
          <div className="row">
            <div className="col-md-12">
              <div className="shop-head">
                {renderSortDrop()}
                <h5 className="mb-4">Kết quả cho '{searchValue}'</h5>
              </div>
              <div className="row no-gutters">
                {searchProducts.map((harvest) => <ProductItem {...harvest}/>)}
              </div>
              {renderPagination()}
            </div>
          </div>
        </div>
      </section>;;
    </>
  );
};

export default SearchResult;

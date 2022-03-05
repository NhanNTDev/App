import { useEffect, useLayoutEffect, useState } from "react";
import { RECORD_PER_PAGE } from "../constants/Constants";
import { Pagination } from "antd";
import { useSearchParams } from "react-router-dom";
import ProductItem from "../components/product/ProductItem";
import harvestCampaignApi from "../apis/harvestCampaignApi";
import Skeleton from "react-loading-skeleton";
import "react-loading-skeleton/dist/skeleton.css";

const SearchResult = () => {
  const [page, setPage] = useState(1);
  const [totalRecord, setTotalRecords] = useState(12);
  const [searchProducts, setSearchProducts] = useState([]);
  let [searchParams] = useSearchParams();
  const [searchValue, setSearchValue] = useState("");
  const [category, setCategory] = useState("");
  const [loading, setLoading] = useState(true);
  const [sortType, setSortType] = useState(0);

  //Get params from url
  useEffect(() => {
    setSearchValue(searchParams.get("searchValue"));
    setCategory(searchParams.get("category"));
  }, [searchParams]);

  const sortByPriceLowToHigh = () => {
      searchProducts.sort(function (product1, product2) {
        return product1.price - product2.price;
      })

  };

  const sortByPriceHighToLow = () => {

      searchProducts.sort(function (product1, product2) {
        return product2.price - product1.price;
      })
  };
  const sortByNameAZ = () => {

      searchProducts.sort(function (product1, product2) {
        return product1.name - product2.name;
      })
  };
  //Hanlde sort
  useEffect(() => {
    switch (sortType) {
      case 1:
        sortByPriceLowToHigh();
        break;
      case 2:
        sortByPriceHighToLow();
        break;
      case 3:
        sortByNameAZ();
        break;
    }
  }, [sortType]);

  useEffect(() => {
    const fetchProducts = async () => {
      const params = {
        page: page,
        size: 12,
        "product-name": searchValue,
        categorys: category,
      };
      const productsResponse = await harvestCampaignApi.getAll(params);
      setSearchProducts(productsResponse.data);
      setTotalRecords(productsResponse.metadata.total);
      setLoading(false);
    };
    fetchProducts();
  }, [searchValue,category, page]);

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
  const sortTypes = [
    {
      id: 1,
      title: "Giá (thấp đến cao)",
    },
    {
      id: 2,
      title: "Giá (cao xuống thấp)",
    },
    {
      id: 3,
      title: "Tên (A - Z)",
    },
  ];

  const renderSortDrop = () => {
    return (
      <div className="btn-group float-right mt-2">
        <button
          type="button"
          className="btn btn-secondary dropdown-toggle"
          data-toggle="dropdown"
          aria-haspopup="true"
          aria-expanded="false"
        >
          Xắp xếp sản phẩm &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </button>
        <div className="dropdown-menu dropdown-menu-right">
          {sortTypes.map((sortType) => (
            <button
              className="dropdown-item"
              key={sortType.id}
              onClick={() => {
                setSortType(sortType.id);
              }}
            >
              {sortType.title}
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
                <h5 className="mb-4">
                  Kết quả cho '{searchValue || category}'
                </h5>
              </div>

              <div className="row no-gutters">
                {searchProducts.map((harvest) => (
                  <ProductItem {...harvest} />
                ))}
              </div>
              {loading && (
                <Skeleton count={12} width="25%" inline={true} height={250} />
              )}
              {renderPagination()}
            </div>
          </div>
        </div>
      </section>
      ;;
    </>
  );
};

export default SearchResult;

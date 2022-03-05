import { useEffect, useLayoutEffect, useState } from "react";
import { RECORD_PER_PAGE } from "../constants/Constants";
import { Pagination, Select } from "antd";
import { useSearchParams } from "react-router-dom";
import ProductItem from "../components/product/ProductItem";
import harvestCampaignApi from "../apis/harvestCampaignApi";
import Skeleton from "react-loading-skeleton";
import "react-loading-skeleton/dist/skeleton.css";
const { Option } = Select;
//Sort list by price low to high
const sortByPriceLowToHigh = (listProduct) => {
  listProduct.sort(function (product1, product2) {
    return product1.price - product2.price;
  });
  return listProduct;
};
//Sort list by price high to low
const sortByPriceHighToLow = (listProduct) => {
  listProduct.sort(function (product1, product2) {
    return product2.price - product1.price;
  });
  return listProduct;
};
//Sort list by name A-Z
const sortByNameAZ = (listProduct) => {
  listProduct.sort(function (product1, product2) {
    let a = product1.productName.toLowerCase();
    let b = product2.productName.toLowerCase();
    return a === b ? 0 : a > b ? 1 : -1;
  });
  return listProduct;
};

const SearchResult = () => {
  const [page, setPage] = useState(1);
  const [totalRecord, setTotalRecords] = useState(12);
  const [searchProducts, setSearchProducts] = useState([]);
  const [displayProducts, setDisplayProducts] = useState([]);
  const [searchParams] = useSearchParams();
  const [searchValue, setSearchValue] = useState("");
  const [category, setCategory] = useState("");
  const [loading, setLoading] = useState(true);
  const [sortType, setSortType] = useState(0);

  //Get params from url
  useEffect(() => {
    setSearchValue(searchParams.get("searchValue"));
    setCategory(searchParams.get("category"));
  }, [searchParams]);

  //Hanlde sort
  useEffect(() => {
    const sort = async () => {
      switch (sortType) {
        case 0:
          setDisplayProducts(searchProducts);
          break;
        case 1:
          setDisplayProducts(sortByPriceLowToHigh(searchProducts));
          break;
        case 2:
          setDisplayProducts(sortByPriceHighToLow(searchProducts));
          break;
        case 3:
          setDisplayProducts(sortByNameAZ(searchProducts));
          break;
      }
    };
    sort();
  }, [sortType]);

  //Get data from server
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
      setDisplayProducts(productsResponse.data);
      setTotalRecords(productsResponse.metadata.total);
      setLoading(false);
    };
    fetchProducts();
  }, [searchValue, category, page]);

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
      id: 0,
      title: "Xắp xếp mặc định   ",
    },
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
        <Select
          className="btn btn-secondary dropdown-menu"
          onChange={(value) => {
            setSortType(value);
          }}
          defaultValue={0}
        >
          {sortTypes.map((sortType) => (
            <Option className="dropdown-item" value={sortType.id}>
              {sortType.title}
            </Option>
          ))}
        </Select>
      </div>
    );
  };

  const renderProductList = (listProduct) => {
    return (
      <>
        {listProduct.map((harvestCampaign) => (
          <ProductItem {...harvestCampaign} />
        ))}
      </>
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
                {renderProductList(displayProducts)}
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

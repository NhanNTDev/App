import { useEffect, useState } from "react";
import { RECORD_PER_PAGE } from "../constants/Constants";
import { Button, notification, Pagination, Result, Row, Select } from "antd";
import { useNavigate, useSearchParams } from "react-router-dom";
import ProductItem from "../components/product/ProductItem";
import harvestCampaignApi from "../apis/harvestCampaignApi";
import Skeleton from "react-loading-skeleton";
import "react-loading-skeleton/dist/skeleton.css";
import { useSelector } from "react-redux";
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
  const [displayProducts, setDisplayProducts] = useState({
    list: [],
    changePlag: true,
  });
  const [searchParams] = useSearchParams();
  const [searchValue, setSearchValue] = useState(searchParams.get("searchValue"));
  const [category, setCategory] = useState(searchParams.get("category"));
  const [loading, setLoading] = useState(true);
  const [noResult, setNoResult] = useState(false);
  const [sortType, setSortType] = useState();
  const address = useSelector((state) => state.location);
  const zoneId = useSelector(state => state.zone);
  const navigate = useNavigate();
  //Get params from url
  useEffect(() => {
    setSearchValue(searchParams.get("searchValue"));
    setCategory(searchParams.get("category"));
    console.log(window.location.href);
    setLoading(true);
  }, [searchParams]);

  //Hanlde sort
  useEffect(() => {
    const sort = async () => {
      let newList = [];
      switch (sortType) {
        case 0:
          break;
        case 1:
          newList = sortByPriceLowToHigh(displayProducts.list);
          setDisplayProducts({
            list: newList,
            changePlag: !displayProducts.changePlag,
          });
          break;
        case 2:
          newList = sortByPriceHighToLow(displayProducts.list);
          setDisplayProducts({
            list: newList,
            changePlag: !displayProducts.changePlag,
          });
          break;
        case 3:
          newList = sortByNameAZ(displayProducts.list);
          setDisplayProducts({
            list: newList,
            changePlag: !displayProducts.changePlag,
          });
          break;
      }
    };
    sort();
  }, [sortType]);

  //Get data from server
  useEffect(() => {
    setNoResult(false);
    const fetchProducts = async () => {
      const params =
        searchValue !== null
          ? {
              page: page,
              size: 12,
              "product-name": searchValue,
              "delivery-zone-id": parseInt(zoneId),
            }
          : {
              page: page,
              size: 12,
              categorys: category,
              "delivery-zone-id": parseInt(zoneId),
            };
      await harvestCampaignApi.getAll(params).then(result => {
        if(Object.entries(result.data).length === 0) {
          setNoResult(true);
          return;
        }
        setDisplayProducts({
          list: result.data,
          changePlag: !displayProducts.changePlag,
        });
        setTotalRecords(result.metadata.total);
      }).catch(err => {
        if (err.message === "Network Error") {
          notification.error({
            duration: 3,
            message: "Mất kết nối mạng!",
            style: { fontSize: 16 },
          });
        } else {
          notification.error({
            duration: 3,
            message: "Không tìm thấy sản phẩm!",
            style: { fontSize: 16 },
          });
        }
        setNoResult(true);
      });
      
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
          defaultCurrent={1}
          current={page}
          total={totalRecord}
          onChange={(pageNumber) => {
            setLoading(true);
            setPage(pageNumber);
          }}
        />
      </div>
    );
  };
  const sortTypes = [
    {
      id: 0,
      title: "Xắp xếp theo   ",
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
            <Option
              className="dropdown-item"
              value={sortType.id}
              disabled={sortType.id === 0 ? true : null}
            >
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
    {noResult ? <Result
    status="warning"
    title="Không tìm thấy sản phẩm nào!"
    extra={
      <Button type="primary" key="console" onClick={() => {
        navigate("/home")
      }}>
        Về trang chủ
      </Button>
    }
  /> : 
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

              {loading ? (
                <Skeleton count={12} width="25%" inline={true} height={250} />
              ) : (
                <Row className="row">
                  {renderProductList(displayProducts.list)}
                </Row>
              )}
              {renderPagination()}
            </div>
          </div>
        </div>
      </section>
    </>
    }
    </>
  );
};

export default SearchResult;

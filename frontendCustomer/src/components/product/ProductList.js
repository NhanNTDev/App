import { notification, Pagination, Row } from "antd";
import { useEffect, useState } from "react";
import harvestCampaignApi from "../../apis/harvestCampaignApi";
import ProductSliderItem from "./ProductItemShort";
import { Select } from "antd";
import { useParams } from "react-router-dom";
import { useSelector } from "react-redux";
import Skeleton from "react-loading-skeleton";
import "react-loading-skeleton/dist/skeleton.css";
const { Option } = Select;

//Sort list by price low to high
const sortByPriceLowToHigh = (listProduct) => {
  listProduct = listProduct.sort(function (product1, product2) {
    return product1.price - product2.price;
  });
  return listProduct;
};
//Sort list by price high to low
const sortByPriceHighToLow = (listProduct) => {
  listProduct = listProduct.sort(function (product1, product2) {
    return product2.price - product1.price;
  });
  return listProduct;
};
//Sort list by name A-Z
const sortByNameAZ = (listProduct) => {
  listProduct = listProduct.sort(function (product1, product2) {
    let a = product1.productName.toLowerCase();
    let b = product2.productName.toLowerCase();
    return a === b ? 0 : a > b ? 1 : -1;
  });
  return listProduct;
};

const ProductList = () => {
  const params = useParams();
  const [page, setPage] = useState(1);
  const [totalRecord, setTotalRecords] = useState(1);
  const [loading, setLoading] = useState(true);
  const [displayProducts, setDisplayProducts] = useState({
    list: [],
    changePlag: true,
  });
  const [sortType, setSortType] = useState(null);
  const zoneId = useSelector(state => state.zone);

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

  useEffect(() => {
    const fetchHarvests = async () => {
      const param = {
        page: page,
        size: 12,
        "campaign-id": params.id,
        "delivery-zone-id": parseInt(zoneId),
      };
      await harvestCampaignApi
        .getAll(param)
        .then((result) => {
          setTotalRecords(result.metadata.total);
          setDisplayProducts({
            list: result.data,
            changePlag: !displayProducts.changePlag,
          });
        })
        .catch((err) => {
          if (err.message === "Network Error") {
            notification.error({
              duration: 3,
              message: "Mất kết nối mạng!",
              style: { fontSize: 16 },
            });
          } else {
            notification.error({
              duration: 3,
              message: "Có lỗi xảy ra trong quá trình xử lý!",
              style: { fontSize: 16 },
            });
          }
        });

      setLoading(false);
    };
    fetchHarvests();
  }, [page]);

  const renderPagination = () => {
    return (
      <div className="pagination justify-content-center mt-4">
        <Pagination
          showSizeChanger={false}
          pageSize={12}
          defaultCurrent={1}
          current={page}
          total={totalRecord}
          onChange={(pageNumber) => {
            setPage(pageNumber);
            setLoading(true);
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
              key={sortType.id}
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

  return (
    <>
      <section className="shop-list section-padding">
        <div className="container-fluid">
        <div className="row">
          <div className="col-md-12">
            <div className="shop-head">
              {renderSortDrop()}
              <h5 className="mb-4">Danh Sách Sản Phẩm</h5>
            </div>
            {loading ? (
              <Skeleton count={9} width="33%" inline={true} height={250} />
            ) : (
              <>
                <Row className="row">
                  {displayProducts.list.map((harvestCampaign) => (
                      <ProductSliderItem
                        harvestCampaign={{ ...harvestCampaign }}
                        campaignId={params.id}
                      />
                  ))}
                </Row>
                {renderPagination()}{" "}
              </>
            )}
          </div>
        </div>
        </div>
      </section>
    </>
  );
};

export default ProductList;

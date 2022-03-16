import { Col, Pagination } from "antd";
import { useEffect, useState } from "react";
import { RECORD_PER_PAGE } from "../../constants/Constants";
import harvestCampaignApi from "../../apis/harvestCampaignApi";
import ProductSliderItem from "./ProductItemShort";
import { Select } from "antd";
import { useParams } from "react-router-dom";
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

const ProductList = (props) => {
  const params = useParams();
  const [page, setPage] = useState(1);
  const [totalRecord, setTotalRecords] = useState(1);
  // const [products, setproducts] = useState([]);
  const [displayProducts, setDisplayProducts] = useState({
    list: [],
    changePlag: true,
  });
  const [sortType, setSortType] = useState(null);

  //Hanlde sort
  useEffect(() => {
    const sort = async () => {
      let newList = [];
      switch (sortType) {
        case 0:
          // newList = products;
          // setDisplayProducts({
          //   list: newList,
          //   changePlag: !displayProducts.changePlag,
          // });
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

  // useEffect(() => {
  //   console.log(products);
  //   console.log(displayProducts);
  // }, [displayProducts]);

  useEffect(() => {
    const fetchHarvests = async () => {
      const param = {
        page: page,
        size: 12,
        "campaign-id": params.id,
      };
      const harvestsResponse = await harvestCampaignApi.getAll(param);
      setTotalRecords(harvestsResponse.metadata.total);
      // setproducts(harvestsResponse.data);
      setDisplayProducts({
        list: harvestsResponse.data,
        changePlag: !displayProducts.changePlag,
      });
    };
    fetchHarvests();
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

  return (
    <>
      <section className="shop-list">
        <div className="container">
          <div className="row">
            <div className="col-md-12">
              <div className="shop-head">
                {renderSortDrop()}
                <h5 className="mb-4">Danh Sách Sản Phẩm</h5>
              </div>
              <div className="row">
                {displayProducts.list.map((harvestCampaign) => (
                  <Col span={12}>
                    <ProductSliderItem
                      harvestCampaign={{ ...harvestCampaign }}
                      campaignId={props.campaignId}
                    />
                  </Col>
                ))}
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

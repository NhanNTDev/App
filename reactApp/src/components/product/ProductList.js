import { Card, Col, Pagination, Row } from "antd";
import { useEffect, useState } from "react";
import { RECORD_PER_PAGE } from "../../constants/Constants";
import harvestApi from "../../apis/harvestApi";
import ProductSliderItem from "./ProductItemShort";
import { useParams } from "react-router-dom";

const ProductList = (props) => {
  const params = useParams();
  console.log(params);
  const [page, setPage] = useState(1);
  const [totalRecord, setTotalRecords] = useState(1);
  const [harvests, setHarvests] = useState([]);

  useEffect(() => {
    const fetHarvests = async () => {
      const param = {
        page: page,
        size: 12,
      };
      const harvestsResponse = await harvestApi.getAll(param);
      console.log(harvestsResponse);
      setTotalRecords(harvestsResponse.metadata.total);
      setHarvests(harvestsResponse.data);
    };
    fetHarvests();
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
                <h5 className="mb-4">Danh Sách Sản Phẩm</h5>
              </div>
              <div className="row">
                {/* <Row gutter={16}> */}
                  {harvests.map((harvest) => (
                    <Col span={8}>
                      <ProductSliderItem
                        harvest={{ ...harvest }}
                        campaignId={props.campaignId}
                        farmId={props.farmId}
                      />
                    </Col>
                  ))}
                {/* </Row> */}
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

import { useEffect, useState } from "react";
import { RECORD_PER_PAGE } from "../../constants/Constants";
import farmApi from "../../apis/farmApi";
import { Col, Pagination, Row } from "antd";
import { Link } from "react-router-dom";
import "antd/dist/antd.css";
import FarmItem from "./FarmItem";

const FarmList = ({ campaignId }) => {
  const [page, setPage] = useState(1);
  const [totalRecord, setTotalRecords] = useState(1);
  const [farms, setFarms] = useState([]);

  useEffect(() => {
    const fetchFarms = async () => {
      const params = {
        page: page,
        size: 12,
      };
      const farmsResponse = await farmApi.getAll(params);
      setFarms(farmsResponse.data);
      setPage(farmsResponse.metadata.page);
      setTotalRecords(farmsResponse.metadata.total);
    };
    fetchFarms();
  }, [page]);
  
  console.log(farms);

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
          Sort by Farms &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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

  // const renderCampaignItem = (props) => {
  //   return (
  //     <div className="col-md-4">
  //       <div className="product">
  //         <Link to={`/campaign/${campaignId}/${props.id}`}>
  //           <div className="product-header">
  //             <img className="img-fluid" src={props.image1} alt="" />
  //             <span className="veg text-success mdi mdi-circle"></span>
  //           </div>
  //           <div className="product-body">
  //             <div className="title">
  //               <h4>{props.name}</h4>
  //             </div>
  //             <div className="detail">
  //               <h5>
  //                 <i>
  //                   <span className="mdi mdi-map-marker"></span> Địa Chỉ:
  //                 </i>{" "}
  //                 {props.address}
  //               </h5>
  //               <h5>
  //                 <i>
  //                   <span className=" "></span> Số điện thoại:
  //                 </i>{" "}
  //                 {props.phone}
  //               </h5>
  //               <h5>
  //                 <i>
  //                   <span className="mdi mdi-email"></span> Email:
  //                 </i>{" "}
  //                 {props.email}
  //               </h5>
  //             </div>
  //             <br />
  //           </div>
  //         </Link>
  //         <div className="product-footer">
  //           <Link
  //             to={`/campaign/${campaignId}/${props.id}`}
  //             type="button"
  //             className="btn btn-secondary btn-sm float-right"
  //             onClick={() => {}}
  //           >
  //             <i className="mdi mdi-eye"></i> Xem Quầy Bán
  //           </Link>
  //           <br />
  //         </div>
  //       </div>
  //     </div>
  //   );
  // };

  return (
    <>
      <section className="shop-list">
        <div className="container">
          <div className="row">
            <div className="col-md-12">
              <div className="shop-head">
                {renderSortDrop()}
                <h5 className="mb-4">
                  Danh Sách Nông Trại
                </h5>
              </div>
              <div className="row no-gutters">
                <Row>
                  {farms.map((farm) => (
                    <Col span={8}>
                      <FarmItem farm={{...farm}} campaignId={campaignId}/>
                    </Col>
                  ))}
                </Row>
              </div>
              {renderPagination()}
            </div>
          </div>
        </div>
      </section>
    </>
  );
};

export default FarmList;

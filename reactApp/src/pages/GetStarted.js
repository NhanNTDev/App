import React from "react";
import { Link } from "react-router-dom";

const GetStarted = () => {
  return (
    <div className="get-started-page">
      <div className="form">
        <div className="input-group" style={{ paddingBottom: 50 }}>
          <h1>Đi Chợ Nào</h1>
          <li className="list-inline-item">
            <Link to="/login" className="btn btn-link">
              <i className="mdi mdi-account-circle"></i> Đăng nhập/Đăng ký
            </Link>
          </li>
        </div>

        <div className="form-message">
            <h2>Bạn ở đâu?</h2>
          <i>
            <h5>Hãy nhập địa chỉ để tìm kiếm những chiến dịch ưu đãi nhất ở gần bạn.</h5>
          </i>
        </div>

        <div className="input-group">
          <input
            className="form-control"
            placeholder="Nhập địa chỉ tại đây..."
          />
          <span className="input-group-btn">
            <button className="btn btn-secondary-lighter"><span className="mdi mdi-target icons"></span></button>
          </span>
          <span className="input-group-btn">
            <button className="btn btn-secondary">Tìm Nông Sản</button>
          </span>
        </div>
      </div>
    </div>
  );
};

export default GetStarted;

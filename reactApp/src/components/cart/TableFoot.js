import React from "react";

const TableFoot = (props) => {
  return (
    <tfoot>
      <tr>
        <td colSpan="8">
          <div className="input-group" style={{width: '50%', marginLeft: "30%"}}>
            <input
              type="text"
              placeholder="Nhập mã giảm giá"
              className="form-control border-form-control mr-100"
              style={{marginRight: 10}}
            />
            <button className="btn btn-success float-left" onClick={() => {}}>
              Áp dụng
            </button>
          </div>
        </td>
      </tr>
    </tfoot>
  );
};

export default TableFoot;

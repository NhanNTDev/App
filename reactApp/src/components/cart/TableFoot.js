import React from "react";

const TableFoot = (props) => {
  return (
    <tfoot>
      <tr>
        <td colSpan="3"></td>
        <td colSpan="2">
          <input
            type="text"
            placeholder="Nhập mã giảm giá"
            className="form-control border-form-control"
          />
        </td>
        <td colSpan="3">
          <button className="btn btn-success float-left" onClick={() => {}}>
            Áp dụng
          </button>
        </td>
      </tr>
    </tfoot>
  );
};

export default TableFoot;

import React from "react";
import { useSelector } from "react-redux";
import { getShipcost } from "../../state_manager_redux/cart/cartSelector";

const TableFoot = () => {
  const shipCost = useSelector(getShipcost);
  return (
    <tfoot>
      <tr>
        <td colSpan="8">
          <h6 style={{textAlign: "right", marginRight: 20}}><strong>Phí vận chuyển: </strong>{shipCost.toLocaleString() + "  VNĐ"} </h6>
        </td>
      </tr>
    </tfoot>
  );
};

export default TableFoot;

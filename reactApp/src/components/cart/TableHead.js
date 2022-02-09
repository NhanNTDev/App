import { AutoComplete, Checkbox } from 'antd';
import React from 'react';

const TableHead = () => {
  return (
    <thead>
    <tr>
      <th style={{width: "5%"}}>
        <Checkbox />
      </th>
      <th className="cart_product" style={{width: "10%"}}>Sản phẩm</th>
      <th style={{width: "15%"}}></th>
      <th style={{width: "10%"}}>Đơn giá</th>
      <th style={{width: "20%", textAlign: 'center'}}>Số lượng</th>
      <th style={{width: "10%"}}>Đơn vị</th>
      <th style={{width: "15%"}}>Thành Tiền</th>
      <th style={{width: "15%"}} className="text-center">Thao tác</th>
    </tr>
  </thead>
  );
};

export default TableHead;
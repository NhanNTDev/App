import { Checkbox } from 'antd';
import React from 'react';

const TableHead = () => {
  return (
    <thead>
    <tr>
      <th>
        <Checkbox />
      </th>
      <th className="cart_product">Sản phẩm</th>
      <th></th>
      <th>Đơn giá</th>
      <th className="d-flex justify-content-center">Số lượng</th>
      <th>Đơn vị</th>
      <th>Thành Tiền</th>
      <th className="text-center">Thao tác</th>
    </tr>
  </thead>
  );
};

export default TableHead;
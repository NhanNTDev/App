import { AutoComplete, Checkbox } from 'antd';
import React from 'react';
import { useDispatch } from 'react-redux';
import { checkCampaign } from '../../state_manager_redux/cart/cartSlice';

const TableHead = ({campaignId, checked}) => {
  const dispatch = useDispatch();
  const action = checkCampaign({currentValue: checked});
  const handleCheckbox = () => {
    dispatch(action);
  }
  return (
    <thead>
    <tr>
      <th style={{width: "5%"}}>
        <Checkbox checked={checked} onChange={handleCheckbox}/>
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
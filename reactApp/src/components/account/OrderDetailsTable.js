import {  notification, Table, Modal } from "antd";
import { Link, useSearchParams } from "react-router-dom";
import { useEffect, useState } from "react";
import orderApi from "../../apis/orderApi";
import { ExclamationCircleOutlined } from "@ant-design/icons";
const { confirm } = Modal;
const OrderDetailsTable = () => {
  const [page, setPage] = useState(1);
  const [total, setTotal] = useState(1);
  const [products, setProducts] = useState([]);
  const [order, setOrder] = useState();
  const [loading, setLoading] = useState(true);
  const [changePlag, setChangePlag] = useState(true);
  const [searchParams] = useSearchParams();
  const orderId = searchParams.get("id");
  useEffect(() => {
    const getOrderDetails = async () => {
      const result = await orderApi.getOrderDetails(orderId);
      if (result) {
        setOrder(result);
        let listProduct = [];
        let index = 1;
        setTotal(Object.entries(result.harvestOrders).length);
        result.harvestOrders.map((product) => {
          listProduct.push({ index: index++, ...product });
        });
        setProducts(listProduct);
        setLoading(false);
      }
    };
    getOrderDetails();
  }, [page, changePlag]);

  function ShowCancelOrderConfirm(record) {
    confirm({
      title: "Bạn có chắc muốn hủy đơn hàng này?",
      icon: <ExclamationCircleOutlined />,
      content: "Sau khi hủy sẽ không thể hoàn tác!",
      okText: "Xác nhận",
      okType: "danger",
      cancelText: "Thoát",
      onOk() {
        const cancelOrder = async () => {
          const result = await orderApi
            .cancelOrder({ orderId: record.id, note: "Khách hàng hủy đơn!" })
            .catch((err) => {
              console.log(err);
              notification.error({
                duration: 2,
                message: "Hủy đơn hàng thất bại!",
                style: { fontSize: 16 },
              });
            });
          if (result === "Reject successfully!") {
            notification.success({
              duration: 2,
              message: "Hủy đơn hàng thành công",
              style: { fontSize: 16 },
            });
            setChangePlag(!changePlag);
          }
        };
        cancelOrder();
      },
      onCancel() {},
    });
  }
  const columns = [
    {
      title: "STT",
      dataIndex: "index",
      key: "index",
    },
    {
      title: "Tên sản phẩm",
      dataIndex: "productName",
      key: "productName",
    },
    // {
    //   title: "Tên chiến dịch",
    //   dataIndex: "campaignName",
    //   key: "campaignName",
    // },
    {
      title: "Số lượng",
      dataIndex: "quantity",
      key: "quantity",
    },
    {
      title: "Đơn vị",
      dataIndex: "unit",
      key: "unit",
    },
    {
      title: "Giá",
      dataIndex: "price",
      key: "prive",
      render: (text, record) => (
        <div>{record.price.toLocaleString() + " VNĐ"}</div>
      ),
    },

    {
      title: "Tổng tiền",
      dataIndex: "total",
      key: "total",
      render: (text, record) => (
        <div>{record.total.toLocaleString() + " VNĐ"}</div>
      ),
    },
  ];
  return (
    <div class="card card-body account-right">
      <div class="widget">
        <div class="section-header">
          <Link
            to="/orderList"
            className="btn btn-secondary"
          >
            Trở về
          </Link>
          <br/>
          <br/>
          <h4 class="heading-design-h4">
            Chi tiết đơn hàng {order && order.code}
          </h4>
        </div>
        <br />
        <div class="order-list-tabel-main table-responsive">
          <h5 class="heading-design-h5">
            <strong>Tên chiến dịch: </strong> {order && order.campaignName}
          </h5>
          <h5 class="heading-design-h5">
            <strong>Địa chỉ nhận hàng: </strong>
            {order && order.address}
          </h5>
          <h5 class="heading-design-h5">
            <strong>Số điện thoại nhận hàng: </strong>
            {order && order.phone}
          </h5>
          <h5 class="heading-design-h5">
            <strong>Ngày tạo: </strong>
            {order && order.dateTimeParse}
          </h5>
          <h5 class="heading-design-h5">
            <strong>Trạng thái: </strong>
            {order && order.status}
          </h5>
          <h5 class="heading-design-h5">
            <strong>Tổng tiền: </strong>
            {order && order.total.toLocaleString() + " VNĐ"}
          </h5>
          <h5 class="heading-design-h5">
            <strong>Danh sách sản phẩm: </strong>
          </h5>
          <Table
            columns={columns}
            dataSource={products}
            pagination={{
              position: ["bottomCenter"],
              pageSize: 10,
              total: total,
              onChange: (page) => {
                setPage(page);
              },
            }}
            loading={loading}
            style={{ margin: 50 }}
            // onRow={(record, rowIndex) => setOnRow()}
          />
        </div>
      </div>
    </div>
  );
};

export default OrderDetailsTable;

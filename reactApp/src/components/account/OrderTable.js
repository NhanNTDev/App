import { Button, notification, Table, Tag , Modal} from "antd";
import { Link } from "react-router-dom";
import { useEffect, useState } from "react";
import { useSelector } from "react-redux";
import orderApi from "../../apis/orderApi";
import { ExclamationCircleOutlined } from "@ant-design/icons";
const { confirm } = Modal;
const OrderTable = () => {
  const [page, setPage] = useState(1);
  const [total, setTotal] = useState(1);
  const [orders, setOrders] = useState([]);
  const [loading, setLoading] = useState(true);
  const [changePlag, setChangePlag] = useState(true);
  const user = useSelector((state) => state.user);
  useEffect(() => {
    const getOrderList = async () => {
      const result = await orderApi.getOrderList(user.id);
      if (result) {
        let listOrder = [];
        let index = 1;
        setTotal(Object.entries(result).length);
        result.map((order) => {
          listOrder.push({ index: index++, ...order });
        });
        setOrders(listOrder);
        setLoading(false);
      }
    };
    getOrderList();
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
          const result = await orderApi.cancelOrder({orderId: record.id, note: "Khách hàng hủy đơn!"}).catch((err) => {
            console.log(err);
            notification.error({
              duration: 2,
              message: "Hủy đơn hàng thất bại!",
              style:{fontSize: 16},
            });
          });
          if (result === "Reject successfully!") {
            notification.success({
              duration: 2,
              message: "Hủy đơn hàng thành công",
              style:{fontSize: 16},
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
      title: "Mã đơn hàng",
      dataIndex: "code",
      key: "code",
    },
    {
      title: "Ngày tạo",
      dataIndex: "dateTimeParse",
      key: "dateTimeParse",
    },
    {
      title: "Tổng tiền",
      dataIndex: "total",
      key: "total",
      render: (text, record) => (
        <div>{record.total.toLocaleString() + " VNĐ"}</div>
      ),
    },

    {
      title: "Trạng thái",
      dataIndex: "status",
      key: "status",
      render: (text) => (
        <>
          {text === "Chờ xác nhận" ? (
            <Tag color="green">{text}</Tag>
          ) : text === "Đã hoàn thành" ? (
            <Tag color="orange">{text}</Tag>
          ) : text === "Đã hủy" ?<Tag color="red">{text}</Tag> :(
            <Tag color="geekblue">{text}</Tag>
          )}
        </>
      ),
    },
    {
      title: "Hủy đơn hàng",
      dataIndex: "cancel",
      key: "cancel",
      render: (text, record) => (
        <>
          {record.status === "Chờ xác nhận" ? (
            <Button type="primary" danger onClick={()=> ShowCancelOrderConfirm(record)}>
              Hủy
            </Button>
          ) : (
            <Button disabled="true" type="primary" danger>
              Hủy
            </Button>
          )}
        </>
      ),
    },
    {
      title: "Hành động",
      dataIndex: "action",
      key: "action",
      render: (text, record) => (
        <>
          <Link to={`/orderDetails?id=${record.id}`}>Xem chi tiết</Link>
          <br />
          <br />
          <Button type="default" style={{backgroundColor: 'orange'}}>Đánh giá</Button>
        </>
      ),
    },
  ];
  return (
    <div class="card card-body account-right">
      <div class="widget">
        <div class="section-header">
          <h5 class="heading-design-h5">Lịch Sử Đặt Hàng</h5>
        </div>
        <div class="order-list-tabel-main table-responsive">
          <Table
            columns={columns}
            dataSource={orders}
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

export default OrderTable;

import { Button, notification, Table, Tag, Modal, Result } from "antd";
import { Link } from "react-router-dom";
import { useEffect, useState } from "react";
import { useSelector } from "react-redux";
import orderApi from "../../apis/orderApi";
import { ExclamationCircleOutlined } from "@ant-design/icons";
import CreateRating from "../rating/CreateRating";
import ViewRating from "../rating/ViewRating";
const { confirm } = Modal;
const OrderTable = () => {
  const [page, setPage] = useState(1);
  const [total, setTotal] = useState(1);
  const [orders, setOrders] = useState([]);
  const [loading, setLoading] = useState(true);
  const [reload, setReload] = useState(true);
  const [loadErr, setLoadErr] = useState(false);
  const user = useSelector((state) => state.user);
  useEffect(() => {
    setLoadErr(false);
    setLoading(true);
    const getOrderList = async () => {
      await orderApi
        .getOrderList({ userId: user.id, page: page })
        .then((result) => {
          if (result) {
            let listOrder = [];
            let index = 10 * (page - 1) + 1;
            setTotal(result.metadata.total);
            result.data.map((order) => {
              listOrder.push({ index: index++, ...order });
            });
            setOrders(listOrder);
          }
        })
        .catch((err) => {
          if (err.message === "Network Error") {
            notification.error({
              duration: 3,
              message: "Mất kết nối mạng!",
              style: { fontSize: 16 },
            });
          } else {
            notification.error({
              duration: 3,
              message: "Có lỗi xảy ra trong quá trình xử lý!",
              style: { fontSize: 16 },
            });
          }
          setLoadErr(true);
        });

      setLoading(false);
    };
    getOrderList();
  }, [page, reload]);

  const callbackAfterFeedback = () => {
    setLoading(true);
    setReload(!reload);
  };

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
            .catch(() => {
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
            setReload(!reload);
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
      title: "Phí vận chuyển",
      dataIndex: "shipCost",
      key: "shipCost",
      render: (text, record) => (
        <div>{record.shipCost.toLocaleString() + " VNĐ"}</div>
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
    {
      title: "Thanh Toán",
      dataIndex: "payment",
      key: "payment",
      render: (text, record) => <div>{record.payments[0].status}</div>,
    },
    {
      title: "Trạng thái",
      dataIndex: "status",
      key: "status",
      NodeFilter: {
        okText: "Lọc",
      },
      filters: [
        {
          text: "Đã hoàn thành",
          value: "Đã hoàn thành",
        },
        {
          text: "Đã hủy",
          value: "Đã hủy",
        },
        {
          text: "Chờ xác nhận",
          value: "Chờ xác nhận",
        },
        {
          text: "Đang giao hàng",
          value: "Đang giao hàng",
        },
      ],
      onFilter: (value, record) => record.status.indexOf(value) === 0,
      render: (text) => (
        <>
          {text === "Chờ xác nhận" ? (
            <Tag color="green">{text}</Tag>
          ) : text === "Đã hoàn thành" ? (
            <Tag color="orange">{text}</Tag>
          ) : text === "Đã hủy" ? (
            <Tag color="red">{text}</Tag>
          ) : (
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
            <Button
              type="primary"
              danger
              onClick={() => ShowCancelOrderConfirm(record)}
            >
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
          {record.status === "Đã hoàn thành" &&
            (record.feedbackCreateAt === null ? (
              <CreateRating
                orderId={record.id}
                callback={callbackAfterFeedback}
              />
            ) : (
              <ViewRating {...record} />
            ))}
        </>
      ),
    },
  ];
  return (
    <>
      {loadErr ? (
        <Result
          status="error"
          title="Đã có lỗi xảy ra!"
          subTitle="Rất tiếc đã có lỗi xảy ra trong quá trình tải dữ liệu, quý khách vui lòng kiểm tra lại kết nối mạng và thử lại."
          extra={[
            <Button
              type="primary"
              key="console"
              onClick={() => {
                setReload(!reload);
              }}
            >
              Tải lại
            </Button>,
          ]}
        ></Result>
      ) : (
        <div className="card card-body account-right">
          <div className="widget">
            <div className="section-header">
              <h5 className="heading-design-h5">Lịch Sử Đặt Hàng</h5>
            </div>
            <div className="order-list-tabel-main table-responsive">
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
              />
            </div>
          </div>
        </div>
      )}
    </>
  );
};

export default OrderTable;

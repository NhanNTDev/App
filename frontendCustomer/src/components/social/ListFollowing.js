import { List, Avatar, Pagination, Button, Modal, notification } from "antd";
import { ExclamationCircleOutlined } from "@ant-design/icons";
import { useEffect, useState } from "react";
import { useSelector } from "react-redux";
import userFollowApi from "../../apis/userFollowApis";

const { confirm } = Modal;

const ListFollowing = ({recallApi}) => {
  const user = useSelector((state) => state.user);
  const [loading, setLoading] = useState(true);
  const [listUser, setListUser] = useState([]);
  const [page, setPage] = useState(1);
  const [reload, setReload] = useState(true);
  const [totalUser, setTotalUser] = useState(0);

  useEffect(() => {
    const getListFollowing = async () => {
      setLoading(true);
      await userFollowApi
        .getFollowing({ userId: user.id, page: page, size: 20 })
        .then((result) => {
          setTotalUser(result.metadata.total);
          setListUser(result.data);
        })
        .catch((err) => {});
      setLoading(false);
    };
    getListFollowing();
  }, [page, reload, recallApi]);

  function ShowUnfollowConfirm(followingUser) {
    confirm({
      title: "Bạn có chắc muốn hủy theo dõi người này?",
      icon: <ExclamationCircleOutlined />,
      content: "Bạn sẽ không còn thấy những hoạt động của họ sau này!",
      okText: "Xác nhận",
      okType: "danger",
      cancelText: "Thoát",
      onOk() {
        const unfollowUser = async () => {
          setLoading(true);
          await userFollowApi
            .unfollowUser({
              customerId: user.id,
              followingId: followingUser.followingId,
            })
            .catch(() => {});
          setLoading(false);
          setReload(!reload);
        };
        unfollowUser();
      },
      onCancel() {},
    });
  }

  return (
    <>
      <div className="container-fluid">
        <h5 className="heading-design-h5">
          Bạn đang theo dõi {totalUser} người!
        </h5>
        <List
          itemLayout="horizontal"
          dataSource={listUser}
          loading={loading}
          renderItem={(item) => (
            <List.Item>
              <List.Item.Meta
                avatar={<Avatar src={item.followingImage} />}
                title={item.followingName}
              />
              <Button onClick={() => ShowUnfollowConfirm(item)}>
                <li className="mdi mdi-account-remove" >Bỏ theo dõi </li>
              </Button>
            </List.Item>
          )}
        />
        <div className="d-flex justify-content-center" style={{ margin: 30 }}>
          <Pagination
            total={totalUser}
            size={20}
            current={page}
            onChange={(current) => {
              setPage(current);
            }}
          ></Pagination>
        </div>
      </div>
    </>
  );
};

export default ListFollowing;

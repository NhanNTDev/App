import { List, Avatar, Pagination } from "antd";
import { useEffect, useState } from "react";
import { useSelector } from "react-redux";
import userFollowApi from "../../apis/userFollowApis";

const ListFollower = ({recallApi}) => {
  const user = useSelector((state) => state.user);
  const [loading, setLoading] = useState(true);
  const [listUser, setListUser] = useState([]);
  const [page, setPage] = useState(1);
  const [totalUser, setTotalUser] = useState(0);

  useEffect(() => {
    const getListFollower = async () => {
      setLoading(true);
      await userFollowApi
        .getFollower({ userId: user.id, page: page, size: 20 })
        .then((result) => {
          setTotalUser(result.metadata.total);
          setListUser(result.data);
        })
        .catch((err) => {});
      setLoading(false);
    };
    getListFollower();
  }, [page, recallApi]);

  return (
    <>
      <div className="container-fluid">
        <h5 className="heading-design-h5">Có {totalUser} người theo dõi bạn!</h5>
        <List
          itemLayout="horizontal"
          dataSource={listUser}
          loading={loading}
          renderItem={(item) => (
            <List.Item>
              <List.Item.Meta
                avatar={<Avatar src={item.followerImage} />}
                title={item.followerName}
              />
            </List.Item>
          )}
        />
        <div className="d-flex justify-content-center" style={{margin: 30}}>
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

export default ListFollower;

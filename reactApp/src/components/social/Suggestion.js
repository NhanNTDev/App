import { List, Avatar, Pagination, Button } from "antd";
import { useEffect, useState } from "react";
import { useSelector } from "react-redux";
import userFollowApi from "../../apis/userFollowApis";

const Suggestion = () => {
  const user = useSelector((state) => state.user);
  const [loading, setLoading] = useState(true);
  const [listUser, setListUser] = useState([]);
  const [page, setPage] = useState(1);
  const [reload, setReload] = useState(true);
  const [totalUser, setTotalUser] = useState(1);

  useEffect(() => {
    const getSuggestion = async () => {
      setLoading(true);
      await userFollowApi
        .getSuggestUser(user.id)
        .then((result) => {
          setTotalUser(result.metadata.total);
          setListUser(result.data);
        })
        .catch((err) => {});
      setLoading(false);
    };
    getSuggestion();
  }, [page, reload]);
  const handleFollowUser = (item) => {
    const follow = async () => {
      setLoading(true);
      await userFollowApi
        .followUser({ customerId: user.id, followingId: item.id })
        .catch(() => {});
      setLoading(false);
      setReload(!reload);
    };
    follow();
  };
  return (
    <>
      <div className="container-fluid">
        <h5 className="heading-design-h5">
          Hãy theo dõi để có thể xem hoạt động của họ!
        </h5>
        <List
          itemLayout="horizontal"
          dataSource={listUser}
          loading={loading}
          renderItem={(item) => (
            <List.Item>
              <List.Item.Meta
                avatar={<Avatar src={item.image} />}
                title={item.name}
              />
              <Button onClick={() => handleFollowUser(item)}>
                <li className="mdi mdi-account-plus" />
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

export default Suggestion;

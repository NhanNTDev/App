import { Tabs } from 'antd';
import ListFollower from './ListFollower';
import ListFollowing from './ListFollowing';
import Suggestion from "./Suggestion";
const { TabPane } = Tabs;

const Follow = () => {
  return (
    <>
      <div className="container-fluid">
        <Tabs>
            <TabPane tab="Người theo dõi" key="1">
                <ListFollower/>
            </TabPane>
            <TabPane tab="Đang theo dõi" key="2">
                <ListFollowing/>
            </TabPane>
            <TabPane tab="Gợi ý" key="3">
                <Suggestion/>
            </TabPane>
        </Tabs>
      </div>
    </>
  );
};

export default Follow;

import { Tabs } from 'antd';
import { useState } from 'react';
import ListFollower from './ListFollower';
import ListFollowing from './ListFollowing';
import Suggestion from "./Suggestion";
const { TabPane } = Tabs;

const Follow = () => {
  const [recallApi, setRecallApi] = useState(true);
  return (
    <>
      <div className="container-fluid">
        <Tabs onTabClick={()=>{ setRecallApi(!recallApi);

        }}>
            <TabPane tab="Người theo dõi" key="1">
                <ListFollower recallApi={recallApi}/>
            </TabPane>
            <TabPane tab="Đang theo dõi" key="2">
                <ListFollowing recallApi={recallApi}/>
            </TabPane>
            <TabPane tab="Gợi ý" key="3">
                <Suggestion recallApi={recallApi}/>
            </TabPane>
        </Tabs>
      </div>
    </>
  );
};

export default Follow;

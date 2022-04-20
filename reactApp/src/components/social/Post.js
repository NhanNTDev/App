import { Tag } from "antd";
import { Link } from "react-router-dom";
import { parseTimeHMDMY } from "../../utils/Common";

const Post = ({ post }) => {
  let campaignEnd = post.campaignStatus === "Đã kết thúc" ? true : false;
  return (
    <>
      <div
        className="container-fluid"
        style={{ borderBottom: "solid 1px", marginTop: 50 }}
      >
        <div className="row">
          <h4
            className="heading-design-h4"
            style={{ color: "orange", marginLeft: 30 }}
          >
            <span style={{color: "black"}}>Nguyễn Thành Nhân</span> đã mua hàng!
            {campaignEnd && <Tag color="red">Chiến dịch đã kết thúc</Tag>}
          </h4>
          <br />
        </div>
        <div className="row">
          <div className="col-sm-5">
            <Link
              to={
                campaignEnd
                  ? "#"
                  : `/products/${post.campaignId}/${post.productHarvestInCampaignId}`
              }
            >
              <img
                src={post.productImage}
                style={{
                  borderRadius: 30,
                  objectFit: "contain",
                  backgroundSize: "cover",
                  width: "100%",
                }}
              ></img>
            </Link>
          </div>
          <div className="col-sm-7" style={{ marginBottom: 30, marginTop: 50 }}>
            <h4 className="heading-design-h4">
            Nguyễn Thành Nhân{post.customerName} đã mua{" "}
              <Link
                to={
                  campaignEnd
                    ? "#"
                    : `/products/${post.campaignId}/${post.productHarvestInCampaignId}`
                }
              >
                {post.productName}
              </Link>{" "}
              của {post.farmName} tại chiến dịch{" "}
              <Link to={campaignEnd ? "#" : `/campaign/${post.campaignId}`}>
                {post.campaignName}
              </Link>{" "}
              lúc {parseTimeHMDMY(post.createAt)}
            </h4>
          </div>
        </div>
      </div>
    </>
  );
};

export default Post;

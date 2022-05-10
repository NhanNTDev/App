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
            <span style={{ color: "black" }}>{post.customerName}</span> đã mua
            hàng!
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
              {post.customerName} <span style={{fontWeight: 300}}>đã mua{" "}</span>
              <Link
                to={
                  campaignEnd
                    ? "#"
                    : `/products/${post.campaignId}/${post.productHarvestInCampaignId}`
                }
              >
                {post.productName}
              </Link>{" "}
              <span style={{fontWeight: 300}}>của </span>{post.farmName}<span style={{fontWeight: 300}}> tại chiến dịch{" "}</span>
              <Link to={campaignEnd ? "#" : `/campaign/${post.campaignId}`}>
                {post.campaignName}
              </Link>{" "}
              <span style={{fontWeight: 300}}>lúc </span>{parseTimeHMDMY(post.createAt)}
            </h4>
          </div>
        </div>
      </div>
    </>
  );
};

export default Post;

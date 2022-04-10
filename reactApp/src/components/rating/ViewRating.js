import { Button, Rate } from "antd";
import Modal from "antd/lib/modal/Modal";
import { useState } from "react";

const ViewRating = (props) => {
  const [isModalVisible, setIsModalVisible] = useState(false);
  const [star, setStar] = useState(props.star);
  const [content, setContent] = useState(props.content);

  const showModal = () => {
    setIsModalVisible(true);
  };

  const handleOk = () => {
    setIsModalVisible(false);
  };

  const handleCancel = () => {
    setIsModalVisible(false);
  };
  return (
    <>
      <Button
        onClick={showModal}
        type="default"
        style={{ backgroundColor: "orange" }}
      >
        Xem đánh giá
      </Button>
      <Modal
        centered
        title="Đánh giá đơn hàng"
        visible={isModalVisible}
        onOk={handleOk}
        onCancel={handleCancel}
        cancelText="Thoát"
        okText="OK"
      >
        <div className="row">
          <div className="col-sm-12">
            <div className="form-group d-flex justify-content-center">
              <Rate value={star} disabled={true} />
            </div>
          </div>
        </div>
        <div className="row">
          <div className="col-sm-12">
            <div className="form-group d-flex justify-content-center">
              <h5>{content}</h5>
            </div>
          </div>
        </div>
      </Modal>
    </>
  );
};

export default ViewRating;

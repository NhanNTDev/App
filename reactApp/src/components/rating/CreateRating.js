import { Button, notification, Rate } from "antd";
import Modal from "antd/lib/modal/Modal";
import { useState } from "react";
import orderApi from "../../apis/orderApi";

const CreateRating = ({ orderId, callback }) => {
  const [isModalVisible, setIsModalVisible] = useState(false);
  const [star, setStar] = useState(5);
  const [content, setContent] = useState("");

  const showModal = () => {
    setIsModalVisible(true);
  };

  const handleOk = () => {
    const params = {
      id: orderId,
      star: star,
      content: content,
    };
    const sentFeedback = async () => {
      await orderApi
        .feedback(params)
        .then((result) => {
          notification.success({
            duration: 2,
            message: "Gửi đánh giá thành công!",
            style: { fontSize: 16 },
          });
          callback();
          setIsModalVisible(false);
        })
        .catch((err) => {
          notification.error({
            duration: 2,
            message: "Gửi đánh giá không thành công!",
            style: { fontSize: 16 },
          });
        });
    };
    sentFeedback();
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
        Đánh giá
      </Button>
      <Modal
        centered
        title="Đánh giá đơn hàng"
        visible={isModalVisible}
        onOk={handleOk}
        onCancel={handleCancel}
        cancelText="Hủy"
        okText="Gửi đánh giá"
      >
        <div className="row">
          <div className="col-sm-12">
            <div className="form-group d-flex justify-content-center">
              <Rate
                value={star}
                onChange={(value) => {
                  if (value === undefined || value === 0) {
                    setStar(1);
                  } else {
                    setStar(value);
                  }
                }}
              />
            </div>
          </div>
        </div>
        <div className="row">
          <div className="col-sm-12">
            <div className="form-group">
              <label className="control-label">Nội dung đánh giá</label>
              <input
                className="form-control border-form-control"
                value={content}
                placeholder="Nhập nội dung đánh giá"
                onChange={(e) => {
                  setContent(e.target.value);
                }}
              />
            </div>
          </div>
        </div>
      </Modal>
    </>
  );
};

export default CreateRating;

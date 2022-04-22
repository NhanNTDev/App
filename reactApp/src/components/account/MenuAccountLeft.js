import { useDispatch, useSelector } from "react-redux";
import { Link } from "react-router-dom";
import { Button, notification, Upload } from "antd";
import ImgCrop from "antd-img-crop";
import { useState } from "react";
import { UploadOutlined } from "@ant-design/icons";
import userApi from "../../apis/userApi";
import { storage } from "../../firebase/firebase";
import { getDownloadURL, ref, uploadBytesResumable } from "firebase/storage";
import { updateUser } from "../../state_manager_redux/user/userSlice";

const MenuAccountLeft = ({ type }) => {
  const user = useSelector((state) => state.user);
  const [file, setFile] = useState("");
  const [image, setImage] = useState(user.image);
  const dispath = useDispatch();

  const upLoadImage = async (imageAsFile) => {
    let firebareUrl;
    try {
      const storageRef = ref(storage, `/Images/User/${imageAsFile.name}`);
      const upload = await uploadBytesResumable(storageRef, imageAsFile);
      if (upload !== undefined) {
        const url = await getDownloadURL(storageRef);
        firebareUrl = url;
      }
    } catch (error) {
      console.log(error);
    }
    return firebareUrl;
  };

  const handleChangeAvatar = () => {
    const changeAvatar = async () => {
      const imageUrl = await upLoadImage(file.originFileObj);
      const params = {
        id: user.id,
        image: imageUrl,
      };
      console.log(params);
      await userApi
        .changeAvatar(params)
        .then(() => {
          setFile("");
          notification.success({
            duration: 3,
            message: "Đổi ảnh đại diện thành công",
            style: { fontSize: 16 },
          });
          const updateData = {
            image: imageUrl,
          };
          const updateUserAction = updateUser(updateData);
          dispath(updateUserAction);
        })
        .catch(() => {
          notification.error({
            duration: 3,
            message: "Có lỗi xảy ra trong quá trình xử lý",
            style: { fontSize: 16 },
          });
        });
    };

    changeAvatar();
  };
  const onChange = async ({ file: newFile }) => {
    let src = newFile.url;
    if (!src) {
      src = await new Promise((resolve) => {
        const reader = new FileReader();
        reader.readAsDataURL(newFile.originFileObj);
        reader.onload = () => resolve(reader.result);
      });
    }

    const image = new Image();
    image.src = src;
    setFile(newFile);
    setImage(image.src);
  };

  const onPreview = async (file) => {
    let src = file.url;
    if (!src) {
      src = await new Promise((resolve) => {
        const reader = new FileReader();
        reader.readAsDataURL(file.originFileObj);
        reader.onload = () => resolve(reader.result);
      });
    }
    const image = new Image();
    image.src = src;
    setImage(image.src);
    const imgWindow = window.open(src);
    imgWindow.document.write(image.outerHTML);
  };
  return (
    <div className="card account-left">
      <div className="user-profile-header">
        <img src={image !== "" ? image : "/img/user/user.jpg"} />
        <br />
        <ImgCrop rotate modalTitle="Chỉnh ảnh" modalOk="Chọn" modalCancel="Hủy">
          <Upload
            action="https://www.mocky.io/v2/5cc8019d300000980a055e76"
            onChange={onChange}
            onPreview={onPreview}
            maxCount={1}
            showUploadList={false}
          >
            <Button icon={<UploadOutlined />}>Đổi ảnh</Button>
          </Upload>
        </ImgCrop>
        {file !== "" && (
          <Button onClick={() => handleChangeAvatar()}>Lưu</Button>
        )}
        <h5 className="mb-1 text-secondary">
          <strong></strong> {user.name}
        </h5>
        <p>{user.phoneNumber}</p>
      </div>
      <div className="list-group">
        <Link
          to="/account"
          className={
            type === "account"
              ? "list-group-item list-group-item-action active"
              : "list-group-item list-group-item-action"
          }
        >
          <i aria-hidden="true" className="mdi mdi-account-outline"></i> Thông
          Tin Của Tôi
        </Link>
        <Link
          to="/address"
          className={
            type === "address"
              ? "list-group-item list-group-item-action active"
              : "list-group-item list-group-item-action"
          }
        >
          <i aria-hidden="true" className="mdi mdi-map-marker-circle"></i> Địa
          Chỉ Giao Hàng
        </Link>
        <Link
          to="/orderlist"
          className={
            type === "orderList"
              ? "list-group-item list-group-item-action active"
              : "list-group-item list-group-item-action"
          }
        >
          <i aria-hidden="true" className="mdi mdi-format-list-bulleted"></i>{" "}
          Lịch Sử Đặt Hàng
        </Link>
        <Link
          to="/changePassword"
          className={
            type === "changePassword"
              ? "list-group-item list-group-item-action active"
              : "list-group-item list-group-item-action"
          }
        >
          <i aria-hidden="true" className="mdi mdi-lock"></i> Đổi mật khẩu
        </Link>
      </div>
    </div>
  );
};

export default MenuAccountLeft;

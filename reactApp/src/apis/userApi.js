import axiosClient from "./axiosClient";

const userApi = {
  login(data) {
    const url = `/users/login`;
    return axiosClient.post(url, data);
  },
  update(data) {
    const url = `/users/update/customer/${data.id}`;
    return axiosClient.put(url, data);
  },
  register(data) {
    const url = `/users`;
    return axiosClient.post(url, data);
  },
  checkDuplicate(usename) {
    const url = `/users/check-duplicate?username=${usename}`;
    return axiosClient.put(url);
  },
  changePassword(data) {
    const url = `/users/change-password`;
    return axiosClient.put(url, data);
  },
  changeAvatar(params) {
    const url = `/users/change-image-customer/${params.id}`;
    return axiosClient.put(url, params);
  },
  loginByCode(code) {
      const url =`/webhooks/login/zalo?code=${code}`;
      console.log(url);
      return axiosClient.post(url);
  }
};

export default userApi;

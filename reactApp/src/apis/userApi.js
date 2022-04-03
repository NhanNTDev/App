import axiosClient from "./axiosClient";

const userApi = {
  login(data) {
    const url = `/users/login`;
    return axiosClient.post(url, data);
  },
  update(data) {
    const url = `/users/update-user/${data.id}`;
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
  }
};

export default userApi;

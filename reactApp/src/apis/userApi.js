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
  }
};

export default userApi;

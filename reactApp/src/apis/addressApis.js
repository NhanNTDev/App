import axiosClient from "./axiosClient";

const addressApi = {
  getAll(id) {
    const url = `/addresss?customer-id=${id}`;
    return axiosClient.get(url);
  },
  create(data) {
    const url = `/addresss`;
    return axiosClient.post(url, data);
  },
  update(data) {
    const url = `/addresss/${data.id}`;
    return axiosClient.put(url, data);
  },
  delete(id) {
    const url = `/addresss/${id}`;
    return axiosClient.delete(url);
  },
};

export default addressApi;

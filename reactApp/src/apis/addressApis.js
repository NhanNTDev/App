import axiosClient from "./axiosClient";

const addressApi = {
    getAll(id) {
            const url = `/addresss?customer-id=${id}`;
            return axiosClient.get(url);
    },
};

export default addressApi;
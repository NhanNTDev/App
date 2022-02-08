import axiosClient from "./axiosClient";

const orderApi = {
    post(param) {
        const url = '/orders';
        return axiosClient.post(url, param);
    }
}

export default orderApi;
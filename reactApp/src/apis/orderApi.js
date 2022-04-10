import axiosClient from "./axiosClient";

const orderApi = {
    post(param) {
        const url = '/orders';
        return axiosClient.post(url, param);
    },
    getOrderList(userId) {
        const url = `/orders/customer/${userId}`;
        return axiosClient.get(url);
    },
    cancelOrder(params) {
        const url = `/orders/${params.orderId}?note=${params.note}`;
        return axiosClient.delete(url);
    }, 
    getOrderDetails(id) {
        const url = `/orders/${id}`;
        return axiosClient.get(url);
    },
    feedback(params) {
        const url = `/orders/feedback/${params.id}`;
        return axiosClient.put(url, params);
    }

}

export default orderApi;
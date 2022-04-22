import { getShipcost } from "../state_manager_redux/cart/cartSelector";
import axiosClient from "./axiosClient";

const orderApi = {
    post(param) {
        const url = '/orders';
        return axiosClient.post(url, param);
    },
    getOrderList(params) {
        const url = `/orders/customer/${params.userId}?page=${params.page}`;
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
    },
    getShipcost(params) {
        const url = `/orders/ship-cost?product-cost=${params.cost}&address=${params.address}&campaign-id=${params.campaignId}`;
        return axiosClient.get(url);
    }

}

export default orderApi;
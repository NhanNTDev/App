import axiosClient from "./axiosClient";

const cartApi = {
    getAll(id) {
        const url = `/item-carts/${id}`;
        return axiosClient.get(url);
    },
    addNew(data) {
        const url = '/item-carts';
        return axiosClient.post(url, data);
    },
    update(data) {
        const url = `/item-carts/${data.customerId}/${data.harvestCampaignId}?quantity=${data.quantity}`;
        return axiosClient.put(url);
    },
    delete(data) {
        const url = `/item-carts/${data.customerId}/${data.harvestCampaignId}`;
        return axiosClient.delete(url);
    }
}

export default cartApi;
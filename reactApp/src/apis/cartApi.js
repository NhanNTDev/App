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
        const url = `/item-carts/${data.id}`;
        return axiosClient.put(url, data);
    },
    delete(data) {
        const url = `/item-carts/${data.id}`;
        return axiosClient.delete(url, data);
    }
}

export default cartApi;
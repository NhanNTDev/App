import axiosClient from "./axiosClient";

const cartApi = {
    getAll(id) {
        const url = '/item-carts';
        return axiosClient.get(url, id);
    },
    addNew(data) {
        const url = '/item-carts';
        return axiosClient.post(url, data);
    },
    update(data) {
        const url = `/item-carts/${data.id}`;
        return axiosClient.put(url, data);
    }
}

export default cartApi;
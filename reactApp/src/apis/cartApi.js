import axiosClient from "./axiosClient";

const cartApi = {
    getAll() {
        const url = '/item-carts';
        return axiosClient.get(url);
    }
}

export default cartApi;
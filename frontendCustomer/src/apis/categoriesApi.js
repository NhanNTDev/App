import axiosClient from "./axiosClient";

const categoriesApi = {
    getAll() {
        const url = '/product-categories';
        return axiosClient.get(url);
    }
}

export default categoriesApi;
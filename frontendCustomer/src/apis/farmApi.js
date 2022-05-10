import axiosClient from "./axiosClient";

const farmApi = {
    getAll(params) {
        const url = '/farms';
        return axiosClient.get(url, {params});
    },
    get(id) {
        const url = `/farms/${id}`;
        return axiosClient.get(url);
    }
}

export default farmApi;
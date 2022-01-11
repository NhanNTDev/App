import axiosClient from "./axiosClient";

const farmApi = {
    getAll(params) {
        const url = '/farms';
        return axiosClient.get(url, {params});
    }
}

export default farmApi;
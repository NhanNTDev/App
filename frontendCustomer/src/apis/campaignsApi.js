import axiosClient from "./axiosClient";

const campaignsApi = {
    get(id) {
        const url = `/campaigns/${id}`;
        return axiosClient.get(url);
    },
    getAll(params) {
        const url = '/campaigns';
        return axiosClient.get(url, {params});
    },
}

export default campaignsApi;
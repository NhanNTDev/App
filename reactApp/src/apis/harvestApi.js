import axiosClient from "./axiosClient";

const harvestApi = {
    getAll(params) {
        const url = '/harvest-campaigns';
        return axiosClient.get(url, {params});
    },
    get(id) {
        const url = `/harvest-campaigns/${id}`;
        return axiosClient.get(url); 
    }
}

export default harvestApi;
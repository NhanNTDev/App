import axiosClient from "./axiosClient";

const harvestApi = {
    getAll(params) {
        const url = '/harvest-campaigns';
        return axiosClient.get(url, {params});
    }
}

export default harvestApi;
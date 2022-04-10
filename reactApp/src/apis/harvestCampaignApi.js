import axiosClient from "./axiosClient";

const harvestCampaignApi = {
    getAll(params) {
        const url = '/product-harvest-in-campaigns';
        return axiosClient.get(url, {params});
    },
    get(id) {
        const url = `/product-harvest-in-campaigns/${id}`;
        return axiosClient.get(url); 
    }
}

export default harvestCampaignApi;
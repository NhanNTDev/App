import axiosClient from "./axiosClient";

const harvestCampaignApi = {
    getAll(params) {
        const url = '/product-harvest-in-campaigns';
        return axiosClient.get(url, {params});
    },
    get(id) {
        const url = `/product-harvest-in-campaigns/${id}`;
        return axiosClient.get(url); 
    },
    getOrigin(id) {
        const url = `/product-harvest-in-campaigns/origin/${id}`;
        return axiosClient.get(url);
    },
    getSearchOption(zoneId) {
        const url = `/product-harvest-in-campaigns/search/${zoneId}`;
        return axiosClient.get(url);
    }
}

export default harvestCampaignApi;
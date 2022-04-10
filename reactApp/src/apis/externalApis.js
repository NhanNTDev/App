import axiosClient from "./axiosClient";

const externalApi = {
    getZone(address) {
        const url = `/externals/zone?address=${address}`;
        return axiosClient.get(url);
    },
    

}

export default externalApi;
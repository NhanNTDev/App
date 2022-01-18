import axiosClient from "./axiosClient";

const userApi = {
    login(data) {
        const url = `/Users/login`;
        return axiosClient.post(url, data);
    }, 
}


export default userApi;
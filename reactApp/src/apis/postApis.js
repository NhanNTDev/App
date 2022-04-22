import axiosClient from "./axiosClient";


const postApi = {
    getPost(params) {
        const url = `/posts?customer-id=${params.userId}&page=${params.page}`;
        return axiosClient.get(url);
    }
}

export default postApi;
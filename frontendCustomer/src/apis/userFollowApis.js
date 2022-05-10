import axiosClient from "./axiosClient";

const userFollowApi = {
    getSuggestUser(userId) {
        const url = `/user-follows?customer-id=${userId}`;
        return axiosClient.get(url);
    },
    getFollower(params) {
        const url = `/user-follows/follower/${params.userId}?page=${params.page}&size=${params.size}`;
        return axiosClient.get(url);
    },
    getFollowing(params) {
        const url = `/user-follows/following/${params.userId}?page=${params.page}&size=${params.size}`;
        return axiosClient.get(url);
    },
    followUser(data) {
        const url = `/user-follows?customer-id=${data.customerId}&following-id=${data.followingId}`;
        return axiosClient.post(url);
    },
    unfollowUser(data) {
        const url = `/user-follows?customer-id=${data.customerId}&following-id=${data.followingId}`;
        return axiosClient.delete(url);
    }
}

export default userFollowApi;
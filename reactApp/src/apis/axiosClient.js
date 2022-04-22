import axios from "axios";
import queryString from "query-string";
axios.defaults.timeout = 600000;
axios.defaults.timeoutErrorMessage = "timeout";

const axiosClient = axios.create({
  baseURL: process.env.REACT_APP_API_BASEURL,
  headers: {
    "content-type": "application/json",
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS",
  },
  paramsSerializer: (params) => queryString.stringify(params),
});

axiosClient.interceptors.request.use(async (config) => {
  //Handle token.....
  return config;
});

axiosClient.interceptors.response.use(
  (response) => {
    if (response && response.data) {
      return response.data;
    }
    return response;
  },
  (error) => {
    //Hanle error
    throw error;
  }
);

export default axiosClient;

import axios from "axios";
import queryString from "query-string";
axios.defaults.timeout = 15000;
axios.defaults.timeoutErrorMessage='timeout';

const axiosClient = axios.create({
  baseURL: process.env.REACT_APP_API_BASEURL,
  headers: {
    Accept: "application/json, text/plain, multipart/form-data, */*",
    "content-type": "application/json, multipart/form-data",
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS",
    // "timeout": 1000,
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

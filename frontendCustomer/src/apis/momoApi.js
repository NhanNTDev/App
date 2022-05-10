import axiosClient from "./axiosClient";

const momoApi = {
    checkoutMomo(CheckoutUrl) {
        const url = '/momos';
        console.log(CheckoutUrl);
        return axiosClient.post(url,{url: CheckoutUrl});
    },
  
}

export default momoApi;
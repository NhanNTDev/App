import axios from "axios";

export const getCampaigns = async () => {
  let result;
  await axios({
    method: "GET",
    url: "http://localhost:3000/weeklyCampaign",
    data: null,
  })
    .then((res) => {
      result = res.data;
    })
    .catch((err) => {
      console.log(err);
    });
  return result;
};
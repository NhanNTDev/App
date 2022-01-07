import axios from "axios";

export const getAllFarms = async () => {
  let result;
  await axios({
    method: "GET",
    url: "http://localhost:3000/farms",
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

import axios from "axios";

export const getAllCategoriesAPI = async () => {
  let result;
  await axios({
    method: "GET",
    url: "http://localhost:3000/categories",
    data: null,
  })
    .then((res) => {
      console.log(res);
      result = res.data;
    })
    .catch((err) => {
      console.log(err);
    });
  return result;
};

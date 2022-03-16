import { message } from "antd";
import userApi from "../../apis/userApi";

const { createSlice, createAsyncThunk, current } = require("@reduxjs/toolkit");

// export const updateUserThunk = createAsyncThunk(
//   "user/updateUserThunk",
//   async (data, setLoading) => {
//     console.log("aaa")
//     setLoading(true);
//     const result = await userApi.update(data).catch((err) => {console.log(err)});
//     setLoading(false);
//     if (result) {
//       message.success({
//         duration: 2,
//         content: "Cập nhật thành công!",
//       });
//       return data;
//     } else {
//       message.error({
//         duration: 2,
//         content: "Cập nhật thất bại!",
//       });
//     }
//     return null;
//   }
// );
const userSlice = createSlice({
  name: "user",
  initialState: JSON.parse(localStorage.getItem("dichonao_user")),
  reducers: {
    setUser(state, action) {
      localStorage.setItem(
        "dichonao_user",
        JSON.stringify({ ...action.payload.user })
      );
      localStorage.setItem("dichonao_user_token", action.payload.token);
      return action.payload.user;
    },
    logout() {
      localStorage.removeItem("dichonao_user");
      localStorage.removeItem("dichonao_user_token");
      localStorage.removeItem("dichonao_cart");
      return null;
    },
    updateUser(state, action) {
      let currentState = current(state);
      localStorage.setItem(
        "dichonao_user",
        JSON.stringify({...currentState, ...action.payload})
      );
      return {...currentState, ...action.payload};
    }
  },
  // extraReducers: (builder) => {
  //   builder.addCase(updateUserThunk.fulfilled, (state, action) => {
  //     const currenState = current(state);
  //     if (action.payload !== null) {
  //       localStorage.setItem(
  //         "dichonao_user",
  //         JSON.stringify({
  //           ...currenState,
  //           ...action.payload
  //         })
  //       );
  //     }

  //     return action.payload !== null
  //       ? {
  //           ...currenState,
  //           ...action.payload
  //         }
  //       : currenState;
  //   });
  // },
});

const { actions, reducer } = userSlice;
export const { setUser, logout, updateUser } = actions;
export default reducer;

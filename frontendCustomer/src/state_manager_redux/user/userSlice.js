
const { createSlice, current } = require("@reduxjs/toolkit");

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

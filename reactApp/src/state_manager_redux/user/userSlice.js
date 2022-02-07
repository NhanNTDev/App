const { createSlice } = require("@reduxjs/toolkit");

const userSlice = createSlice({
  name: "user",
  initialState: JSON.parse(localStorage.getItem("dichonao_user")),
  reducers: {
    setUser(state, action) {
      localStorage.setItem("dichonao_user", JSON.stringify({...action.payload.user}));
      localStorage.setItem("dichonao_user_token", action.payload.token);
      return action.payload.user;
    },
    logout() {
      localStorage.removeItem("dichonao_user");
      localStorage.removeItem("dichonao_user_token");
      return null;
    }
  },
});

const { actions, reducer } = userSlice;
export const { setUser, logout } = actions;
export default reducer;

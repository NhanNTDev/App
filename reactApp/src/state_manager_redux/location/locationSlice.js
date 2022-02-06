const { createSlice } = require("@reduxjs/toolkit");

const locationSlice = createSlice({
  name: "location",
  initialState: localStorage.getItem("dichonao_user_location"),
  reducers: {
    setLocation(state, action) {
      localStorage.setItem("dichonao_user_location", action.payload.location);
      return action.payload.location;
    },
  },
});

const { actions, reducer } = locationSlice;
export const { setLocation } = actions;
export default reducer;

const { createSlice } = require("@reduxjs/toolkit");

const zoneSlice = createSlice({
  name: "zone",
  initialState: localStorage.getItem("dichonao_user_zone"),
  reducers: {
    setZone(state, action) {
      localStorage.setItem("dichonao_user_zone", action.payload.zoneId);
      return action.payload.zoneId;
    },
  },
});

const { actions, reducer } = zoneSlice;
export const { setZone } = actions;
export default reducer;

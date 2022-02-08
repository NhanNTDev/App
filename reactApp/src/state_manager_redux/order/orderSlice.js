/* eslint-disable array-callback-return */
const { createSlice } = require("@reduxjs/toolkit");

const orderSlice = createSlice({
  name: "order",
  initialState: JSON.parse(localStorage.getItem("dichonao_order")),
  reducers: {
    setOrder(state, action) {
      console.log("order");
      let listFarms = [];
      let farmOrders = [];
      console.log(action.payload.cart);
      Object.values(action.payload.cart).map((campaign) => {
        var result = campaign.harvestCampaigns.reduce(function (r, a) {
          r[a.harvest.farmId] = r[a.harvest.farmId] || [];
          r[a.harvest.farmId].push(a);
          return r;
        }, Object.create(null));
        listFarms = Object.entries(result);
      });
      listFarms.map((farm) => {
        let listItem = [];
        farm[1].map((item) => {
          listItem.push({
            productName: item.productName,
            unit: item.unit,
            quantity: item.itemCarts[0].quantity,
            price: item.price,
            harvestCampaignId: item.harvestId,
          });
        });
        farmOrders.push({
          farmId: farm[1][0].harvest.farmId,
          harvestOrders: listItem,
        });
      });
      localStorage.setItem("dichonao_order", JSON.stringify({...farmOrders}));
      return farmOrders;
    },
  },
});

const { actions, reducer } = orderSlice;
export const { setOrder } = actions;
export default reducer;

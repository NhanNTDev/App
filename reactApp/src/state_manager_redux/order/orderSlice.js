const { createSlice } = require("@reduxjs/toolkit");

const orderSlice = createSlice({
  name: "order",
  initialState: JSON.parse(localStorage.getItem("dichonao_order")),
  reducers: {
    setOrder(state, action) {
      console.log("order");
      let listFarms = [];
      let farmOrders = [];
      let listCampaigns = [];
      Object.values(action.payload.cart).map((campaign) => {
        farmOrders = [];
        let campaignValue = Object.values(campaign);
        var result = campaign.harvestCampaigns.reduce(function (r, a) {
          r[a.harvest.farmId] = r[a.harvest.farmId] || [];
          r[a.harvest.farmId].push(a);
          return r;
        }, Object.create(null));
        listFarms = Object.entries(result);
        listFarms.map((farm) => {         
          let listItem = [];
          farm[1].map((item) => {
            listItem.push({
              itemCartId: item.itemCarts[0].id,
            });
          });
          farmOrders.push({
            farmId: farm[1][0].harvest.farmId,
            harvestOrders: listItem,
          });
        });
        listCampaigns.push({
          campaignId: campaignValue[0],
          farmOrders: farmOrders,
        });
      });
      localStorage.setItem("dichonao_order", JSON.stringify({ ...farmOrders }));
      return farmOrders;
    },
  },
});

const { actions, reducer } = orderSlice;
export const { setOrder } = actions;
export default reducer;

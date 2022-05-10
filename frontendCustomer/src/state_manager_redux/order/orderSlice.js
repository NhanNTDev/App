const { createSlice, current } = require("@reduxjs/toolkit");

const orderSlice = createSlice({
  name: "order",
  initialState: JSON.parse(localStorage.getItem("dichonao_order")),
  reducers: {
    //set value for order
    setOrder(state, action) {
      let listFarmOrders = [];
      let listHarvestOrder = [];
      const cart = action.payload.cart;
      cart.farms.map(farm => {
        farm.harvestInCampaigns.map(harvestCampaign => {
          if(harvestCampaign.checked) {
            listHarvestOrder.push({harvestCampaignId: harvestCampaign.id})
          }
        })
        if(Object.values(listHarvestOrder).length > 0) {
          listFarmOrders.push({farmId: farm.id, productHarvestOrders: listHarvestOrder});
          listHarvestOrder = [];
        }
      })

      //Set new State
      localStorage.setItem(
        "dichonao_order",
        JSON.stringify({ ...listFarmOrders })
      );
      return listFarmOrders;
    },
  },
});

const { actions, reducer } = orderSlice;
export const { setOrder, setTotal } = actions;
export default reducer;

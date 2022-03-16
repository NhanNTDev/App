const { createSlice } = require("@reduxjs/toolkit");

const orderSlice = createSlice({
  name: "order",
  initialState: JSON.parse(localStorage.getItem("dichonao_order")),
  reducers: {
    //set value for order
    setOrder(state, action) {
      let listFarmIds = [];
      let listFarmOrders = [];
      let listHarvestCampaignOrder = [];
      let listCampaignIds = [];
      let listCampaignOrder = [];
      //Get list harvestCampaignId checked
      Object.values(action.payload.cart).map((campaign) => {
        campaign.harvestCampaigns.map((harvestCampaign) => {
          if (harvestCampaign.checked) {
            listHarvestCampaignOrder.push(harvestCampaign);
          }
        });
      });
      //Get listCampaignId and listFarmId
      listHarvestCampaignOrder.map((harvestCampaign) => {
        if (!listCampaignIds.includes(harvestCampaign.campaignId)) {
          listCampaignIds.push(harvestCampaign.campaignId);
        }
        if (!listFarmIds.includes(harvestCampaign.harvest.farmId)) {
          listFarmIds.push(harvestCampaign.harvest.farmId);
        }
      });
      //Format json for server
      listCampaignIds.map((campaignId) => {
        listFarmIds.map((farmId) => {
          let listHarvest = [];
          listHarvestCampaignOrder.map((harvestCampaignOrder) => {
            if (harvestCampaignOrder.campaignId === campaignId) {
              if (harvestCampaignOrder.harvest.farmId === farmId) {
                listHarvest.push({
                  itemCartId: harvestCampaignOrder.itemCarts[0].id,
                });
              }
            }
          });
          if (Object.entries(listHarvest).length > 0)
            listFarmOrders.push({ farmId: farmId, harvestOrders: listHarvest });
          listHarvest = [];
        });
        listCampaignOrder.push({
          campaignId: campaignId,
          farmOrders: listFarmOrders,
        });
        listFarmOrders = [];
      });

      //Set new State
      localStorage.setItem(
        "dichonao_order",
        JSON.stringify({ ...listCampaignOrder })
      );
      return listCampaignOrder;
    },
  },
});

const { actions, reducer } = orderSlice;
export const { setOrder, setTotal } = actions;
export default reducer;

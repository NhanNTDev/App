const { createSlice, current } = require("@reduxjs/toolkit");

const cartSlice = createSlice({
  name: "cart",
  initialState: JSON.parse(localStorage.getItem("dichonao_cart")),
  reducers: {
    //set value for cart state
    setCart(state, action) {
      if (action.payload.length === 0) {
        if (localStorage) {
          localStorage.setItem("dichonao_cart", null);
        }
        return null;
      }
      if (localStorage) {
        localStorage.setItem(
          "dichonao_cart",
          JSON.stringify({ ...action.payload })
        );
      }
      return action.payload;
    },
    //setQuantity for cart item
    setQuantity(state, action) {
      let newState = current(state);
      let listCampaigns = [];

      Object.values(newState).map((campaign) => {
        if (campaign.id === action.payload.campaignId) {
          let listHavestInCampaigns = [];
          campaign.harvestCampaigns.map((harvestCampaign) => {
            if (harvestCampaign.id === action.payload.productId) {
              let listItemCarts = [];
              listItemCarts.push({
                ...harvestCampaign.itemCarts[0],
                quantity: action.payload.newQuantity,
              });
              listHavestInCampaigns.push({
                ...harvestCampaign,
                itemCarts: listItemCarts,
              });
            } else {
              listHavestInCampaigns.push(harvestCampaign);
            }
          });
          campaign = { ...campaign, harvestCampaigns: listHavestInCampaigns };
          listCampaigns.push(campaign);
        } else {
          listCampaigns.push(campaign);
        }
      });
      newState = { ...listCampaigns };
      localStorage.setItem("dichonao_cart", JSON.stringify({ ...newState }));
      return newState;
    },
    //add item to cart
    addToCart(state, action) {
      console.log("add to cart");
    },
    //remove item from cart
    removeFromCart(state, action) {
      let newState = current(state);
      let listValues = [];
      Object.values(newState).map((campaign) => {
        if (campaign.id === action.payload.campaignId) {
          let newHarvestCampaigns = campaign.harvestCampaigns.filter(
            (x) => x.id !== action.payload.productId
          );
          campaign = { ...campaign, harvestCampaigns: newHarvestCampaigns };
          if (campaign.harvestCampaigns.length > 0) {
            listValues.push(campaign);
          }
        } else {
          listValues.push(campaign);
        }
      });
      newState = { ...listValues };

      if (Object.entries(newState).length === 0) {
        newState = null;
      }
      localStorage.setItem("dichonao_cart", JSON.stringify({ ...newState }));
      return newState;
    },
    //clear cart
    clearCart(state) {
      return null;
    },
  },
});

const { actions, reducer } = cartSlice;
export const { setCart, setQuantity, addToCart, removeFromCart, clearCart } =
  actions;
export default reducer;

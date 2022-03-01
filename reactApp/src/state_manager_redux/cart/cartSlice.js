import { message } from "antd";
import cartApi from "../../apis/cartApi";
const { createSlice, current, createAsyncThunk } = require("@reduxjs/toolkit");
export const addToCartThunk = createAsyncThunk(
  "cart/addToCartThunk",
  async (data) => {
    let errorMessage = "";
    const params = {
      quantity: data.quantity,
      harvestCampaignId: data.productId,
      customerId: data.customerId,
    };
    console.log(params);
    let cartResponse;
    await cartApi.addNew(params).catch((err) => {
      errorMessage = err.response.data.error.message;
      console.log(errorMessage);
    });

    cartResponse = await cartApi.getAll(
      JSON.parse(localStorage.getItem("dichonao_user")).id
    );
    localStorage.setItem("dichonao_cart", JSON.stringify({ ...cartResponse }));
    if (errorMessage === "") {
      message.success({
        duration: 2,
        content: "Sản phẩm đã được thêm vào giỏ hàng!",
      });
    } else {
      message.error({
        duration: 2,
        content: "Sản phẩm đã hết hàng!",
      });
    }

    return cartResponse;
  }
);
const cartSlice = createSlice({
  name: "cart",
  initialState:
    localStorage.getItem("dichonao_cart") === null
      ? null
      : Object.keys(JSON.parse(localStorage.getItem("dichonao_cart")))
          .length === 0
      ? null
      : JSON.parse(localStorage.getItem("dichonao_cart")),
  reducers: {
    //set value for cart state
    setCart(state, action) {
      let listCampaigns = [];
      let listHarvestInCampaigns = [];
      let listCart = action.payload;
      listCart.map((campaign) => {
        campaign.harvestCampaigns.map((harvestCampaign) => {
          listHarvestInCampaigns.push({ ...harvestCampaign, checked: false });
        });
        listCampaigns.push({
          ...campaign,
          harvestCampaigns: listHarvestInCampaigns,
          checked: false,
        });
        listHarvestInCampaigns = [];
      });
      localStorage.setItem(
        "dichonao_cart",
        JSON.stringify({ ...listCampaigns })
      );
      return Object.keys(action.payload).length === 0 ? null : listCampaigns;
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
                total: action.payload.newQuantity * harvestCampaign.price,
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

      const updateDB = async () => {
        const data = {
          id: action.payload.itemCartId,
          quantity: action.payload.newQuantity,
        };
        const response = await cartApi.update(data);
        console.log(response);
      };
      updateDB();

      return newState;
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

      const data = {
        id: action.payload.itemCartId,
      };
      cartApi.delete(data);
      return newState;
    },
    //clear cart
    clearCart(state) {
      return null;
    },

    //Handle checkbox campaign in cart page
    checkCampaign(state, action) {
      const campaignId = action.payload.campaignId;
      const currentValue = action.payload.currentValue;
      let newState = current(state);
      let listCampaigns = [];
      let listHarvestInCampaigns = [];
      //Hanlde check Campaign
      const handleCheckCampaign = () => {
        Object.values(newState).map((campaign) => {
          if (campaign.id === campaignId) {
            campaign.harvestCampaigns.map((harvestCampaign) => {
              listHarvestInCampaigns.push({
                ...harvestCampaign,
                checked: true,
              });
            });
            listCampaigns.push({
              ...campaign,
              harvestCampaigns: listHarvestInCampaigns,
              checked: true,
            });
            listHarvestInCampaigns = [];
          } else {
            listCampaigns.push({ ...campaign });
          }
        });
      };
      //Handle uncheck cartItem
      const handleUnCheckCampaign = () => {
        Object.values(newState).map((campaign) => {
          if (campaign.id === campaignId) {
            campaign.harvestCampaigns.map((harvestCampaign) => {
              listHarvestInCampaigns.push({
                ...harvestCampaign,
                checked: false,
              });
            });
            listCampaigns.push({
              ...campaign,
              harvestCampaigns: listHarvestInCampaigns,
              checked: false,
            });
            listHarvestInCampaigns = [];
          } else {
            listCampaigns.push({ ...campaign });
          }
        });
      };
      if (currentValue) {
        handleUnCheckCampaign();
      } else {
        handleCheckCampaign();
      }
      localStorage.setItem(
        "dichonao_cart",
        JSON.stringify({ ...listCampaigns })
      );
      return listCampaigns;
    },

    //Handle checkbox cartItem in cart page
    checkCartItem(state, action) {
      const harvestCampaignId = action.payload.harvestCampaignId;
      const currentValue = action.payload.currentValue;
      let newState = current(state);
      let listCampaigns = [];
      let listHarvestInCampaigns = [];
      let campaignChecked = true;
      //Hanlde check cartItem
      const handleCheckCartItem = () => {
        Object.values(newState).map((campaign) => {
          campaign.harvestCampaigns.map((harvestCampaign) => {
            if (harvestCampaign.id === harvestCampaignId) {
              listHarvestInCampaigns.push({
                ...harvestCampaign,
                checked: true,
              });
            } else {
              listHarvestInCampaigns.push({ ...harvestCampaign });
            }
          });
          listHarvestInCampaigns.map((harvestCampaign) => {
            if (!harvestCampaign.checked) {
              campaignChecked = false;
            }
          });

          listCampaigns.push({
            ...campaign,
            harvestCampaigns: listHarvestInCampaigns,
            checked: campaignChecked,
          });
          listHarvestInCampaigns = [];
        });
      };
      //Handle uncheck cartItem
      const handleUnCheckCartItem = () => {
        Object.values(newState).map((campaign) => {
          campaign.harvestCampaigns.map((harvestCampaign) => {
            if (harvestCampaign.id === harvestCampaignId) {
              listHarvestInCampaigns.push({
                ...harvestCampaign,
                checked: false,
              });
            } else {
              listHarvestInCampaigns.push({ ...harvestCampaign });
            }
          });
          listHarvestInCampaigns.map((harvestCampaign) => {
            if (!harvestCampaign.checked) {
              campaignChecked = false;
            }
          });

          listCampaigns.push({
            ...campaign,
            harvestCampaigns: listHarvestInCampaigns,
            checked: campaignChecked,
          });
          listHarvestInCampaigns = [];
        });
      };
      if (currentValue) {
        handleUnCheckCartItem();
      } else {
        handleCheckCartItem();
      }
      localStorage.setItem(
        "dichonao_cart",
        JSON.stringify({ ...listCampaigns })
      );
      return listCampaigns;
    },
  },

  extraReducers: (builder) => {
    builder.addCase(addToCartThunk.fulfilled, (state, action) => {
      localStorage.setItem(
        "dichonao_cart",
        JSON.stringify({ ...action.payload })
      );
      return action.payload;
    });
  },
});

const { actions, reducer } = cartSlice;
export const {
  setCart,
  setQuantity,
  removeFromCart,
  clearCart,
  checkCampaign,
  checkCartItem,
} = actions;
export default reducer;

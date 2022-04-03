import { message, notification } from "antd";
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
    let cartResponse;
    await cartApi.addNew(params).catch((err) => {
      notification.error({duration: 3, message: "Có lỗi xảy ra trong quá trình xử lý!", style:{fontSize: 16},});
    });

    cartResponse = await cartApi.getAll(data.customerId);
    localStorage.setItem("dichonao_cart", JSON.stringify({ ...cartResponse }));
    if (errorMessage === "") {
      notification.success({
        duration: 3,
        message: "Sản phẩm đã được thêm vào giỏ hàng!",
        style:{fontSize: 16},
      });
    } else {
      notification.error({
        duration: 3,
        message: errorMessage,
        style:{fontSize: 16},
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
      let newState = Object.values(action.payload).length > 0 ? action.payload : null;
      localStorage.setItem("dichonao_cart", JSON.stringify({ ...newState }));
      return newState;
    },
    //setQuantity for cart item
    setQuantity(state, action) {
      let currentState = current(state);
      let listFarms = [];
      let listHarvestOrder = [];
      currentState.farms.map((farm) => {
        farm.harvestInCampaigns.map((harvestCampaign) => {
          if (harvestCampaign.id === action.payload.harvestCampaignId) {
            listHarvestOrder.push({
              ...harvestCampaign,
              quantity: action.payload.newQuantity,
              total: action.payload.newQuantity * harvestCampaign.price,
            });
          } else listHarvestOrder.push({ ...harvestCampaign });
        });
        listFarms.push({ ...farm, harvestInCampaigns: listHarvestOrder });
        listHarvestOrder = [];
      });
      let newState = { ...currentState, farms: listFarms };
      localStorage.setItem("dichonao_cart", JSON.stringify({ ...newState }));

      const updateCart = async () => {
        const data = {
          harvestCampaignId: action.payload.harvestCampaignId,
          quantity: action.payload.newQuantity,
          customerId: action.payload.customerId,
        };
        const response = await cartApi.update(data);
        console.log(data);
        console.log(response);
      };
      updateCart();
      return newState;
    },
    //remove item from cart
    removeFromCart(state, action) {
      let curentState = current(state);
      let listFarms = [];
      let listHarvestOrder = [];
      curentState.farms.map((farm) => {
        farm.harvestInCampaigns.map((harvestCampaign) => {
          if (harvestCampaign.id !== action.payload.harvestCampaignId) {
            listHarvestOrder.push({ ...harvestCampaign });
          }
        });
        if (listHarvestOrder.length > 0) {
          listFarms.push({ ...farm, harvestInCampaigns: listHarvestOrder });
        }
      });
      const data = {
        harvestCampaignId: action.payload.harvestCampaignId,
        customerId: action.payload.customerId,
      };
      cartApi.delete(data);
      let newState =
        listFarms.length > 0 ? { ...curentState, farms: listFarms } : null;
      return newState;
    },
    //clear cart
    clearCart(state) {
      return null;
    },

    //Handle checkbox campaign in cart page
    checkCampaign(state, action) {
      // const campaignId = action.payload.campaignId;
      const currentValue = action.payload.currentValue;
      let currentState = current(state);
      let newState;
      let listFarms = [];
      let listHarvestInCampaigns = [];
      //Hanlde check Campaign
      const handleCheckCampaign = () => {
        currentState.farms.map((farm) => {
          farm.harvestInCampaigns.map((harvestInCampaign) => {
            listHarvestInCampaigns.push({
              ...harvestInCampaign,
              checked: true,
            });
          });
          listFarms.push({
            ...farm,
            harvestInCampaigns: listHarvestInCampaigns,
          });
          listHarvestInCampaigns = [];
        });
        newState = { ...currentState, farms: listFarms, checked: true };
      };
      //Handle uncheck cartItem
      const handleUnCheckCampaign = () => {
        currentState.farms.map((farm) => {
          farm.harvestInCampaigns.map((harvestInCampaign) => {
            listHarvestInCampaigns.push({
              ...harvestInCampaign,
              checked: false,
            });
          });
          listFarms.push({
            ...farm,
            harvestInCampaigns: listHarvestInCampaigns,
          });
          listHarvestInCampaigns = [];
        });
        newState = { ...currentState, farms: listFarms, checked: false };
      };
      if (currentValue) {
        handleUnCheckCampaign();
      } else {
        handleCheckCampaign();
      }
      localStorage.setItem("dichonao_cart", JSON.stringify({ ...newState }));
      return newState;
    },

    //Handle checkbox cartItem in cart page
    checkCartItem(state, action) {
      const harvestCampaignId = action.payload.harvestCampaignId;
      const currentValue = action.payload.currentValue;
      let currentState = current(state);
      let newState;
      let listFarms = [];
      let listHarvestInCampaigns = [];

      //Hanlde check cartItem
      const handleCheckCartItem = () => {
        let campaignChecked = true;
        currentState.farms.map((farm) => {
          farm.harvestInCampaigns.map((harvestCampaign) => {
            if (harvestCampaign.id === harvestCampaignId) {
              listHarvestInCampaigns.push({
                ...harvestCampaign,
                checked: true,
              });
            } else listHarvestInCampaigns.push({ ...harvestCampaign });
          });
          listFarms.push({
            ...farm,
            harvestInCampaigns: listHarvestInCampaigns,
          });
          listHarvestInCampaigns = [];
        });
        listFarms.map((farm) => {
          farm.harvestInCampaigns.map((harvestCampaign) => {
            if (!harvestCampaign.checked) {
              campaignChecked = false;
            }
          });
        });
        console.log("check nè");
        newState = {
          ...currentState,
          farms: listFarms,
          checked: campaignChecked,
        };
      };
      //Handle uncheck cartItem
      const handleUnCheckCartItem = () => {
        let campaignChecked = true;
        currentState.farms.map((farm) => {
          farm.harvestInCampaigns.map((harvestCampaign) => {
            if (harvestCampaign.id === harvestCampaignId) {
              listHarvestInCampaigns.push({
                ...harvestCampaign,
                checked: false,
              });
            } else listHarvestInCampaigns.push(harvestCampaign);
          });
          listFarms.push({
            ...farm,
            harvestInCampaigns: listHarvestInCampaigns,
          });
          listHarvestInCampaigns = [];
        });

        listFarms.map((farm) => {
          farm.harvestInCampaigns.map((harvestCampaign) => {
            if (!harvestCampaign.checked) {
              campaignChecked = false;
            }
          });
        });
        newState = {
          ...currentState,
          farms: listFarms,
          checked: campaignChecked,
        };
      };

      if (currentValue) {
        handleUnCheckCartItem();
      } else {
        handleCheckCartItem();
      }
      localStorage.setItem("dichonao_cart", JSON.stringify({ ...newState }));
      return newState;
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

import { createSelector } from "@reduxjs/toolkit";

const cartSelector = (state) => state.cart;

export const getCartCouter = createSelector(cartSelector, (cartSelector) => {
  let counter = 0;
  if (cartSelector !== null) {
    cartSelector.farms.map((farm) =>
      farm.harvestInCampaigns.map(() => counter++)
    );
  }

  return counter;
});

export const getCartTotal = createSelector(cartSelector, (cartSelector) => {
  let total = 0;
  if (cartSelector !== null) {
    cartSelector.farms.map((farm) =>
      farm.harvestInCampaigns.map((harvestCampaign) => {
        if (harvestCampaign.checked) total += harvestCampaign.total;
      })
    );
  }

  return total;
});

export const getOrderCouter = createSelector(cartSelector, (cartSelector) => {
  let counter = 0;
  if (cartSelector !== null) {
    cartSelector.farms.map((farm) =>
      farm.harvestInCampaigns.map((harvestCampaign) => {
        if (harvestCampaign.checked) counter++;
      })
    );
  }
  return counter;
});

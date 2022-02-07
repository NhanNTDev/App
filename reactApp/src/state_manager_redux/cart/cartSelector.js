import { createSelector } from "@reduxjs/toolkit";

const cartSelector = (state) => state.cart;

export const getCartCouter = createSelector(cartSelector, (cartSelector) => {
  let counter = 0;
  if (cartSelector !== null) {
    Object.values(cartSelector).map((campaign) => {
      campaign.harvestCampaigns.map(() => counter++);
    });
  }

  return counter;
});

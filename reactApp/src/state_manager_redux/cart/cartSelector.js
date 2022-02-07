import { createSelector } from "@reduxjs/toolkit";

const cartSelector = (state) => state.cart;

export const getCartCouter = createSelector(cartSelector, (cartSelector) => {
    let counter = 0;
    Object.values(cartSelector).map(campaign => {
        campaign.harvestCampaigns.map(() => counter++);
    })
    return counter;
})
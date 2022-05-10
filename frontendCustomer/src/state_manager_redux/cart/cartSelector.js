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

export const getShipcost = createSelector(cartSelector, (cartSelector) => {
  let total = 0;
  let shipCost = 0;
  const max = 50000;
  const min = 20000;
  if (cartSelector !== null) {
    cartSelector.farms.map((farm) =>
      farm.harvestInCampaigns.map((harvestCampaign) => {
        if (harvestCampaign.checked) total += harvestCampaign.total;
      })
    );
  }
  shipCost = total*0.03;
  if(shipCost < min) {
    shipCost = min;
  }
  if(shipCost > max) {
    shipCost = max;
  }
  if(total === 0) {
    shipCost = 0;
  }
  shipCost = shipCost.toFixed();
  return shipCost;
});


const { createSlice } = require("@reduxjs/toolkit");

const cartSlice = createSlice({
    name: "cart",
    initialState: null,
    reducers: {
        //set value for cart state
        setCart(state, action) {
            return action.payload;
        },
        //setQuantity for cart item
        setQuantity(state, action) {
            console.log("setQuantity");
        },
        //add item to cart
        addToCart(state, action) {
            console.log("add to cart");
        },
        //remove item from cart
        removeFromCart(state, action){
            console.log("remove from cart");
        },
        //clear cart
        clearCart(state) {
            state = null;
        }
    }
})

const {actions, reducer} = cartSlice;
export const {setCart, setQuantity, addToCart, removeFromCart, clearCart} = actions;
export default reducer;
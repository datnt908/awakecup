export const CART_ADD_PRODUCT = "CART_ADD_PRODUCT";
export const CART_CHANGE_ALL = "CART_CHANGE_ALL";

export const addProductToCart = (product) => ({
    type: CART_ADD_PRODUCT,
    payload: product,
});

export const changeAllCart = (cart) => ({
    type: CART_CHANGE_ALL,
    payload: cart,
});
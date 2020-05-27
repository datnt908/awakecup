import {
    CART_ADD_PRODUCT,
    CART_CHANGE_ALL,
} from '../actions/cartActions';

const INITIAL_STATE = {
    subtotal: 0,
    delivery: 0,
    discount: 0,
    total: 0,
    cartDetails: [],
}

export default (state = INITIAL_STATE, action) => {
    switch (action.type) {
        case CART_ADD_PRODUCT:
            return addProductToCart(state, action.payload);

        case CART_CHANGE_ALL:
            const cart = action.payload;
            return { ...cart };

        default:
            return state;
    }
}

function addProductToCart(state, payload) {
    const newState = { ...state };

    const cartDetailIndex = state.cartDetails.findIndex(x => x.product.id === payload.id);
    if (-1 === cartDetailIndex) {
        const cartDetail = {
            product: undefined,
            quantity: 0,
            total: 0,
        };
        cartDetail.product = payload;
        cartDetail.quantity = 1;
        cartDetail.total = cartDetail.quantity * cartDetail.product.price;
        newState.cartDetails.push(cartDetail);
    }
    if (-1 !== cartDetailIndex) {
        const cartDetail = newState.cartDetails[cartDetailIndex];
        cartDetail.quantity++;
        cartDetail.total = cartDetail.quantity * cartDetail.product.price;
    }
    newState.subtotal = newState.subtotal + payload.price;
    newState.total = newState.subtotal + newState.delivery - newState.discount;

    return newState;
}
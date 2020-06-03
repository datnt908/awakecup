import { NOTIFICATION_PUSH, NOTIFICATION_HIDE } from '../actions/notifyActions';

const INITIAL_STATE = {
    isOpen: false,
    notification: {
        title: "Default",
        message: "This is a default alert—check it out!",
        type: "info",
    }
}

export default (state = INITIAL_STATE, action) => {
    switch (action.type) {
        case NOTIFICATION_PUSH:
            return {
                isOpen: true,
                notification: action.payload,
            };

        case NOTIFICATION_HIDE:
            return {
                ...state,
                isOpen: false,
            };

        default:
            return state;
    }
}
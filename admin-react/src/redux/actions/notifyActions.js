export const NOTIFICATION_PUSH = "NOTIFICATION_PUSH";
export const NOTIFICATION_HIDE = "NOTIFICATION_HIDE";

export const pushNotification = (notification) => ({
    type: NOTIFICATION_PUSH,
    payload: notification,
});

export const hideNotification = () => ({
    type: NOTIFICATION_HIDE,
});
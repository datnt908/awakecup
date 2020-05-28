import Homepage from './views/HomepageView';
import Menu from './views/MenuView';
import Cart from './views/CartView';
import Checkout from './views/CheckoutView';

const routes = [
    {
        path: '/homepage',
        layout: '/store',
        component: Homepage
    },
    {
        path: '/menu',
        layout: '/store',
        component: Menu
    },
    {
        path: '/cart',
        layout: '/store',
        component: Cart
    },
    {
        path: '/checkout',
        layout: '/store',
        component: Checkout
    },
];

export default routes;
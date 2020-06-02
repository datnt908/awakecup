import Homepage from './views/HomepageView';
import Menu from './views/MenuView';
import Cart from './views/CartView';
import Checkout from './views/CheckoutView';
import OrderNowView from './views/OrderNowView';

const routes = [
    {
        path: '/homepage',
        layout: '',
        component: Homepage
    },
    {
        path: '/menu',
        layout: '',
        component: Menu
    },
    {
        path: '/shop',
        layout: '',
        component: OrderNowView,
    },
    {
        path: '/cart',
        layout: '',
        component: Cart
    },
    {
        path: '/checkout',
        layout: '',
        component: Checkout
    },
];

export default routes;
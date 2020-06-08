import Homepage from './views/HomepageView';
import Menu from './views/MenuView';
import Cart from './views/CartView';
import Checkout from './views/CheckoutView';
import OrderNow from './views/OrderNowView';
import Product from './views/ProductView'

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
        component: OrderNow,
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
    {
        path: '/product-:productCode',
        layout: '',
        component: Product
    },
];

export default routes;
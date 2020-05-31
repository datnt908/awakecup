import SignIn from './views/SignInView';
import Products from './views/ProductsView';
import Orders from './views/OrdersView';

export default [
    {
        path: '/signin',
        layout: '/auth',
        component: SignIn,
    },
    {
        path: '/products',
        layout: '/admin',
        component: Products,
    },
    {
        path: '/orders',
        layout: '/admin',
        component: Orders,
    },
];

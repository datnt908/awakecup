import Products from './views/ProductsView';
import Orders from './views/OrdersView';

export default [
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

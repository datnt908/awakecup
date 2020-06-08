import Products from './views/ProductsView';
import Orders from './views/OrdersView';
import CreateProduct from './views/CreateProductView'

export default [
    {
        path: '/products/create',
        layout: '/admin',
        component: CreateProduct,
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

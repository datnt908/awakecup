import Products from './views/ProductsView';
import Orders from './views/OrdersView';
import CreateProduct from './views/CreateProductView'
import UpdateProduct from './views/UpdateProductView'

export default [
    {
        path: '/products/create',
        layout: '/admin',
        component: CreateProduct,
    },
    {
        path: '/products/update-:productCode',
        layout: '/admin',
        component: UpdateProduct,
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

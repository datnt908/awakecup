import SignIn from './views/SignInView';
import Products from './views/ProductsView';

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
];

import Homepage from './views/HomepageView';
import Menu from './views/MenuView';

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
    }
];

export default routes;
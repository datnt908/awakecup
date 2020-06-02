import React from 'react';
import DashboardIcon from '@material-ui/icons/Dashboard';
import ShoppingBasketIcon from '@material-ui/icons/ShoppingBasket';
import AccountBoxIcon from '@material-ui/icons/AccountBox';
import SettingsIcon from '@material-ui/icons/Settings';
import ReceiptIcon from '@material-ui/icons/Receipt';

const pages = [
    {
        title: 'Dashboard',
        href: '/admin/dashboard',
        icon: <DashboardIcon />
    },
    {
        title: 'Products',
        href: '/admin/products',
        icon: <ShoppingBasketIcon />
    },
    {
        title: 'Orders',
        href: '/admin/orders',
        icon: <ReceiptIcon />
    },
    {
        title: 'Account',
        href: '/admin/account',
        icon: <AccountBoxIcon />
    },
    {
        title: 'Settings',
        href: '/admin/settings',
        icon: <SettingsIcon />
    },
];

export default pages;
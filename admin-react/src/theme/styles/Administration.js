export default (theme) => ({
    root: {
        paddingTop: 56,
        height: '100%',
        [theme.breakpoints.up('sm')]: {
            paddingTop: 64
        },
        [theme.breakpoints.up('lg')]: {
            paddingLeft: 240
        }
    },
    content: {
        height: '100%'
    }
});
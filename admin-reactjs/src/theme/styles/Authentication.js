export default (theme) => ({
    root: {
        backgroundColor: theme.palette.background.default,
        height: '100%',
    },
    appbar: {
        boxShadow: 'none',
        paddingLeft: 16,
    },
    grid: {
        height: '100%'
    },
    quoteContainer: {
        [theme.breakpoints.down('md')]: {
            display: 'none'
        }
    },
    quote: {
        backgroundColor: theme.palette.neutral,
        height: '100%',
        display: 'flex',
        justifyContent: 'center',
        alignItems: 'center',
        backgroundImage: 'url(/images/auth_bg.jpg)',
        backgroundSize: 'cover',
        backgroundRepeat: 'no-repeat',
        backgroundPosition: 'center'
    },
    quoteInner: {
        textAlign: 'center',
        flexBasis: '600px',
        padding: 20
    },
    quoteText: {
        color: theme.palette.white,
        fontWeight: 300
    },
    content: {
        height: '100%',
        display: 'flex',
        flexDirection: 'column'
    },
    contentBody: {
        flexGrow: 1,
        display: 'flex',
        alignItems: 'center',
        [theme.breakpoints.down('md')]: {
            justifyContent: 'center'
        }
    },
});
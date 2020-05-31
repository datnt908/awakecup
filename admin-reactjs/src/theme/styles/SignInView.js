export default (theme) => ({
    form: {
        paddingLeft: 100,
        paddingRight: 100,
        paddingBottom: 125,
        flexBasis: 700,
        [theme.breakpoints.down('sm')]: {
            paddingLeft: theme.spacing(5),
            paddingRight: theme.spacing(5)
        }
    },
    title: {
        marginTop: theme.spacing(3)
    },
    sugestion: {
        marginTop: theme.spacing(2)
    },
    textField: {
        marginTop: theme.spacing(2),
    },
    signInButton: {
        margin: theme.spacing(2, 0)
    }
});
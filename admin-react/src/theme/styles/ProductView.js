export default (theme) => ({
    root: {
        padding: theme.spacing(3)
    },
    content: {
        marginTop: theme.spacing(2)
    },
    image: {
        width: '100%',
    },
    row: {
        display: 'flex',
        width: '100%',
        alignItems: 'center',
    },
    spacer: {
        flexGrow: 1
    },
    cancelButton: {
        marginRight: theme.spacing(1)
    },
    button: {
        marginTop: theme.spacing(1),
        marginLeft: theme.spacing(1),
        position: 'fixed',
    },
    input: {
        marginBottom: theme.spacing(2),    }
});
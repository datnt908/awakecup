import React, { Component } from 'react';
// material-ui
import { withStyles } from '@material-ui/core/styles';
import styles from '../theme/styles/Footer';
import Typography from '@material-ui/core/Typography';
import Link from '@material-ui/core/Link';

class Footer extends Component {
  render() {
    const { classes } = this.props;
    return (
      <div className={classes.root}>
        <Typography variant="body1">
          &copy;{' '}
          <Link component="a" href="https://devias.io/" target="_blank">Devias IO</Link>
          . 2019
        </Typography>
        <Typography variant="caption">
          Created with love for the environment. By designers and developers who
          love to work together in offices!
        </Typography>
      </div>
    );
  }
}

export default withStyles(styles, { withTheme: true })(Footer);
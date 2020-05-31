import React, { Component } from 'react';
import { Switch, Route, Redirect } from 'react-router-dom';
// material-ui
import { withStyles } from '@material-ui/core/styles';
import styles from '../theme/styles/Authentication';
import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';
import Grid from '@material-ui/core/Grid';
import Typography from '@material-ui/core/Typography';
//
import routes from '../routes';
import { AccountAPIsService } from '../utils/apiCalling';
const quote = "Hella narwhal Cosby sweater McSweeney's, salvia kitsch before they sold out High Life.";

class Authentication extends Component {
  constructor(props) {
    super(props);
    AccountAPIsService.checkAuth()
      .then(() => window.location.replace('/admin/dashboard'));
  }

  render() {
    const { classes } = this.props;

    return (
      <>
        <AppBar className={classes.appbar} color='primary' position='fixed'>
          <Toolbar>
            <a className="navbar-brand" rel="noopener noreferrer" href="http://awakecup.ddns.net" target="_blank" >
              Coffee<small>Awakecup</small>
            </a>
          </Toolbar>
        </AppBar>
        <div className={classes.root}>
          <Grid className={classes.grid} container>
            <Grid className={classes.quoteContainer} item lg={5}>
              <div className={classes.quote}>
                <div className={classes.quoteInner}>
                  <Typography className={classes.quoteText} variant="h2">{quote}</Typography>
                </div>
              </div>
            </Grid>
            <Grid className={classes.content} item lg={7} xs={12}>
              <div className={classes.content}>
                <div className={classes.contentBody}>
                  <Switch>
                    {getRoutes(routes)}
                    <Redirect from="*" to="/auth/signin" />
                  </Switch>
                </div>
              </div>
            </Grid>
          </Grid>
        </div>
      </>
    );
  }
}

Authentication.propTypes = {

};

export default withStyles(styles, { withTheme: true })(Authentication);

function getRoutes(routes) {
  return routes.map((value, key) => {
    if ('/auth' === value.layout)
      return (<Route key={key} path={value.layout + value.path} component={value.component} />);
    else
      return null;
  });
}
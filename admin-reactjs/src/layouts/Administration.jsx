import React, { Component } from 'react';
import { Switch, Route, Redirect } from 'react-router-dom';
// material-ui
import { withStyles } from '@material-ui/core/styles';
import styles from '../theme/styles/Administration';
//
import routes from '../routes';
import { AccountAPIsService } from '../utils/apiCalling';
// core components
import Footer from '../components/Footer';
import NavBar from '../components/NavBar';

class Administration extends Component {
  constructor(props) {
    super(props);
    AccountAPIsService.checkAuth()
      .catch(() => window.location.replace('/auth/signin'));
  }

  render() {
    const { classes } = this.props;

    return (
      <div className={classes.root}>
        <NavBar />
        <main className={classes.content}>
          <Switch>
            {getRoutes(routes)}
            <Redirect from="*" to="/admin/dashboard" />
          </Switch>
          <Footer />
        </main>
      </div>
    );
  }
}

Administration.propTypes = {

};

export default withStyles(styles, { withTheme: true })(Administration);

function getRoutes(routes) {
  return routes.map((value, key) => {
    if ('/admin' === value.layout)
      return (<Route key={key} path={value.layout + value.path} component={value.component} />);
    else
      return null;
  });
}
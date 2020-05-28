import React, { Component } from 'react';
import { Route, Switch, Redirect } from 'react-router-dom';
// app routes
import routes from '../routes';

// core components
import StoreNavBar from '../components/StoreNavBar';
import HomeSlider from '../components/HomeSlider';
import IntroSection from '../components/IntroSection';
import StoreFooter from '../components/StoreFooter';
import Loader from '../components/Loader';

class Homepage extends Component {
  render() {
    return (
      <>
        <StoreNavBar />
        <HomeSlider />
        <IntroSection />
        <Switch>
          {getRoutes(routes)}
          <Redirect from="*" to="/store/homepage" />
        </Switch>
        <StoreFooter />
        <div className="alert alert-primary d-none" id="alert"></div>
        <Loader />
      </>
    );
  }
}

function getRoutes(routes) {
  return routes.map((value, key) => {
    if ('/store' === value.layout) {
      return (
        <Route key={key}
          path={value.layout + value.path}
          component={value.component}
        />
      );
    }
    else
      return null;
  });
}

export default Homepage;
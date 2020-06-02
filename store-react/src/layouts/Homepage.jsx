import React, { Component } from 'react';
import { Route, Switch, Redirect } from 'react-router-dom';
// core components
import TopBar from '../components/TopBar';
import HomeSlider from '../components/HomeSlider';
import IntroSection from '../components/IntroSection';
import Footer from '../components/Footer';
import Loader from '../components/Loader';
//
import routes from '../routes';

class Homepage extends Component {
  render() {
    return (
      <>
        <TopBar />
        <HomeSlider />
        <IntroSection />
        <Switch>
          {getRoutes(routes)}
          <Redirect from="*" to="/homepage" />
        </Switch>
        <Footer />
        <div className="alert alert-primary d-none" id="alert"></div>
        <Loader />
      </>
    );
  }
}

function getRoutes(routes) {
  return routes.map((value, key) => {
    if ('' === value.layout)
      return (<Route key={key} path={value.layout + value.path} component={value.component} />);
    else
      return null;
  });
}

export default Homepage;
import React, { Component } from 'react';

// core components
import StoreNavBar from '../components/StoreNavBar';
import HomeSlider from '../components/HomeSlider';
import IntroSection from '../components/IntroSection';
import StoreFooter from '../components/StoreFooter';

class Homepage extends Component {
  render() {
    return (
      <>
        <StoreNavBar />
        <HomeSlider />
        <IntroSection />
        <StoreFooter />
      </>
    );
  }
}

export default Homepage;
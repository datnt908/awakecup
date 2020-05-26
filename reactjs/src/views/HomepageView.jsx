import React, { Component } from 'react';
import MenuSection from '../components/Homepage/MenuSection';
import ServiceSection from '../components/Homepage/ServiceSection';
import BestSellersSection from '../components/Homepage/BestSellersSection';

class HomepageView extends Component {
  render() {
    return (
      <>
        <MenuSection />
        <ServiceSection />
        <BestSellersSection />
      </>
    );
  }
}

export default HomepageView;
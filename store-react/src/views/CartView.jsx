import React, { Component } from 'react';

// backend
import CartSection from '../components/Cart/CartSection';
import RelatedSection from '../components/Cart/RelatedSection';

class CartView extends Component {
  render() {
    return (
      <>
        <CartSection />
        <RelatedSection productCode='' />
      </>
    );
  }
}

export default CartView;
import React, { Component } from 'react';
import PropTypes from 'prop-types';

import { DOMAIN } from '../utils/apiCalling';
import { Link } from 'react-router-dom';

class Product extends Component {
  render() {
    const { product } = this.props;
    if (product.description.length > 72)
      product.description = product.description.substring(0, 72) + '...';
    return (
      <div className="menu-entry product">
        <Link to="/" onClick={e => e.preventDefault()} className="img"
          style={{ backgroundImage: `url(${DOMAIN}/${product.imageURL})` }}
        />
        <div className="text text-center pt-4">
          <h3>
            <a href="/" onClick={e => e.preventDefault()} >
              {product.title}
            </a>
          </h3>
          <p className="description">{product.description}</p>
          <p className="price"><span>{product.price} Đ</span></p>
          <p>
            <a href="/" onClick={e => e.preventDefault()}
              className="btn btn-primary btn-outline-primary"
            >
              Add to Cart
            </a>
          </p>
        </div>
      </div>
    );
  }
}

Product.propTypes = {
  product: PropTypes.shape({
    id: PropTypes.number,
    code: PropTypes.string,
    title: PropTypes.string,
    description: PropTypes.string,
    category: PropTypes.shape({
      id: PropTypes.number,
      title: PropTypes.string,
    }),
    price: PropTypes.number,
    imageURL: PropTypes.string,
    recordStatus: PropTypes.bool,
  }),
};

export default Product;
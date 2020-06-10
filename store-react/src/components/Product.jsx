import React, { Component } from 'react';
import PropTypes from 'prop-types';

import { DOMAIN } from '../utils/helpers';
import { Link } from 'react-router-dom';

import store from '../redux/store';
import { addProductToCart } from '../redux/actions/cartActions';

class Product extends Component {
  render() {
    const { product } = this.props;
    if (product.description.length > 72)
      product.description = product.description.substring(0, 72) + '...';
    return (
      <div className="menu-entry product">
        <Link to={`/product-${product.code}`} className="img"
          style={{ backgroundImage: `url(${DOMAIN}/${product.imageURL})` }}
          onClick={() => window.scrollTo({ top: window.innerHeight - 60, behavior: 'smooth' })}
        />
        <div className="text text-center pt-4">
          <h3>
            <Link to={`/product-${product.code}`}
              onClick={() => window.scrollTo({ top: window.innerHeight - 60, behavior: 'smooth' })}
            >
              {product.title}
            </Link>
          </h3>
          <p className="description">{product.description}</p>
          <p className="price"><span>{product.price} Đ</span></p>
          <p>
            <a href="/" onClick={e => {
              e.preventDefault();
              handleAddProductToCart(product);
            }}
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

function handleAddProductToCart(product) {
  store.dispatch(addProductToCart(product));
};

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
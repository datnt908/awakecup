import React, { Component } from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';

import store from '../../redux/store';
import { changeAllCart } from '../../redux/actions/cartActions';

// backend
import { DOMAIN } from '../../utils/helpers';

class CartSection extends Component {
  state = { cart: this.props.cart }

  handleChangeQuantity(cartDetail, quantity) {
    if (quantity < 1 || quantity > 99) return;
    const cart = this.state.cart;
    cartDetail.quantity = quantity;
    cartDetail.total = cartDetail.quantity * cartDetail.product.price;
    this.setState({ cart });
  }

  handleRemoveProduct(cartDetail) {
    const cart = this.state.cart;
    const index = cart.cartDetails.findIndex(x => x.product.id === cartDetail.product.id);
    if (index > -1)
      cart.cartDetails.splice(index, 1);
    calculateCartTotal(cart);
    this.setState({ cart });
    store.dispatch(changeAllCart(this.state.cart));
  }

  componentWillUnmount() {
    store.dispatch(changeAllCart(this.state.cart));
  }

  render() {
    const { cart } = this.state;
    calculateCartTotal(cart);
    return (
      <section className="ftco-section ftco-cart">
        <div className="container">
          <div className="row">
            <div className="col-md-12">
              <div className="cart-list">
                <table className="table">
                  <thead className="thead-primary">
                    <tr className="text-center">
                      <th>&nbsp;</th>
                      <th>&nbsp;</th>
                      <th>Product</th>
                      <th>Price</th>
                      <th>Quantity</th>
                      <th>Total</th>
                    </tr>
                  </thead>
                  <tbody>
                    {0 === cart.cartDetails.length && <EmptyCart />}
                    {cart.cartDetails.map((value, key) => {
                      const { product } = value;
                      if (product.description.length > 64)
                        product.description = product.description.substring(0, 64) + '...';
                      return (
                        <tr className="text-center" key={key}>
                          <td className="product-remove">
                            <i onClick={() => this.handleRemoveProduct(value)}>
                              <i className="fas fa-times"></i>
                            </i>
                          </td>
                          <td className="image-prod"><div className="img" style={{ backgroundImage: `url(${DOMAIN}/${product.imageURL})` }}></div></td>
                          <td className="product-name"><h3>{product.title}</h3><p>{product.description}</p></td>
                          <td className="price">{product.price} Đ</td>
                          <td className="quantity">
                            <div className="input-group d-flex">
                              <span className="input-group-btn">
                                <button type="button" className="quantity-left-minus btn"
                                  onClick={() => this.handleChangeQuantity(value, value.quantity - 1)}
                                >
                                  <i className="fas fa-minus"></i>
                                </button>
                              </span>
                              <input type="number" className="form-control input-number"
                                value={value.quantity} min={1} max={99}
                                onChange={e => this.handleChangeQuantity(value, e.target.value)}
                              />
                              <span className="input-group-btn">
                                <button type="button" className="quantity-right-plus btn"
                                  onClick={() => this.handleChangeQuantity(value, value.quantity + 1)}
                                >
                                  <i className="fas fa-plus"></i>
                                </button>
                              </span>
                            </div>
                          </td>
                          <td className="total">{value.total} Đ</td>
                        </tr>
                      );
                    })}
                  </tbody>
                </table>
              </div>
            </div>
          </div>
          <div className="row justify-content-end">
            <div className="col col-lg-3 col-md-6 mt-5 cart-wrap">
              <div className="cart-total mb-3">
                <h3>Cart Totals</h3>
                <p className="d-flex"><span>Subtotal</span><span>{cart.subtotal}</span></p>
                <p className="d-flex"><span>Delivery</span><span>{cart.delivery}</span></p>
                <p className="d-flex"><span>Discount</span><span>{cart.discount}</span></p>
                <hr />
                <p className="d-flex total-price"><span>Total</span><span>{cart.total}</span></p>
              </div>
              <p className="text-center">
                <Link to="/checkout" className="btn btn-primary py-3 px-4">
                  Proceed to Checkout
                </Link>
              </p>
            </div>
          </div>
        </div>
      </section>
    );
  }
}

function calculateCartTotal(cart) {
  cart.subtotal = 0;
  for (let i = 0; i < cart.cartDetails.length; i++) {
    const detail = cart.cartDetails[i];
    detail.total = detail.quantity * detail.product.price;
    cart.subtotal += detail.total;
  }
  cart.total = cart.subtotal + cart.delivery - cart.discount;
}

function EmptyCart(props) {
  return (
    <tr className="text-center">
      <td colSpan="6">
        <p>Không có sản phẩm nào trong giỏ hàng</p>
        <p>
          <Link to="/menu" className="btn btn-primary btn-outline-primary px-4 py-3">
            View Full Menu
          </Link>
        </p>
      </td>
    </tr>
  );
}

const mapStateToProps = (state) => ({
  cart: state.cart,
});

export default connect(mapStateToProps, null)(CartSection);
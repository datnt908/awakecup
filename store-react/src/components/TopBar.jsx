import React, { Component } from 'react';
import { Link } from 'react-router-dom';
import { connect } from 'react-redux';

class TopBar extends Component {
  componentDidMount() {
    window.addEventListener("scroll", () => handleNavBarScroll());
  }
  componentWillUnmount() {
    window.removeEventListener("scroll", () => handleNavBarScroll());
  }

  render() {
    return (
      <nav className="navbar navbar-expand-lg navbar-dark bg-dark ftco_navbar ftco-navbar-light" id="ftco-navbar">
        <div className="container">
          <Link className="navbar-brand" to="/homepage" onClick={() => window.scrollTo({ top: 0, behavior: 'smooth' })}>
            Coffee<small>Awakecup</small>
          </Link>
          <button className="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav"
            aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
            <i className="fas fa-bars"></i> Menu
          </button>
          <div className="collapse navbar-collapse" id="ftco-nav">
            <ul className="navbar-nav ml-auto">
              <li className="nav-item">
                <Link className="nav-link" to="/homepage" onClick={() => window.scrollTo({ top: 0, behavior: 'smooth' })}>Home</Link>
              </li>
              <li className="nav-item">
                <Link className="nav-link" to="/menu" onClick={() => window.scrollTo({ top: window.innerHeight - 60, behavior: 'smooth' })}>Menu</Link>
              </li>
              <li className="nav-item">
                <Link className="nav-link" to="/shop" onClick={() => window.scrollTo({ top: window.innerHeight - 60, behavior: 'smooth' })}>Shop</Link>
              </li>
              {/* <li className="nav-item"><a href="/" onClick={e => e.preventDefault()} className="nav-link">Services</a></li>
              <li className="nav-item"><a href="/" onClick={e => e.preventDefault()} className="nav-link">About</a></li>
              <li className="nav-item"><a href="/" onClick={e => e.preventDefault()} className="nav-link">Contact</a></li> */}
              <li className="nav-item cart">
                <Link to="/cart" className="nav-link" onClick={() => window.scrollTo({ top: window.innerHeight - 60, behavior: 'smooth' })}>
                  <i className="fas fa-shopping-cart"></i>
                  <span className="bag d-flex justify-content-center align-items-center">
                    <small>{this.props.cart.cartDetails.length}</small>
                  </span>
                </Link>
              </li>
            </ul>
          </div>
        </div>
      </nav>
    );
  }
}

function handleNavBarScroll() {
  if (window.pageYOffset > 300) {
    document.getElementById("ftco-navbar").classList.add("scrolled");
    document.getElementById("ftco-navbar").classList.add("awake");
  }
  else {
    document.getElementById("ftco-navbar").classList.remove("scrolled");
    document.getElementById("ftco-navbar").classList.remove("awake");
  }
}


const mapStateToProps = (state) => ({
  cart: state.cart,
});

export default connect(mapStateToProps, null)(TopBar);
import React, { Component } from 'react';

// backend
import { DOMAIN } from '../../utils/helpers';
import { Link } from 'react-router-dom';
const contents = {
  description: "Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics, a large language ocean.",
  images: [
    `${DOMAIN}/appdata/products/PRO00006_1.png`,
    `${DOMAIN}/appdata/products/PRO00008_1.png`,
    `${DOMAIN}/appdata/products/PRO00012_1.png`,
    `${DOMAIN}/appdata/products/PRO00022_1.png`,
  ]
};

class MenuSection extends Component {
  render() {
    return (
      <section className="ftco-section">
        <div className="container">
          <div className="row align-items-center">
            <div className="col-md-6 pr-md-5">
              <div className="heading-section text-md-right">
                <span className="subheading">Discover</span>
                <h2 className="mb-4">Our Menu</h2>
                <p className="mb-4">{contents.description}</p>
                <p>
                  <Link to="/menu"
                    className="btn btn-primary btn-outline-primary px-4 py-3"
                  >
                    View Full Menu
                  </Link>
                </p>
              </div>
            </div>
            <div className="col-md-6">
              <div className="row">
                <div className="col-md-6">
                  <div className="menu-entry">
                    <Link to="/" onClick={e => e.preventDefault()} className="img"
                      style={{ backgroundImage: `url(${contents.images[0]})` }}
                    />
                  </div>
                </div>
                <div className="col-md-6">
                  <div className="menu-entry mt-lg-4">
                    <Link to="/" onClick={e => e.preventDefault()} className="img"
                      style={{ backgroundImage: `url(${contents.images[1]})` }}
                    />
                  </div>
                </div>
                <div className="col-md-6">
                  <div className="menu-entry">
                    <Link to="/" onClick={e => e.preventDefault()} className="img"
                      style={{ backgroundImage: `url(${contents.images[2]})` }}
                    />
                  </div>
                </div>
                <div className="col-md-6">
                  <div className="menu-entry mt-lg-4">
                    <Link to="/" onClick={e => e.preventDefault()} className="img"
                      style={{ backgroundImage: `url(${contents.images[3]})` }}
                    />
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    );
  }
}

export default MenuSection;
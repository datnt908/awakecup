import React, { Component } from 'react';

const contents = {
  about: "Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts.",
  location: "Khu phố 6, P.Linh Trung, Q.Thủ Đức, Tp.Hồ Chí Minh.",
  phone: "Delivery 1800 6936 (07:00-21:00) Support 02871 087 088 (07:00-21:00)",
  email: "awakecup@gmail.com"
}

class Footer extends Component {
  render() {
    return (
      <footer className="ftco-footer ftco-section img">
        <div className="overlay"></div>
        <div className="container">
          <div className="row mb-5">
            <div className="col-lg-4 col-md-6 mb-5 mb-md-5">
              <div className="ftco-footer-widget mb-4 ml-md-4">
                <a className="navbar-brand float-md-left float-lft" style={{ fontSize: 32 }} href="/" onClick={e => e.preventDefault()}>
                  Coffee<small>Awakecup</small>
                </a>
              </div>
            </div>
            <div className="col-lg-3 col-md-6 mb-5 mb-md-5">
              <div className="ftco-footer-widget mb-4">
                <h2 className="ftco-heading-2">About Us</h2>
                <p>{contents.about}</p>
                <ul className="ftco-footer-social list-unstyled float-md-left float-lft mt-5">
                  <li className=" fadeInUpd">
                    <a href="/" onClick={e => e.preventDefault()}><i className="fab fa-facebook-f"></i></a>
                  </li>
                  <li className=" fadeInUpd">
                    <a href="/" onClick={e => e.preventDefault()}><i className="fab fa-twitter"></i></a>
                  </li>
                  <li className=" fadeInUpd">
                    <a href="/" onClick={e => e.preventDefault()}><i className="fab fa-instagram"></i></a>
                  </li>
                </ul>
              </div>
            </div>
            <div className="col-lg-2 col-md-6 mb-5 mb-md-5">
              <div className="ftco-footer-widget mb-4 ml-md-4">
                <h2 className="ftco-heading-2">Services</h2>
                <ul className="list-unstyled">
                  <li><a href="/" onClick={e => e.preventDefault()} className="py-2 d-block">Cooked</a></li>
                  <li><a href="/" onClick={e => e.preventDefault()} className="py-2 d-block">Deliver</a></li>
                  <li><a href="/" onClick={e => e.preventDefault()} className="py-2 d-block">Quality Foods</a></li>
                  <li><a href="/" onClick={e => e.preventDefault()} className="py-2 d-block">Mixed</a></li>
                </ul>
              </div>
            </div>
            <div className="col-lg-3 col-md-6 mb-5 mb-md-5">
              <div className="ftco-footer-widget mb-4">
                <h2 className="ftco-heading-2">Have a Questions?</h2>
                <div className="block-23 mb-3">
                  <ul>
                    <li><i className="icon fas fa-map-marker-alt"></i><span className="text">{contents.location}</span></li>
                    <li><i className="icon fas fa-phone"></i><span className="text">{contents.phone}</span></li>
                    <li><i className="icon fas fa-envelope"></i><span className="text">{contents.email}</span></li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
          <div className="row">
            <div className="col-md-12 text-center">
              <p>
                {/* Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. */}
                Copyright ©<script>document.write(new Date().getFullYear());</script>2020 All rights reserved | This template is made with <i className="fas fa-heart"></i> by
                <a href="https://colorlib.com" target="_blank" rel="noopener noreferrer"> Colorlib</a>
                {/*Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0.*/}
              </p>
            </div>
          </div>
        </div>
      </footer>
    );
  }
}

export default Footer;
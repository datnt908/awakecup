import React, { Component } from 'react';

class Loader extends Component {
  static showLoader() {
    document.getElementById("ftco-loader").classList.add('show');
  }
  static closeLoader() {
    document.getElementById("ftco-loader").classList.remove('show');
  }
  render() {
    return (
      <div id="ftco-loader" className="fullscreen">
        <svg className="circular" width="48px" height="48px">
          <circle className="path-bg" cx="24" cy="24" r="22" fill="none" strokeWidth="4" stroke="#eeeeee" />
          <circle className="path" cx="24" cy="24" r="22" fill="none" strokeWidth="4" strokeMiterlimit="10" stroke="#F96D00" />
        </svg>
      </div>
    );
  }
}

export default Loader;
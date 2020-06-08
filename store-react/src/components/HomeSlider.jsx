import React, { Component } from 'react';
import { Link } from 'react-router-dom'
import OwlCarousel from 'react-owl-carousel';
import 'owl.carousel/dist/assets/owl.carousel.min.css';;

const contents = [
  { background: "/images/slider_bg_1.jpg", subTitle: "Welcome", title: "The Best Coffee Testing Experience", content: "A small river named Duden flows by their place and supplies it with the necessary regelialia." },
  { background: "/images/slider_bg_2.jpg", subTitle: "Welcome", title: "The Best Coffee Testing Experience", content: "A small river named Duden flows by their place and supplies it with the necessary regelialia." },
  { background: "/images/slider_bg_3.jpg", subTitle: "Welcome", title: "The Best Coffee Testing Experience", content: "A small river named Duden flows by their place and supplies it with the necessary regelialia." },
]

class HomeSlider extends Component {
  render() {
    return (
      <OwlCarousel className="home-slider" loop autoplay items={1} autoplayTimeout={5000} smartSpeed={1000}>
        {contents.map((content, key) => {
          return (
            <div key={key} className="slider-item" style={{ backgroundImage: `url(${content.background})`, }}>
              <div className="overlay"></div>
              <div className="container">
                <div className="row slider-text justify-content-center align-items-center" data-scrollax-parent="true">
                  <div className="col-md-8 col-sm-12 text-center" >
                    <span className="subheading">{content.subTitle}</span>
                    <h1 className="mb-4">{content.title}</h1>
                    <p className="mb-4 mb-md-5">{content.content}</p>
                    <p>
                      <Link to="/cart" className="btn btn-primary p-3 px-xl-4 py-xl-3"
                        onClick={() => window.scrollTo({ top: window.innerHeight - 60, behavior: 'smooth' })}
                      >
                        Order Now
                      </Link>
                      {" "}
                      <Link to="/menu" className="btn btn-white btn-outline-white p-3 px-xl-4 py-xl-3"
                        onClick={() => window.scrollTo({ top: window.innerHeight - 60, behavior: 'smooth' })}
                      >
                        View Menu
                      </Link>
                    </p>
                  </div>
                </div>
              </div>
            </div>
          );
        })}
      </OwlCarousel>
    );
  }
}

export default HomeSlider;
import React, { Component } from 'react';

const contents = [
  { icon: "flaticon-choices", title: "Easy to Order", description: "Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic." },
  { icon: "flaticon-delivery-truck", title: "Fastest Delivery", description: "Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic." },
  { icon: "flaticon-coffee-bean", title: "Quality Coffee", description: "Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic." },
];

class ServiceSection extends Component {
  render() {
    return (
      <section className="ftco-section ftco-services">
        <div className="container">
          <div className="row">
            {contents.map((value, key) => {
              return (
                <div key={key} className="col-md-4">
                  <div className="media d-block text-center block-6 services">
                    <div className="icon d-flex justify-content-center align-items-center mb-5">
                      <span className={value.icon}></span>
                    </div>
                    <div className="media-body">
                      <h3 className="heading">{value.title}</h3>
                      <p>{value.description}</p>
                    </div>
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      </section>
    );
  }
}

export default ServiceSection;
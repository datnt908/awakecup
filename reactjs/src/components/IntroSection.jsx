import React, { Component } from 'react';

const contents = {
  phone: { title: "Always-on support", content: "Delivery 1800 6936 (07:00-21:00) Support 02871 087 088 (07:00-21:00)" },
  location: { title: "Location address", content: "Khu phố 6, P.Linh Trung, Q.Thủ Đức, Tp.Hồ Chí Minh." },
  time: { title: "Working time", content: "Open Monday-Friday\n8:00am - 9:00pm" },
}

class IntroSection extends Component {
  render() {
    return (
      <section className="ftco-intro">
        <div className="container-wrap">
          <div className="wrap d-md-flex align-items-xl-end">
            <div className="info">
              <div className="row no-gutters">
                <div className="col-md-4 d-flex fadeInUpd">
                  <div className="icon"><i className="fas fa-phone"></i></div>
                  <div className="text">
                    <h3>{contents.phone.title}</h3>
                    <p>{contents.phone.content}</p>
                  </div>
                </div>
                <div className="col-md-4 d-flex fadeInUpd">
                  <div className="icon"><i className="fas fa-map-marker-alt"></i></div>
                  <div className="text">
                    <h3>{contents.location.title}</h3>
                    <p>{contents.location.content}</p>
                  </div>
                </div>
                <div className="col-md-4 d-flex fadeInUpd">
                  <div className="icon"><i className="fas fa-clock"></i></div>
                  <div className="text">
                    <h3>{contents.time.title}</h3>
                    <p>{contents.time.content}</p>
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

export default IntroSection;
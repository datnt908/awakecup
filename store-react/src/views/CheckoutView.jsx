import React, { Component } from 'react';
import { Link } from 'react-router-dom';

import { connect } from 'react-redux';

import { showAlert } from '../utils/helpers';
import Loader from '../components/Loader';

class CheckoutView extends Component {
  state = {
    provinces: [],
    districts: [],
    communes: [],
  }

  componentDidMount() {
    this.handleAddressSelect(null, 'Tỉnh/Thành');
  }

  handleAddressSelect(fatherID, level) {
    if (0 === fatherID) {
      if ('Tỉnh/Thành' === level)
        this.setState({ provinces: [] });
      if ('Quận/Huyện' === level)
        this.setState({ districts: [] });
      if ('Phường/Xã' === level)
        this.setState({ communes: [] });
      return;
    }
    window.AdminDivAPIsService_Query({ FatherID: fatherID, Level: level, Sorting: 'Name ASC', PageSize: 50 })
      .then(result => {
        if ('Tỉnh/Thành' === level)
          this.setState({ provinces: result.json.result.items });
        if ('Quận/Huyện' === level)
          this.setState({ districts: result.json.result.items });
        if ('Phường/Xã' === level)
          this.setState({ communes: result.json.result.items });
      })
      .catch(error => console.log(error));
  }

  handlePlaceOrder() {
    const formData = getFormData();
    if (!checkFormData(formData)) {
      showAlert('Invalid Info', 'Your input information is too long');
      return;
    }
    Loader.showLoader();
    const requestBody = convertOrderCreateData(formData, this.props.cart);
    window.OrderAPIsService_Create(requestBody)
      .then(result => {
        showAlert(result.json.error.message, result.json.error.detail);
        if (200 === result.statusCode)
          document.getElementById('order-id').value = result.json.result;
        Loader.closeLoader();
      })
      .catch(error => console.log(error));
  }

  render() {
    return (
      <section className="ftco-section">
        <div className="container">
          <div className="row">
            <div className="col-xl-8 mb-4">
              <form className="billing-form ftco-bg-dark p-3 p-md-5">
                <h3 className="mb-4 billing-heading">Billing Information</h3>
                <div className="row align-items-end">
                  <div className="col-md-6">
                    <div className="form-group">
                      <label form="firstname">First Name</label>
                      <input id="firstname" type="text" className="form-control" placeholder="" />
                    </div>
                  </div>
                  <div className="col-md-6">
                    <div className="form-group">
                      <label form="lastname">Last Name</label>
                      <input id="lastname" type="text" className="form-control" placeholder="" />
                    </div>
                  </div>
                  <div className="col-md-12">
                    <div className="form-group">
                      <label form="country">Province</label>
                      <div className="select-wrap">
                        <div className="icon"><i className="fas fa-chevron-down"></i></div>
                        <select id="province" name="" className="form-control"
                          onChange={e => this.handleAddressSelect(e.target.value, "Quận/Huyện")}
                        >
                          <option value={0}></option>
                          {this.state.provinces.map((value, key) => {
                            return (<option key={key} value={value.id}>{value.name}</option>);
                          })}
                        </select>
                      </div>
                    </div>
                  </div>
                  <div className="col-md-6">
                    <div className="form-group">
                      <label form="country">District</label>
                      <div className="select-wrap">
                        <div className="icon"><i className="fas fa-chevron-down"></i></div>
                        <select id="district" name="" className="form-control"
                          onChange={e => this.handleAddressSelect(e.target.value, "Phường/Xã")}
                        >
                          <option value={0}></option>
                          {this.state.districts.map((value, key) => {
                            return (<option key={key} value={value.id}>{value.name}</option>);
                          })}
                        </select>
                      </div>
                    </div>
                  </div>
                  <div className="col-md-6">
                    <div className="form-group">
                      <label form="country">Commune</label>
                      <div className="select-wrap">
                        <div className="icon"><i className="fas fa-chevron-down"></i></div>
                        <select id="commune" name="" className="form-control">
                          <option value={0}></option>
                          {this.state.communes.map((value, key) => {
                            return (<option key={key} value={value.id}>{value.name}</option>);
                          })}
                        </select>
                      </div>
                    </div>
                  </div>
                  <div className="col-md-6">
                    <div className="form-group">
                      <label form="streetaddress">Street Address</label>
                      <input id="address" type="text" className="form-control" placeholder="House number and street name" />
                    </div>
                  </div>
                  <div className="col-md-6">
                    <div className="form-group">
                      <input id="address-note" type="text" className="form-control" placeholder="Appartment, suite, unit etc: (optional)" />
                    </div>
                  </div>
                  <div className="col-md-12">
                    <p className="text-primary">*Vui lòng ghi nhớ thông tin dưới đây để xác nhận đơn hàng</p>
                  </div>
                  <div className="col-md-6">
                    <div className="form-group">
                      <label form="phone">Phone</label>
                      <input id="phone" type="tel" className="form-control" placeholder=""
                        onKeyPress={(e) => { if (!/[0-9 ]/.test(e.key)) e.preventDefault(); }}
                      />
                    </div>
                  </div>
                  <div className="col-md-6">
                    <div className="form-group">
                      <label form="order-id">Order ID</label>
                      <input id="order-id" type="text" className="form-control" placeholder="" disabled />
                    </div>
                  </div>
                </div>
              </form>
            </div>
            <div className="col-xl-4">
              <div className="row mx-0">
                <div className="cart-detail cart-total ftco-bg-dark p-3 p-md-4 col-xl-12 col-md-6">
                  <h3 className="billing-heading mb-4">Cart Total</h3>
                  <p className="d-flex"><span>Subtotal</span><span>{this.props.cart.subtotal} Đ</span></p>
                  <p className="d-flex"><span>Delivery</span><span>{this.props.cart.delivery} Đ</span></p>
                  <p className="d-flex"><span>Discount</span><span>{this.props.cart.discount} Đ</span></p>
                  <hr />
                  <p className="d-flex total-price"><span>Total</span><span>{this.props.cart.total} Đ</span></p>
                </div>
                <div className="cart-detail ftco-bg-dark p-3 p-md-4 col-xl-12 col-md-6">
                  <h3 className="billing-heading mb-4">Payment Method</h3>
                  <div className="form-group">
                    <div className="col-md-12">
                      <div className="radio">
                        <label>
                          <input type="radio" name="optradio" className="mr-2" checked onChange={() => { }} />
                        Thanh toán khi giao hàng
                      </label>
                      </div>
                    </div>
                  </div>
                  <p>
                    <Link to="/checkout" className="btn btn-primary py-3 px-4"
                      onClick={e => { e.preventDefault(); this.handlePlaceOrder(); }}
                    >
                      Place an order
                  </Link>
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    );
  }
}

const mapStateToProps = (state) => ({
  cart: state.cart,
});

export default connect(mapStateToProps, null)(CheckoutView);

function convertOrderCreateData(formdata, cart) {
  const cartDetails = cart.cartDetails.map(item => ({
    productID: item.product.id,
    price: item.product.price,
    quantity: item.quantity,
    total: item.total,
  }))
  const requestBody = {
    ...formdata,
    cart: {
      ...cart,
      cartDetails: cartDetails,
    },
  }
  return requestBody;
}

function getFormData() {
  const formdata = {
    firstname: document.getElementById('firstname').value,
    lastname: document.getElementById('lastname').value,
    phone: document.getElementById('phone').value,
    provinceID: parseInt(document.getElementById('province').value, 10),
    districtID: parseInt(document.getElementById('district').value, 10),
    communeID: parseInt(document.getElementById('commune').value, 10),
    address: document.getElementById('address').value,
    note: document.getElementById('address-note').value,
  }

  return formdata;
}

function checkFormData(formdata) {
  if (
    formdata.firstname.length > 32 ||
    formdata.lastname.length > 32 ||
    formdata.address.length > 256 ||
    formdata.note.length > 256 ||
    formdata.phone.length > 16
  )
    return false;
  return true;
}
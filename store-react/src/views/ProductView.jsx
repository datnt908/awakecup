import React, { Component } from 'react'

// core components
import RelatedSection from '../components/Cart/RelatedSection'
//
import store from '../redux/store'
import { addProductToCart } from '../redux/actions/cartActions';
import { DOMAIN } from '../utils/helpers'

export default class ProductView extends Component {
  render() {
    return (
      <>
        <section className="ftco-section">
          <div className="container">
            <ProductDetail productCode={this.props.match.params.productCode} />
          </div>
        </section >
        <RelatedSection productCode={this.props.match.params.productCode} />
      </>
    )
  }
}

function ProductDetail(props) {
  const [product, setProduct] = React.useState(null);

  React.useEffect(() => {
    window.ProductAPIsService_Search({ Code: props.productCode })
      .then(result => setProduct(result.json.result.items[0]))
      .catch(error => console.log(error));
  }, [props.productCode]);

  return (
    <>
      {!product &&
        <div className="row justify-content-center mb-5 pb-3">
          <div className="col-md-7 heading-section text-center">
            <h2 className="mb-4">Product Not Found</h2>
          </div>
        </div>
      }
      {product &&
        <div className="row">
          <div className="cl"></div>
          <div className="col-lg-6 mb-5 ftco-animate">
            <img className="w-100" src={`${DOMAIN}/${product.imageURL}`} alt={props.productCode} />
          </div>
          <div className="col-lg-6 product-details pl-md-5 ftco-animate">
            <h3>{product.title}</h3>
            <p className="price"><span>{product.price} Đ</span></p>
            <p style={{ textAlign: 'justify' }}>{product.description}</p>
            <p>
              <a href="/" className="btn btn-primary py-3 px-5"
                onClick={e => {
                  e.preventDefault();
                  handleAddProductToCart(product);
                }}
              >
                Add to Cart
              </a>
            </p>
          </div>
        </div>
      }
    </>
  );
}

function handleAddProductToCart(product) {
  store.dispatch(addProductToCart(product));
};
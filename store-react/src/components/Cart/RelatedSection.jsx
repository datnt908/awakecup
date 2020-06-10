import React from 'react';

import { getRandomProducts } from '../../utils/helpers';

// core component
import Product from '../Product';

const contents = {
  description: "Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts."
}

export default function RelatedSection(props) {
  const [products, setProducts] = React.useState([]);

  React.useEffect(() => {
    window.ProductAPIsService_Search({ PageSize: 50 })
      .then(result => setProducts(getRandomProducts(result.json.result.items)))
      .catch(error => console.log(error));
  }, [props.productCode]);

  return (
    <section className="ftco-section">
      <div className="container">
        <div className="row justify-content-center mb-5 pb-3">
          <div className="col-md-7 heading-section text-center">
            <span className="subheading">Discover</span>
            <h2 className="mb-4">Related Products</h2>
            <p>{contents.description}</p>
          </div>
        </div>
        <div className="row">
          {products.map((value, key) => {
            return (
              <div key={key} className="col-md-6 col-lg-3 mb-5 pb-3">
                <Product product={value} />
              </div>
            );
          })}
        </div>
      </div>
    </section>
  )
}

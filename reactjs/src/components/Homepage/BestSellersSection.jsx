import React, { Component } from 'react';
import { ProductAPIsService } from '../../utils/apiCalling';
import { getRndInteger } from '../../utils/helpers';

// core component
import Product from '../Product';

const contents = {
  description: "Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts."
}

class BestSellersSection extends Component {
  state = { products: [] }

  componentDidMount() {
    ProductAPIsService.search('', '', '', '', '', '', '', '', '', '', 1, 50)
      .then(response => response.json())
      .then(json => {
        this.setState({ products: getRandomProducts(json.result.items) });
      })
      .catch(error => console.log(error));
  }

  render() {
    return (
      <section className="ftco-section">
        <div className="container">
          <div className="row justify-content-center mb-5 pb-3">
            <div className="col-md-7 heading-section ftco-animate text-center">
              <span className="subheading">Discover</span>
              <h2 className="mb-4">Best Coffee Sellers</h2>
              <p>{contents.description}</p>
            </div>
          </div>
          <div className="row">
            {this.state.products.map((value, key) => {
              return (
                <div key={key} className="col-md-6 col-lg-3 mb-5 pb-3">
                  <Product product={value} />
                </div>
              );
            })}
          </div>
        </div>
      </section>
    );
  }
}

function getRandomProducts(products) {
  if (0 === products.length) return [];
  const randIndexs = [];
  const randProducts = [];
  const numberOfIndexs = 4;
  for (let index = 0; index < numberOfIndexs; index++) {
    let rndIndex = getRndInteger(0, products.length - 1);
    while (0 <= randIndexs.indexOf(rndIndex))
      rndIndex = getRndInteger(0, products.length - 1);
    randIndexs.push(rndIndex);
    randProducts.push(products[rndIndex]);
  }
  return randProducts;
}

export default BestSellersSection;
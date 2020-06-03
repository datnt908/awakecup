import React from 'react';
import ReactDOM from 'react-dom';

export const DOMAIN = 'http://localhost:5000';

export function serializeQueryString(obj) {
    var str = [];
    for (var p in obj)
        if (obj.hasOwnProperty(p)) {
            str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
        }
    return str.join("&");
}

export function getRndInteger(min, max) {
    return Math.floor(Math.random() * (max - min)) + min;
}

export function showAlert(message, detail) {
    const value = <><b>{message}</b> {detail}</>
    const alert = document.getElementById('alert');
    ReactDOM.render(value, alert);
    alert.classList.remove('d-none');
    setTimeout(() => alert.classList.add('d-none'), 4000);
}

export function getRandomProducts(products) {
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
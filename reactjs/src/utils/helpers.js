import React from 'react';
import ReactDOM from 'react-dom';

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

export function padIntWithZeros(number, width) {
    width -= number.toString().length;
    if (width > 0) {
        return new Array(width + (/\./.test(number) ? 2 : 1)).join('0') + number;
    }
    return number + ""; // always return a string
}
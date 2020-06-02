import crypto from 'crypto';

export const DOMAIN = 'http://localhost:5000';

export function hashToSHA1(string) {
    const shaEncoder = crypto.createHash('sha1');
    shaEncoder.update(string);
    const sha1String = shaEncoder.digest('hex');
    return sha1String;
}

export function getCookiesValue(key) {
    var equalities = document.cookie.split('; ');
    for (var i = 0; i < equalities.length; i++) {
        if (!equalities[i])
            continue;
        var splitted = equalities[i].split('=');
        if (splitted.length !== 2)
            continue;
        if (decodeURIComponent(splitted[0]) === key)
            if (splitted[1])
                return decodeURIComponent(splitted[1]);
    }
    return null;
}

export function setCookiesValue(key, value) {
    if (!key) return;
    var cookieValue = encodeURIComponent(key) + '=';
    if (value)
        cookieValue = cookieValue + encodeURIComponent(value);
    document.cookie = cookieValue + "; path=/";
}

export function serializeQueryString(obj) {
    var str = [];
    for (var p in obj)
        if (obj.hasOwnProperty(p)) {
            str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
        }
    return str.join("&");
}
import { getCookiesValue, hashToSHA1, serializeQueryString } from "./helper";

export const DOMAIN = "http://localhost:5000";

export class AccountAPIsService {
    static async signIn(username, password) {
        var myHeaders = new Headers();
        myHeaders.append("Content-Type", "application/json");

        var raw = JSON.stringify({ username, sha1Pass: hashToSHA1(password) });
        var requestOptions = { method: 'POST', headers: myHeaders, body: raw, redirect: 'follow' };
        const apiEndpoint = `${DOMAIN}/Accounts/SignIn`;

        try {
            const response = await fetch(apiEndpoint, requestOptions);
            switch (response.status) {
                case 200:
                case 401:
                case 404:
                case 500:
                    return response;

                default:
                    throw response;
            }
        } catch (error) {
            throw error;
        }
    }

    static async checkAuth() {
        var myHeaders = new Headers();
        myHeaders.append("Authorization", `Bearer ${getCookiesValue("authToken")}`);
        myHeaders.append("Content-Type", "application/json");

        var requestOptions = { method: 'GET', headers: myHeaders, redirect: 'follow' };
        const apiEndpoint = `${DOMAIN}/Accounts/CheckAuth`;

        try {
            const response = await fetch(apiEndpoint, requestOptions);
            switch (response.status) {
                case 200:
                    return response;

                default:
                    throw response;
            }
        } catch (error) {
            throw error;
        }
    }
}

export class ProductAPIsService {
    static async search(id, code, title, description, categoryID, price, imageURL, recordStatus, search, sorting, pageNo, pageSize) {
        const filter = {
            ID: id ? id : '',
            Code: code ? code : '',
            Title: title ? title : '',
            Description: description ? description : '',
            CategoryID: categoryID ? categoryID : '',
            Price: price ? price : '',
            ImageURL: imageURL ? imageURL : '',
            RecordStatus: recordStatus ? recordStatus : '',
            Search: search ? search : '',
            Sorting: sorting ? sorting : '',
            PageNo: pageNo ? pageNo : 1,
            PageSize: pageSize ? pageSize : 25,
        };

        const requestOptions = {
            method: 'GET',
            redirect: 'follow'
        };

        const queryString = serializeQueryString(filter);
        const apiEndpoint = `${DOMAIN}/Products/Search`;

        try {
            const response = await fetch(`${apiEndpoint}?${queryString}`, requestOptions)
            switch (response.status) {
                case 200:
                    return response;

                default:
                    throw response;
            }
        } catch (error) {
            throw error;
        }
    }
}

export class CategoryAPIsService {
    static async search(id, title, search, sorting, pageNo, pageSize) {
        const filter = {
            ID: id ? id : '',
            Title: title ? title : '',
            Search: search ? search : '',
            Sorting: sorting ? sorting : '',
            PageNo: pageNo ? pageNo : 1,
            PageSize: pageSize ? pageSize : 25,
        };

        const requestOptions = {
            method: 'GET',
            redirect: 'follow'
        };

        const queryString = serializeQueryString(filter);
        const apiEndpoint = `${DOMAIN}/Categories/Search`;

        try {
            const response = await fetch(`${apiEndpoint}?${queryString}`, requestOptions)
            switch (response.status) {
                case 200:
                    return response;

                default:
                    throw response;
            }
        } catch (error) {
            throw error;
        }
    }
}
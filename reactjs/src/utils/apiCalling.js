import { serializeQueryString } from './helpers';

export const DOMAIN = "http://localhost:5000";


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
            PageNo: pageNo ? pageNo : '',
            PageSize: pageSize ? pageSize : '',
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
            PageNo: pageNo ? pageNo : '',
            PageSize: pageSize ? pageSize : '',
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
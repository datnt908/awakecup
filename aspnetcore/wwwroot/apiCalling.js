const DOMAIN = 'http://localhost:5000';

function serializeQueryString(obj) {
    var str = [];
    for (var p in obj)
        if (obj.hasOwnProperty(p)) {
            if (null != obj[p])
                str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
        }
    return str.join("&");
}

async function AccountAPIsService_Query(queryObject) {
    var requestOptions = {
        method: 'GET',
        redirect: 'follow'
    };

    const queryString = serializeQueryString(queryObject);
    const apiEndpoint = `${DOMAIN}/Accounts/Query`;

    try {
        const response = await fetch(`${apiEndpoint}?${queryString}`, requestOptions);
        switch (response.status) {
            case 200:
                const json = await response.json();
                return { statusCode: response.status, json };
            default:
                throw response;
        }
    } catch (error) {
        throw error;
    }
}

async function AdminDivAPIsService_Query(queryObject) {
    var requestOptions = {
        method: 'GET',
        redirect: 'follow'
    };

    const queryString = serializeQueryString(queryObject);
    const apiEndpoint = `${DOMAIN}/AdminDivs/Query`;

    try {
        const response = await fetch(`${apiEndpoint}?${queryString}`, requestOptions);
        switch (response.status) {
            case 200:
                const json = await response.json();
                return { statusCode: response.status, json };
            default:
                throw response;
        }
    } catch (error) {
        throw error;
    }
}


async function CartAPIsService_Query(queryObject) {
    var requestOptions = {
        method: 'GET',
        redirect: 'follow'
    };

    const queryString = serializeQueryString(queryObject);
    const apiEndpoint = `${DOMAIN}/Carts/Query`;

    try {
        const response = await fetch(`${apiEndpoint}?${queryString}`, requestOptions);
        switch (response.status) {
            case 200:
                const json = await response.json();
                return { statusCode: response.status, json };
            default:
                throw response;
        }
    } catch (error) {
        throw error;
    }
}

async function CategoryAPIsService_Query(queryObject) {
    var requestOptions = {
        method: 'GET',
        redirect: 'follow'
    };

    const queryString = serializeQueryString(queryObject);
    const apiEndpoint = `${DOMAIN}/Categories/Query`;

    try {
        const response = await fetch(`${apiEndpoint}?${queryString}`, requestOptions);
        switch (response.status) {
            case 200:
                const json = await response.json();
                return { statusCode: response.status, json };
            default:
                throw response;
        }
    } catch (error) {
        throw error;
    }
}

async function OrderAPIsService_Query(queryObject) {
    var requestOptions = {
        method: 'GET',
        redirect: 'follow'
    };

    const queryString = serializeQueryString(queryObject);
    const apiEndpoint = `${DOMAIN}/Orders/Query`;

    try {
        const response = await fetch(`${apiEndpoint}?${queryString}`, requestOptions);
        switch (response.status) {
            case 200:
                const json = await response.json();
                return { statusCode: response.status, json };
            default:
                throw response;
        }
    } catch (error) {
        throw error;
    }
}

async function OrderStatusAPIsService_Query(queryObject) {
    var requestOptions = {
        method: 'GET',
        redirect: 'follow'
    };

    const queryString = serializeQueryString(queryObject);
    const apiEndpoint = `${DOMAIN}/OrderStatuses/Query`;

    try {
        const response = await fetch(`${apiEndpoint}?${queryString}`, requestOptions);
        switch (response.status) {
            case 200:
                const json = await response.json();
                return { statusCode: response.status, json };
            default:
                throw response;
        }
    } catch (error) {
        throw error;
    }
}

async function ProductAPIsService_Query(queryObject) {
    var requestOptions = {
        method: 'GET',
        redirect: 'follow'
    };

    const queryString = serializeQueryString(queryObject);
    const apiEndpoint = `${DOMAIN}/Products/Query`;

    try {
        const response = await fetch(`${apiEndpoint}?${queryString}`, requestOptions);
        switch (response.status) {
            case 200:
                const json = await response.json();
                return { statusCode: response.status, json };
            default:
                throw response;
        }
    } catch (error) {
        throw error;
    }
}

async function ProductAPIsService_Search(queryObject) {
    var requestOptions = {
        method: 'GET',
        redirect: 'follow'
    };

    const queryString = serializeQueryString(queryObject);
    const apiEndpoint = `${DOMAIN}/Products/Search`;

    try {
        const response = await fetch(`${apiEndpoint}?${queryString}`, requestOptions);
        switch (response.status) {
            case 200:
                const json = await response.json();
                return { statusCode: response.status, json };
            default:
                throw response;
        }
    } catch (error) {
        throw error;
    }
}

async function OrderAPIsService_Create(requestBody) {
    var myHeaders = new Headers();
    myHeaders.append("Content-Type", "application/json");

    var raw = JSON.stringify(requestBody);

    var requestOptions = {
        method: 'POST',
        headers: myHeaders,
        body: raw,
        redirect: 'follow'
    };

    const apiEndpoint = `${DOMAIN}/Orders/Create`;

    try {
        const response = await fetch(apiEndpoint, requestOptions);
        switch (response.status) {
            case 200:
            case 400:
            case 404:
            case 500:
                const json = await response.json();
                return { statusCode: response.status, json };
            default:
                throw response;
        }
    } catch (error) {
        throw error;
    }
}

async function AccountAPIsService_Authenticate(requestBody) {
    var myHeaders = new Headers();
    myHeaders.append("Content-Type", "application/json");

    var raw = JSON.stringify(requestBody);
    var requestOptions = {
        method: 'POST',
        headers: myHeaders,
        body: raw,
        redirect: 'follow'
    };

    const apiEndpoint = `${DOMAIN}/Accounts/Authenticate`;

    try {
        const response = await fetch(apiEndpoint, requestOptions);
        switch (response.status) {
            case 200:
            case 401:
            case 404:
            case 500:
                const json = await response.json();
                return { statusCode: response.status, json };

            default:
                throw response;
        }
    } catch (error) {
        throw error;
    }
}

async function AccountAPIsService_CheckAuth(token) {
    var myHeaders = new Headers();
    myHeaders.append("Authorization", `Bearer ${token}`);
    myHeaders.append("Content-Type", "application/json");

    var requestOptions = {
        method: 'GET',
        headers: myHeaders,
        redirect: 'follow'
    };

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

async function OrderAPIsService_Search(queryObject) {
    var requestOptions = {
        method: 'GET',
        redirect: 'follow'
    };

    const queryString = serializeQueryString(queryObject);
    const apiEndpoint = `${DOMAIN}/Orders/Search`;

    try {
        const response = await fetch(`${apiEndpoint}?${queryString}`, requestOptions);
        switch (response.status) {
            case 200:
                const json = await response.json();
                return { statusCode: response.status, json };
            default:
                throw response;
        }
    } catch (error) {
        throw error;
    }
}
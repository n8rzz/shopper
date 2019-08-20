import axios from 'axios';

class ApiService {
    patch(url, updatesToSend, csrf) {
        return axios.patch(url, updatesToSend, {
            headers: {
                'X-CSRF-Token': csrf,
            }
        });
    }

    post(url, dataToSend, csrf) {
        return axios.post(url, dataToSend, {
            headers: {
                'X-CSRF-Token': csrf,
            },
        });
    }

    put(url, updatesToSend, csrf) {
        return axios.put(url, updatesToSend, {
            headers: {
                'X-CSRF-Token': csrf,
            },
        });
    }

    delete(url, csrf) {
        return axios.delete(url, {
            headers: {
                'X-CSRF-Token': csrf,
            },
        });
    }
}

export default new ApiService();

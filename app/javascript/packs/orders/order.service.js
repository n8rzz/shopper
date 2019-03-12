import axios from 'axios';

class OrderService {
    get(url) {
       console.log('OrderService.get', url);
    }

    post(url) {
        console.log('OrderService.post', url);
    }

    put(url) {
       console.log('OrderService.put', url);
    }

    delete(url, csrf) {
        return axios.delete(url, {
            headers: {
                'X-CSRF-Token': csrf
            }
         });
    }
}

export default new OrderService();

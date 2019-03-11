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

    delete(url) {
        console.log('OrderService.delete', url);
    }
}

export default new OrderService();

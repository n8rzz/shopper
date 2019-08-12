import EventEmitter from 'eventemitter3';

class EventService {
    constructor() {
        this._event = new EventEmitter();
    }

    emit(eventName, args) {
        this._event.emit(eventName, args);
    }


    off(eventName, listener) {
        this._event.off(eventName, listener);
    }

    on(eventName, listener) {
        this._event.on(eventName, listener);
    }
}

export default new EventService();

export default class AssemblyItemCollection {
    get length() {
        return this._items.length;
    }

    constructor() {
        this._items = [];

        return this._init();
    }

    _init() {
        return this;
    }

    add(viewModel) {
        this._items.push(viewModel);
    }

    findById(itemId) {
        return this._items.filter((item) => item.itemId === itemId)[0];
    }
}

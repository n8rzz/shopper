import AccordionView from "./accordion.view";

export default class AccordionCollection {
    get length() {
        return this._items.length;
    }

    constructor(elementList) {
        this._items = [];

        return this._init(elementList);
    }

    _init(elementList) {
        for (let i = 0; i < elementList.length; i++) {
            const element = elementList[i];
            const viewModel = new AccordionView(element);

            this._add(viewModel);
        }

        return this;
    }

    _add(viewModel) {
        this._items.push(viewModel);
    }
}

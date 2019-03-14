import AssemblyView from "./assembly.view";

export default class AssemblyCollection {
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
            const viewModel = new AssemblyView(element);

            this._add(viewModel);
        }

        return this;
    }

    _add(viewModel) {
        this._items.push(viewModel);
    }
}

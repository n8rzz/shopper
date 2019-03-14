// import ApiService from '../service/api.service';
import AssemblyCollection from './assembly.collection';

const CLASSNAMES = {
    ROOT_ELEMENT: 'js-assemblyList',
    TRIGGER_ELEMENT: 'js-assemblyList-trigger',
};

export default class AssemblyController {
    constructor() {
        const $element = document.getElementsByClassName(CLASSNAMES.TRIGGER_ELEMENT);
        this._collection = new AssemblyCollection($element);
        this._isEnabled = false;

        if ($element.length === 0) {
            return this.disable();
        }

        return this._init()
            ._createChildren()
            ._setupHandlers()
            .enable();
    }

    _init() {
        return this;
    }

    _createChildren() {
        return this;
    }

    _setupHandlers() {
        return this;
    }

    enable() {
        if (this._isEnabled) {
            return this;
        }

        this._isEnabled = true;

        return this;
    }

    disable() {
        if (!this._isEnabled) {
            return this;
        }

        this._isEnabled = false;

        return this;
    }
}

document.addEventListener('turbolinks:load', () => {
    const assemblyController = new AssemblyController();
});

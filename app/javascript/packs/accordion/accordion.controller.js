import AccordionCollection from './accordion.collection';

const CLASSNAMES = {
    ROOT_ELEMENT: 'js-accordionList',
    TRIGGER_ELEMENT: 'js-accordionList-trigger',
};

export default class AccordionController {
    constructor() {
        const $element = document.getElementsByClassName(CLASSNAMES.TRIGGER_ELEMENT);
        this._collection = new AccordionCollection($element);
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
    const accordionController = new AccordionController();
});

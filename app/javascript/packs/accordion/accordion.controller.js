import AccordionCollection from './accordion.collection';
import AccordionView from './accordion.view';

const CLASSNAMES = {
    TRIGGER_ELEMENT: 'js-accordionList-trigger',
};

export default class AccordionController {
    constructor() {
        const $elementList = document.getElementsByClassName(CLASSNAMES.TRIGGER_ELEMENT);
        this._collection = new AccordionCollection();
        this._isEnabled = false;

        if ($elementList.length === 0) {
            return this.disable();
        }

        return this._init()
            ._setupHandlers()
            ._createChildren($elementList)
            .enable();
    }

    _init() {
        return this;
    }

    _setupHandlers() {
        this._onClickHandler = this._onClick.bind(this);

        return this;
    }

    _createChildren($elementList) {
        for (let i = 0; i < $elementList.length; i++) {
            const element = $elementList[i];
            const viewModel = new AccordionView(element, this._onClickHandler);

            this._collection.add(viewModel);
        }

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

    _onClick(event) {
        const itemId = event.currentTarget.dataset.accordionItemId;
        const foundElement = this._collection.findById(itemId);

        foundElement.toggleIsVisible();
    }
}

document.addEventListener('turbolinks:load', () => {
    const accordionController = new AccordionController();
});

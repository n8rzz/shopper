const CLASSNAME = {
    ACCORDION_ITEM_LIST: 'js-accordionItemList',
    IS_VISUALLY_HIDDEN: 'u-isVisuallyHidden'
};

export default class AccordionView {
    get id() {
        return this._id;
    }

    constructor($element, onClickHandler) {
        this._id = $element.dataset.accordionItemId;
        this._$element = $element;
        this._$accordionItemList = document.getElementsByClassName(`${CLASSNAME.ACCORDION_ITEM_LIST}-${this._id}`)[0];

        return this._init()
            ._createChildren()
            ._setupHandlers(onClickHandler)
            .enable();
    }

    _init() {
        return this;
    }

    _createChildren() {
        return this;
    }

    _setupHandlers(onClickHandler) {
        this._onClickHandler = onClickHandler;

        return this;
    }

    enable() {
        if (this._isEnabled) {
            return;
        }

        this._$element.addEventListener('click', this._onClickHandler);

        this._isEnabled = true;

        return this;
    }

    disable() {
        if (!this._isEnabled) {
            return;
        }

        this._$element.removeEventListener('click', this._onClickHandler);

        this._isEnabled = false;

        return this;
    }

    toggleIsVisible() {
        if (!this._isHidden()) {
            this._$accordionItemList.classList.add(CLASSNAME.IS_VISUALLY_HIDDEN);

            return;
        }

        this._$accordionItemList.classList.remove(CLASSNAME.IS_VISUALLY_HIDDEN);
    }

    _hasAccordionItemList() {
        return this._$accordionItemList != null;
    }

    _isHidden() {
        return this._$accordionItemList.classList.contains(CLASSNAME.IS_VISUALLY_HIDDEN);
    }
}

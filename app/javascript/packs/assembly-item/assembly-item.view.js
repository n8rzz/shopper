export default class AssemblyItemView {
    get assemblyId() {
        return this._assemblyId;
    }

    get itemId() {
        return this._itemId;
    }

    constructor($element, onClickHandler) {
        this._$element = $element;
        this._assemblyId = $element.dataset.assemblyId;
        this._itemId = $element.dataset.assemblyItemId;
        this._isEnabled = false;

        if (this._$element == null) {
            return this.disable();
        }

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
}

const CLASSNAME = {
    ASSEMBLY_ITEM_LIST: 'js-asemblyItemList',
    IS_VISUALLY_HIDDEN: 'u-isVisuallyHidden'
};

export default class AssemblyView {
    constructor($element) {
        const elementId = $element.dataset.assemblyItemId;
        this._$element = $element;
        this._$assemblyItemList = document.getElementsByClassName(`${CLASSNAME.ASSEMBLY_ITEM_LIST}-${elementId}`)[0];

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
        this._onClickHandler = this._onClick.bind(this);

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

    _onClick(event) {
        if (!this._hasAssemblyItemList()) {
            return;
        }

        if (!this._isHidden()) {
            this._$assemblyItemList.classList.add(CLASSNAME.IS_VISUALLY_HIDDEN);

            return;
        }

        this._$assemblyItemList.classList.remove(CLASSNAME.IS_VISUALLY_HIDDEN);
    }

    _hasAssemblyItemList() {
        return this._$assemblyItemList != null;
    }

    _isHidden() {
        return this._$assemblyItemList.classList.contains(CLASSNAME.IS_VISUALLY_HIDDEN);
    }
}

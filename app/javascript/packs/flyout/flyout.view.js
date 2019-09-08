import ViewAbstract from '../abstract/view.abstract';

const CLASSNAME = {
    ROOT_ELEMENT: 'js-flyout',
    TRIGGER_ELEMENT: 'js-flyout-trigger',
    IS_HIDDEN: 'mix-flyout_isHidden',
};

export default class FlyoutView extends ViewAbstract {
    constructor($element) {
        super($element);

        return this.enable();
    }

    toggleIsVisible() {
        if (!this._isEnabled) {
            return;
        }

        if (!this._isHidden()) {
            this._$element.classList.add(CLASSNAME.IS_HIDDEN);

            return;
        }

        this._$element.classList.remove(CLASSNAME.IS_HIDDEN);
    }

    _isHidden() {
        return this._$element.classList.contains(CLASSNAME.IS_HIDDEN);
    }
}

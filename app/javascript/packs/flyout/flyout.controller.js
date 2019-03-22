import FlyoutView from './flyout.view';

const CLASSNAMES = {
    ROOT_ELEMENT: 'js-flyout',
    TRIGGER_ELEMENT: 'js-flyout-trigger',
};

export default class FlyoutController {
    constructor() {
        const $element = document.getElementsByClassName(CLASSNAMES.ROOT_ELEMENT)[0];
        this._view = new FlyoutView($element);
        this._$triggerElementList = document.getElementsByClassName(CLASSNAMES.TRIGGER_ELEMENT);
        this._isEnabled = false;

        if ($element == null) {
            return this.disable();
        }

        return this._init()
            ._setupHandlers()
            ._createChildren()
            .enable();
    }

    _init() {
        return this;
    }

    _setupHandlers() {
        this._onClickHandler = this._onClick.bind(this);

        return this;
    }

    _createChildren() {
        return this;
    }

    enable() {
        if (this._isEnabled) {
            return this;
        }

        for (let i = 0; i < this._$triggerElementList.length; i++) {
            const element = this._$triggerElementList[i];

            element.addEventListener('click', this._onClickHandler);
        }

        this._isEnabled = true;

        return this;
    }

    disable() {
        if (!this._isEnabled) {
            return this;
        }

        for (let i = 0; i < this._$triggerElementList.length; i++) {
            const element = this._$triggerElementList[i];

            element.removeEventListener('click', this._onClickHandler);
        }

        this._isEnabled = false;

        return this;
    }

    _onClick(event) {
        event.preventDefault();
        event.stopPropagation();

        this._view.toggleIsVisible();
    }
}


document.addEventListener('turbolinks:load', () => {
    const flyoutController = new FlyoutController();
});

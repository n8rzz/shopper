import ViewAbstract from '../abstract/view.abstract';

const CLASSNAME = {
    IS_VISUALLY_HIDDEN: 'u-isVisuallyHidden'
};

export default class FlashView extends ViewAbstract {
    constructor($element) {
        super($element);

        return this;
    }

    hide() {
        if (this.isVisuallyHidden()) {
            return;
        }

        this._$element.classList.add(CLASSNAME.IS_VISUALLY_HIDDEN);
    }

    show() {
        if (!this.isVisuallyHidden()) {
            return;
        }

        this._$element.classList.remove(CLASSNAME.IS_VISUALLY_HIDDEN);
    }

    showWithMessage(msg) {
        this._$element.textContent = msg;

        this.show();
    }

    isVisuallyHidden() {
        return this._$element.classList.contains(CLASSNAME.IS_VISUALLY_HIDDEN);
    }
}

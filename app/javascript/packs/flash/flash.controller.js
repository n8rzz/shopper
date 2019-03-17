import FlashView from './flash.view';

const CLASSNAME = {
    NOTICE: 'js-notice'
}

const DEAFULT_REMOVAL_DELAY = 7000;

export default class FlashController {
    constructor() {
        const $element = document.getElementsByClassName(CLASSNAME.NOTICE)[0];
        this._timer = null;

        return this._init()
            ._createChildren($element)
            ._setupHandlers()
            ._enable();
    }

    _init() {
        return this;
    }

    _setupHandlers() {
        this._onHideViewElementHandler = this._onHideViewElement.bind(this);

        return this;
    }

    _createChildren($element) {
        this._view = new FlashView($element);

        return this;
    }

    _enable() {
        if (!this._view.isVisuallyHidden()) {
            this._createRemovalTimer();
        }

        return this;
    }

    showNoticeMessage(msg) {
        this._view.showWithMessage(msg);
        this._createRemovalTimer(DEAFULT_REMOVAL_DELAY);
    }

    showNoticeMessageWithTimeout(msg, delay = DEAFULT_REMOVAL_DELAY) {
        this._view.showWithMessage(msg);
        this._createRemovalTimer(DEAFULT_REMOVAL_DELAY);
    }

    _createRemovalTimer(delay = DEAFULT_REMOVAL_DELAY) {
        if (this._timer !== null) {
            this._timer = null;
        }

        this._timer = setTimeout(this._onHideViewElementHandler, delay);
    }

    _onHideViewElement() {
        this._view.hide();
    }
}

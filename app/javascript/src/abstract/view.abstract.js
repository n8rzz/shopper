export default class ViewAbstract {
    constructor($element) {
        this._$element = $element;
        this._isEnabled = false;

        if (this._$element == null) {
            return this.disable();
        }

        return this;
    }

    enable() {
        if (this._isEnabled) {
            return;
        }

        this._isEnabled = true;

        return this;
    }

    disable() {
        if (!this._isEnabled) {
            return;
        }

        this._isEnabled = false;

        return this;
    }
}

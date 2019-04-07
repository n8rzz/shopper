const CLASSNAMES = {
    ROOT: 'js-stepper',
    DECREASE: 'js-stepper-decrease',
    VALUE: 'js-stepper-value',
    INCREASE: 'js-stepper-increase',
    SUBMIT: 'js-stepper-submit',
};

const ACTION = {
    DECREASE: 'DECREASE',
    INCREASE: 'INCREASE',
};

/**
 * Connects to a number input with external decrease/increase
 * action elements in addition to a submit button
 *
 * accepts `onSubmitHandler` from parent
 *
 * This class is concerned with decreasin/increasing a value of
 * a number field, and submitting that current value onClick
 *
 * @class StepperView
 */
export default class StepperView {
    constructor($element, onSubmitHandler) {
        this._id = -1;
        this._$element = $element;
        this._onSubmitHandler = onSubmitHandler;

        if (!this._$element) {
            return null;
        }

        return this._createChildren()
            ._setupHandlers()
            .enable();
    }

    _createChildren() {
        this._id = parseInt(this._$element.dataset.stepperId, 10);
        this._$decreaseButton = document.getElementsByClassName(this._buildClassnameWithId(CLASSNAMES.DECREASE))[0];
        this._$increaseButton = document.getElementsByClassName(this._buildClassnameWithId(CLASSNAMES.INCREASE))[0];
        this._$valueView = document.getElementsByClassName(this._buildClassnameWithId(CLASSNAMES.VALUE))[0];
        this._$submitButton = document.getElementsByClassName(this._buildClassnameWithId(CLASSNAMES.SUBMIT))[0];

        return this;
    }

    _setupHandlers() {
        this._onClickDecreaseHandler = this._onClickDecrease.bind(this);
        this._onClickIncreaseHandler = this._onClickIncrease.bind(this);
        this._onClickSubmitHandler = this._onClickSubmit.bind(this);

        return this;
    }

    enable() {
        this._$decreaseButton.addEventListener('click', this._onClickDecreaseHandler);
        this._$increaseButton.addEventListener('click', this._onClickIncreaseHandler);
        this._$submitButton.addEventListener('click', this._onClickSubmitHandler);

        return this;
    }

    _buildClassnameWithId(classname) {
        return `${classname}-${this._id}`;
    }

    _onClickDecrease(event) {
        this._updateValueView(ACTION.DECREASE);
    }

    _onClickIncrease(event) {
        this._updateValueView(ACTION.INCREASE);
    }

    _onClickSubmit(event) {
        const currentValue = parseInt(this._$valueView.value, 10);

        this._onSubmitHandler(event, currentValue);
        this._resetValue();
    }

    _resetValue() {
        this._$valueView.value = 1;
    }

    _updateValueView(action) {
        const currentValue = parseInt(this._$valueView.value, 10);
        let nextValue;

        switch(action) {
            case ACTION.DECREASE:
                if (currentValue <= 1) {
                    return;
                }

                nextValue = currentValue - 1;

                break;
            case ACTION.INCREASE:
                nextValue = currentValue + 1;

                break;
            default:
                break;
        }

        this._$valueView.value = nextValue;
    }
}

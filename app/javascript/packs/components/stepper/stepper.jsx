import React from 'react';
import PropTypes from 'prop-types';
import classnames from 'classnames';

export class Stepper extends React.Component {
    buildClassnames() {
        return classnames({
            'stepper-ft-submit': true,
            'mix-btn_isLoading': this.props.isSubmitting,
            'mix-btn_isSuccess': this.props.isSubmitSuccess,
        });
    }

    _buildStepperBody() {
        const inputId = `item-${this.props.itemId}-qty`;

        return (
            <div className={'stepper-bd'}>
                <label
                    className={'stepper-bd-label u-isVisuallyHidden'}
                    htmlFor={inputId}
                >
                    Qty
                </label>
                <span
                    className={'stepper-bd-btn js-stepper-btn-decrease'}
                    onClick={this.props.onClickDecreaseHandler}
                >
                    -
                </span>
                <input
                    className={'stepper-bd-input'}
                    type={'number'}
                    pattern={'[0-9]*'}
                    id={inputId}
                    name={`item-${this.props.itemId}-qty`}
                    min={'0'}
                    value={this.props.qty}
                    onChange={this.props.onChangeQtyHandler}
                />
                <span
                    className={'stepper-bd-btn js-stepper-btn-increase'}
                    onClick={this.props.onClickIncreaseHandler}
                >
                    +
                </span>
            </div>
        );
    }

    _buildSubmitButton() {
        let buttonValue = this.props.isSubmitting
            ? 'Adding...'
            : 'Add to order';

        if (this.props.isSubmitSuccess) {
            buttonValue = 'Success!';
        }

        return (
            <div className={'stepper-ft'}>
                <input
                    type={'submit'}
                    value={buttonValue}
                    className={this.buildClassnames()}
                />
            </div>
        );
    }

    render() {
        return (
            <form onSubmit={this.props.onClickSubmitHandler}>
                <div
                    className={'stepper'}
                    data-stepper-id={this.props.itemId}
                >
                    { this._buildStepperBody() }
                    { this._buildSubmitButton() }
                </div>
            </form>
        );
    }
}

Stepper.propTypes = {
    itemId: PropTypes.number.isRequired,
    qty: PropTypes.number.isRequired,
    isSubmitting: PropTypes.bool.isRequired,
    isSubmitSuccess: PropTypes.bool.isRequired,
    onChangeQtyHandler: PropTypes.func.isRequired,
    onClickDecreaseHandler: PropTypes.func.isRequired,
    onClickIncreaseHandler: PropTypes.func.isRequired,
    onClickSubmitHandler: PropTypes.func.isRequired,
};

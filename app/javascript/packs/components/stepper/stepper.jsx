import React from 'react';
import PropTypes from 'prop-types'
import classnames from 'classnames';

export class Stepper extends React.Component {
    constructor(props) {
        super(props);
    }

    buildClassnames(props) {
        return classnames({
            'stepper-ft-submit': true,
            'mix-btn_isLoading': this.props.isSubmitting,
            'mix-btn_isSuccess': this.props.isSubmitSuccess,
        });
    }

    render() {
        return (
            <form onSubmit={this.props.onClickSubmitHandler} >
                <div
                    className="stepper"
                    data-stepper-id={this.props.itemId}
                >
                    { this._buildStepperBody() }
                    { this._buildSubmitButton() }
                </div>
            </form>
        );
    };

    _buildStepperBody() {
        return (
            <div className="stepper-bd">
                <label
                    className="stepper-bd-label u-isVisuallyHidden"
                    htmlFor="qty"
                >
                    Qty
                </label>
                <span
                    className="stepper-bd-btn js-stepper-btn-decrease"
                    onClick={this.props.onClickDecreaseHandler}
                >
                    -
                </span>
                <input
                    className="stepper-bd-input"
                    type="number"
                    pattern="[0-9]*"
                    id={`item-${this.props.itemId}-qty`}
                    name={`item-${this.props.itemId}-qty`}
                    min="0"
                    value={this.props.qty}
                    onChange={this.props.onChangeQtyHandler}
                />
                <span
                    className="stepper-bd-btn js-stepper-btn-increase"
                    onClick={this.props.onClickIncreaseHandler}
                >
                    +
                </span>
            </div>
        );
    }

    _buildSubmitButton() {
        let buttonValue = this.props.isSubmitting
            ? "Adding..."
            : "Add to order";

        if (this.props.isSubmitSuccess) {
            buttonValue = "Success!";
        }

        return (
            <div className="stepper-ft">
                <input
                    type="submit"
                    value={buttonValue}
                    className={this.buildClassnames()}
                />
            </div>
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

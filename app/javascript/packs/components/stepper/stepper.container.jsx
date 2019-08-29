import React from 'react';
import PropTypes from 'prop-types';
import { Stepper } from './stepper';

export class StepperContainer extends React.Component {
    constructor(props) {
        super(props);

        this.onClickDecreaseHandler = this._onClickDecrease.bind(this);
        this.onClickIncreaseHandler = this._onClickIncrease.bind(this);
        this.onClickSubmitHandler = this._onClickSubmit.bind(this);

        this.state = {
            qty: 1,
        };
    }

    componentWillUnmount() {
        this.onClickDecreaseHandler = null;
        this.onClickIncreaseHandler = null;
        this.onClickSubmitHandler = null;
    }

    _onClickDecrease() {
        // eslint-disable-next-line react/no-access-state-in-setstate
        let nextQty = this.state.qty - 1;

        if (nextQty < 1) {
            nextQty = 1;
        }

        this.setState({ qty: nextQty });
    }

    _onClickIncrease() {
        this.setState((prevState) => ({ qty: prevState.qty + 1 }));
    }

    _onClickSubmit(event) {
        event.stopPropagation();
        event.preventDefault();

        if (this.state.qty < 1) {
            return;
        }

        this.props.onSubmitHandler(this.state.qty);

        this.setState({ qty: 1 });
    }

    render() {
        return (
            <Stepper
                itemId={this.props.itemId}
                qty={this.state.qty}
                isSubmitting={this.props.isSubmitting}
                isSubmitSuccess={this.props.isSubmitSuccess}
                onClickDecreaseHandler={this.onClickDecreaseHandler}
                onClickIncreaseHandler={this.onClickIncreaseHandler}
                onClickSubmitHandler={this.onClickSubmitHandler}
            />
        );
    }
}

StepperContainer.propTypes = {
    itemId: PropTypes.number.isRequired,
    isSubmitting: PropTypes.bool.isRequired,
    isSubmitSuccess: PropTypes.bool.isRequired,
    onSubmitHandler: PropTypes.func.isRequired,
};

import React from 'react';
import PropTypes from 'prop-types';

import ApiService from '../../service/api.service';
import EventService from '../../service/event.service';
import { Stepper } from './stepper';
import { EVENT_NAME } from '../../constants/event-names';

const CREATE_ORDER_ITEM_URL = '/order_items/create/item.json';

export class StepperContainer extends React.Component {
    constructor(props) {
        super(props);

        this.onChangeQtyHandler = this._onChangeQty.bind(this);
        this.onClickDecreaseHandler = this._onClickDecrease.bind(this);
        this.onClickIncreaseHandler = this._onClickIncrease.bind(this);
        this.onClickSubmitHandler = this._onClickSubmit.bind(this);
        this.onSubmitSuccessHandler = this._onSubmitSuccess.bind(this);

        this.state = {
            qty: 1,
            isSubmitting: false,
            isSubmitSuccess: false,
        };
    }

    componentWillUnmount() {
        this.onChangeQtyHandler = null;
        this.onClickDecreaseHandler = null;
        this.onClickIncreaseHandler = null;
        this.onClickSubmitHandler = null;
        this.onSubmitSuccessHandler = null;
    }

    _onChangeQty(event) {
        if (event.currentTarget.value === '') {
            return;
        }

        this.setState({ qty: event.currentTarget.value });
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

        const orderItem = {
            item_id: this.props.itemId,
            department_id: this.props.departmentId,
            qty: this.state.qty,
        };

        this.setState({ isSubmitting: true }, this._callSubmit(orderItem));
    }

    _callSubmit(orderItem) {
        ApiService.post(CREATE_ORDER_ITEM_URL, orderItem, this.props.csrf)
            .then((response) => {
                if (response.status >= 300) {
                    console.error(`
                        Received an unexpected status code from ${CREATE_ORDER_ITEM_URL}. See response: ${response}
                    `);

                    return;
                }
                // added to pending order`);
                const notice = `${this.props.itemName} added to order`;

                EventService.emit(EVENT_NAME.NOTICE_SUCCESS, notice);

                const nextState = {
                    qty: 1,
                    isSubmitting: false,
                    isSubmitSuccess: true,
                };
                this.setState(nextState, this.onSubmitSuccessHandler);
            })
            .catch((error) => {
                // TODO: add ability to set flash warning, error
                // this._flashController.showNoticeMessage('Something went wrong, Item
                // was not successfully added to Order');

                throw error;
            });
    }

    _onSubmitSuccess() {
        setTimeout(() => {
            this.setState({ isSubmitSuccess: false });
        }, 3000);
    }

    render() {
        return (
            <Stepper
                itemId={this.props.itemId}
                qty={this.state.qty}
                isSubmitting={this.state.isSubmitting}
                isSubmitSuccess={this.state.isSubmitSuccess}
                onChangeQtyHandler={this.onChangeQtyHandler}
                onClickDecreaseHandler={this.onClickDecreaseHandler}
                onClickIncreaseHandler={this.onClickIncreaseHandler}
                onClickSubmitHandler={this.onClickSubmitHandler}
            />
        );
    }
}

StepperContainer.propTypes = {
    csrf: PropTypes.string.isRequired,
    departmentId: PropTypes.number.isRequired,
    itemId: PropTypes.number.isRequired,
    itemName: PropTypes.string.isRequired,
};

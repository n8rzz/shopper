import React from 'react';
import PropTypes from 'prop-types';
import ApiService from '../service/api.service';
import EventService from '../service/event.service';
import { Item } from './item.component';
import { EVENT_NAME } from '../constants/event-names';

const CREATE_ORDER_ITEM_URL = '/order_items/create/item.json';

export class ItemContainer extends React.Component {
    constructor(props) {
        super(props);

        this._onSubmitHandler = this._onSubmit.bind(this);
        this.state = {
            isSubmitting: false,
            isSubmitSuccess: false,
        };
    }

    componentWillUnmount() {
        this._onSubmitHandler = null;
    }

    _onSubmit(qty) {
        const orderItem = {
            item_id: this.props.itemId,
            department_id: this.props.departmentId,
            qty,
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

                const notice = `${this.props.itemName} added to order`;

                EventService.emit(EVENT_NAME.NOTICE_SUCCESS, notice);

                const nextState = {
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
            <Item
                csrf={this.props.csrf}
                departmentId={this.props.departmentId}
                departmentName={this.props.departmentName}
                itemId={this.props.itemId}
                itemName={this.props.itemName}
                isSubmitting={this.state.isSubmitting}
                isSubmitSuccess={this.state.isSubmitSuccess}
                onSubmitHandler={this._onSubmitHandler}
            />
        );
    }
}

ItemContainer.propTypes = {
    csrf: PropTypes.string.isRequired,
    departmentId: PropTypes.number.isRequired,
    departmentName: PropTypes.string.isRequired,
    itemId: PropTypes.number.isRequired,
    itemName: PropTypes.string.isRequired,
};

import React from 'react';
import PropTypes from 'prop-types';
import ApiService from '../service/api.service';
import { OrderItem } from './order-item';

export class OrderItemContainer extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            isPicked: props.isPicked,
        };
    }

    componentWillMount() {
        this._onClickPickedCheckboxHandler = this._onClickPickedCheckbox.bind(this);
        this._onClickRemoveItemHandler = this._onClickRemoveItem.bind(this);
        this._onUpdatePickedSuccessHandler = this._onUpdatePickedSuccess.bind(this);
        this._onRemoveItemSuccessHandler = this._onRemoveItemSuccess.bind(this);
    }

    componentWillUnmount() {
        this._onClickPickedCheckboxHandler = null;
        this._onClickRemoveItemHandler = null;
        this._onUpdatePickedSuccessHandler = null;
        this._onRemoveItemSuccessHandler = null;
    }

    _onClickPickedCheckbox() {
        const orderItemUrl = `/order_items/${this.props.orderItemId}.json`;
        const itemUpdateToSend = {
            picked: !this.state.isPicked,
        };

        ApiService.patch(orderItemUrl, itemUpdateToSend, this.props.csrf)
            .then((response) => {
                if (response.status !== 200) {
                    console.error(`Received an unexpected status code from ${this.props.editItemUrl}. See response: ${response}`);

                    return;
                }

                this._onUpdatePickedSuccessHandler(response.data);
            })
            .catch((error) => { throw error; });
    }

    _onClickRemoveItem() {
        const orderItemUrl = `/order_items/${this.props.orderItemId}.json`;

        ApiService.delete(orderItemUrl, this.props.csrf)
            .then((response) => {
                if (response.status !== 204) {
                    console.error(`Received an unexpected status code from ${orderItemUrl}. See response: ${response}`);

                    return;
                }

                this._onRemoveItemSuccessHandler(this.props.orderItemId);
            })
            .catch((error) => { throw error; });
    }

    _onUpdatePickedSuccess() {
        this.setState((prevState) => ({ isPicked: !prevState.isPicked }));
    }

    _onRemoveItemSuccess(orderItemId) {
        console.log('+++ _onRemoveItemSuccess', orderItemId);
        console.log('--- this should bubble up and remove this item from the list ---');
    }

    render() {
        return (
            <OrderItem
                assemblyName={this.props.assemblyName}
                departmentName={this.props.departmentName}
                editItemUrl={this.props.editItemUrl}
                isPicked={this.state.isPicked}
                itemName={this.props.itemName}
                orderItemId={this.props.orderItemId}
                qty={this.props.qty}
                onClickCheckboxHandler={this._onClickPickedCheckboxHandler}
                onClickRemoveItemHandler={this._onClickRemoveItemHandler}
            />
        );
    }
}

OrderItemContainer.propTypes = {
    assemblyName: PropTypes.string.isRequired,
    csrf: PropTypes.string.isRequired,
    departmentName: PropTypes.string.isRequired,
    editItemUrl: PropTypes.string.isRequired,
    isPicked: PropTypes.bool.isRequired,
    itemName: PropTypes.string.isRequired,
    orderItemId: PropTypes.number.isRequired,
    qty: PropTypes.number.isRequired,
};

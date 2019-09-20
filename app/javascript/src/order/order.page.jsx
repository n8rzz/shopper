import React from 'react';
import PropTypes from 'prop-types';
import _keyBy from 'lodash/keyBy';
import classnames from 'classnames';
import Sticky from 'react-stickynode';
import ApiService from '../service/api.service';
import { FilterBar } from '../components/filter-bar/filter-bar.component';
import { OrderConcernGroup } from './order-concern-group.component';
import { OrderItemList } from './order-item-list.component';
import { OrderMeta } from './order-meta.component';
import { Progress } from '../components/progress/progress.component';
import {
    FILTER_CONCERN,
    FILTER_LABEL,
} from '../constants/filter-concern';

const ORDER_LIST_COMPONENT_MAP = {
    [FILTER_CONCERN.ITEM]: OrderItemList,
    [FILTER_CONCERN.DEPARTMENT]: OrderConcernGroup,
    [FILTER_CONCERN.MEAL]: OrderConcernGroup,
};

export const FILTER_BAR_ITEMS = [
    {
        text: FILTER_LABEL.ITEM,
        url: '',
    },
    {
        text: FILTER_LABEL.DEPARTMENT,
        url: '',
    },
    {
        text: FILTER_LABEL.MEAL,
        url: '',
    },
];

export class OrderPage extends React.Component {
    constructor(props) {
        super(props);

        // TODO: replace these maps with values from the BE
        // see: [#40](https://github.com/n8rzz/shopper/issues/40)
        this._assemblyMap = _keyBy(props.assemblies, 'id');
        this._departmentMap = _keyBy(props.departments, 'id');
        this._itemMap = _keyBy(props.items, 'id');
        this._onStickyStateChangeHandler = this._onStickyStateChange.bind(this);
        this._onChangeFilterHandler = this._onChangeFilter.bind(this);
        this._onClickIsPickedHandler = this._onClickIsPicked.bind(this);
        this._onUpdateIsPickedSuccessHandler = this._onUpdateIsPickedSuccess.bind(this);
        this._onClickRemoveItemHandler = this._onClickRemoveItem.bind(this);
        this._onRemoveItemSuccessHandler = this._onRemoveItemSuccess.bind(this);
        this.state = {
            concern: FILTER_CONCERN.ITEM,
            orderItems: props.orderItems,
            stickyHeaderClassnames: 'stickyHeader',
        };
    }

    componentWillUnmount() {
        this._onChangeFilterHandler = null;
        this._onClickIsPickedHandler = null;
    }

    _onStickyStateChange(event) {
        const stickyHeaderClassnames = classnames({
            stickyHeader: true,
            'mix-stickyHeader_isSticky': event.status === 2,
        });

        this.setState({ stickyHeaderClassnames });
    }

    _onChangeFilter(event) {
        event.preventDefault();

        const filterName = event.currentTarget.text.toUpperCase();

        this.setState({ concern: FILTER_CONCERN[filterName] });
    }

    _onClickIsPicked(orderItemId, isPickedState) {
        const orderItemUrl = `/order_items/${orderItemId}.json`;
        const itemUpdateToSend = {
            picked: !isPickedState,
        };

        ApiService.patch(orderItemUrl, itemUpdateToSend, this.props.csrf)
            .then((response) => {
                if (response.status !== 200) {
                    console.error(`
                        Received an unexpected status code from ${orderItemUrl}. See response: ${response}
                    `);

                    return;
                }

                this._onUpdateIsPickedSuccessHandler(response.data);
            })
            .catch((error) => { throw error; });
    }

    _onUpdateIsPickedSuccess(updatedOrderItem) {
        const updatedOrderItemIndex = this.state.orderItems.findIndex((item) => item.id === updatedOrderItem.id);

        this.setState((prevState) => {
            const nextOrderItemsState = [...prevState.orderItems];
            nextOrderItemsState[updatedOrderItemIndex] = updatedOrderItem;

            return {
                orderItems: nextOrderItemsState,
            };
        });
    }

    _onClickRemoveItem(orderItemId) {
        const orderItemUrl = `/order_items/${orderItemId}.json`;

        ApiService.delete(orderItemUrl, this.props.csrf)
            .then((response) => {
                if (response.status !== 204) {
                    console.error(`Received an unexpected status code from ${orderItemUrl}. See response: ${response}`);

                    return;
                }

                this._onRemoveItemSuccessHandler(orderItemId);
            })
            .catch((error) => { throw error; });
    }

    _onRemoveItemSuccess(orderItemId) {
        this.setState((prevState) => {
            const orderItems = prevState.orderItems.filter((orderItem) => orderItem.id !== orderItemId);

            return {
                orderItems,
            };
        });
    }

    render() {
        const OrderItemListComponent = ORDER_LIST_COMPONENT_MAP[this.state.concern];
        const pickedItems = this.state.orderItems.filter((orderItem) => orderItem.picked !== false);

        return (
            <React.Fragment>
                <OrderMeta
                    shoppingDate={this.props.order.shopping_date}
                    status={this.props.order.status}
                    locationName={this.props.orderLocation.name}
                    locationId={this.props.orderLocation.id}
                />
                <Sticky
                    enabled={true}
                    top={0}
                    onStateChange={this._onStickyStateChangeHandler}
                >
                    <div className={this.state.stickyHeaderClassnames}>
                        <Progress
                            currentCount={pickedItems.length}
                            totalCount={this.state.orderItems.length}
                        />
                        <FilterBar
                            initialSelection={'Item'}
                            items={FILTER_BAR_ITEMS}
                            onChangeFilterHandler={this._onChangeFilterHandler}
                        />
                    </div>
                </Sticky>
                <OrderItemListComponent
                    assemblies={this.props.assemblies}
                    assemblyMap={this._assemblyMap}
                    concern={this.state.concern}
                    csrf={this.props.csrf}
                    departmentMap={this._departmentMap}
                    departments={this.props.departments}
                    itemMap={this._itemMap}
                    locationDepartments={this.props.locationDepartments}
                    orderItems={this.state.orderItems}
                    onClickIsPickedHandler={this._onClickIsPickedHandler}
                    onClickRemoveItemHandler={this._onClickRemoveItemHandler}
                />
            </React.Fragment>
        );
    }
}

OrderPage.propTypes = {
    assemblies: PropTypes.array.isRequired,
    csrf: PropTypes.string.isRequired,
    departments: PropTypes.array.isRequired,
    items: PropTypes.array.isRequired,
    locationDepartments: PropTypes.array.isRequired,
    order: PropTypes.object.isRequired,
    orderItems: PropTypes.array.isRequired,
    orderLocation: PropTypes.object.isRequired,
};

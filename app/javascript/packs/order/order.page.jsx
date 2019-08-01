import React from 'react';
import PropTypes from 'prop-types';
import _keyBy from 'lodash/keyBy';
import { FilterBar } from '../components/filter-bar/filter-bar.component';
import { OrderItemList } from './order-item-list.component';
import { OrderConcernGroup } from './order-concern-group.component';
import {
    FILTER_CONCERN,
    FILTER_LABEL,
} from '../constants/filter-concern';

const ORDER_LIST_RENDERER = {
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

        this._assemblyMap = _keyBy(props.assemblies, 'id');
        this._departmentMap = _keyBy(props.departments, 'id');
        this._itemMap = _keyBy(props.items, 'id');
        this._onChangeFilterHandler = this._onChangeFilter.bind(this);
        this.state = {
            concern: FILTER_CONCERN.ITEM,
        };
    }

    _onChangeFilter(event) {
        event.preventDefault();

        const filterName = event.currentTarget.text.toUpperCase();

        this.setState({ concern: FILTER_CONCERN[filterName] });
    }

    render() {
        const OrderItemRenderer = ORDER_LIST_RENDERER[this.state.concern];

        return (
            <React.Fragment>
                <FilterBar
                    initialSelection={'Item'}
                    items={FILTER_BAR_ITEMS}
                    onChangeFilterHandler={this._onChangeFilterHandler}
                />
                <div className={'js-orderItem'}>
                    <OrderItemRenderer
                        assemblies={this.props.assemblies}
                        assemblyMap={this._assemblyMap}
                        concern={this.state.concern}
                        csrf={this.props.csrf}
                        departmentMap={this._departmentMap}
                        departments={this.props.departments}
                        itemMap={this._itemMap}
                        orderItems={this.props.orderItems}
                    />
                </div>
            </React.Fragment>
        );
    }
}

OrderPage.propTypes = {
    assemblies: PropTypes.array.isRequired,
    csrf: PropTypes.string.isRequired,
    departments: PropTypes.array.isRequired,
    items: PropTypes.array.isRequired,
    orderItems: PropTypes.array.isRequired,
};

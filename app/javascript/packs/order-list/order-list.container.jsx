import React from 'react';
import PropTypes from 'prop-types';
import _keyBy from 'lodash/keyBy';
import { OrderList } from './order-list.component';

export class OrderListContainer extends React.Component {
    constructor(props) {
        super(props);

        this._locationMap = _keyBy(props.locations, 'id');
    }

    render() {
        return (
            <OrderList
                ordersByConcern={this.props.ordersByConcern}
                locationMap={this._locationMap}
            />
        );
    }
}

OrderListContainer.propTypes = {
    ordersByConcern: PropTypes.array,
    locations: PropTypes.array.isRequired,
};

OrderListContainer.defaultProps = {
    ordersByConcern: [],
};

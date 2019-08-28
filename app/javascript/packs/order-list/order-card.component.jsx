import React from 'react';
import PropTypes from 'prop-types';
import { extractLocationNameFromMapByLocationId } from './extractLocationNameFromMapByLocationId';
import { MONTH_NAME } from '../constants/month-name';

export class OrderCard extends React.PureComponent {
    _buildListItemJsx(order, index) {
        const orderUrl = `/orders/${order.id}`;
        const shoppingDate = new Date(order.shopping_date);
        const dayNumber = shoppingDate.getDate();
        const monthName = MONTH_NAME[shoppingDate.getMonth()];
        const locationName = extractLocationNameFromMapByLocationId(order, this.props.locationMap);

        return (
            <li
                className={'orderListItem'}
                key={`orderCard-item${index}`}
            >
                <a
                    className={'card-link'}
                    href={orderUrl}
                >
                    <div className={'orderListItem-hd'}>
                        {dayNumber}
                    </div>
                    <div className={'orderListItem-bd'}>
                        {monthName}
                    </div>
                    <div className={'orderListItem-ft'}>
                        {locationName}
                    </div>
                </a>
            </li>
        );
    }

    render() {
        if (this.props.orderList.length === 0) {
            return (<div>No Items to display</div>);
        }

        return (
            <ul className={'card'}>
                {this.props.orderList.map((order, index) => this._buildListItemJsx(order, index))}
            </ul>
        );
    }
}

OrderCard.propTypes = {
    orderList: PropTypes.array.isRequired,
    locationMap: PropTypes.object.isRequired,
};

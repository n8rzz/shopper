import React from 'react';
import PropTypes from 'prop-types';
import { extractLocationNameFromMapByLocationId } from './extractLocationNameFromMapByLocationId';

export class OrderSimple extends React.PureComponent {
    _buildListItemJsx(order, index) {
        // %b %m, %Y
        const completedDate = new Date(order.updated_at).toLocaleDateString();
        const locationName = extractLocationNameFromMapByLocationId(order, this.props.locationMap);
        const statusMessage = `${order.status} - ${completedDate}`;

        return (
            <li key={`orderSimple-item-${index}`}>
                <div>
                    <a href={`/orders/${order.id}`}>
                        {locationName}
                    </a>
                </div>
                <div>
                    {statusMessage}
                </div>
            </li>
        );
    }

    render() {
        if (this.props.orderList.length === 0) {
            return (<div>No Items to display</div>);
        }

        return (
            <ul className={'vlist'}>
                {this.props.orderList.map((order, index) => this._buildListItemJsx(order, index))}
            </ul>
        );
    }
}

OrderSimple.propTypes = {
    orderList: PropTypes.array.isRequired,
    locationMap: PropTypes.object.isRequired,
};

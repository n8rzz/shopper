import React from 'react';
import PropTypes from 'prop-types';
import { OrderCard } from './order-card.component';
import { OrderSimple } from './order-simple.component';

const REDERER = {
    card: OrderCard,
    simple: OrderSimple,
};

function _buildConcernGroupItemRenderer(concern, locationMap) {
    const Renderer = REDERER[concern.renderer];
    const firstRenderLimit = 5;

    return (
        <Renderer
            orderList={concern.items}
            limit={firstRenderLimit}
            locationMap={locationMap}
        />
    );
}

function _buildConcernGroupJsx(concern, locationMap) {
    return (
        <div
            className={'vr_3'}
            key={`orderList-concern-${concern.name}`}
        >
            <div className={'vr_1'}>
                <h2 className={'hdg hdg_2'}>
                    {concern.name}
                </h2>
            </div>
            {_buildConcernGroupItemRenderer(concern, locationMap)}
        </div>
    );
}

export function OrderList(props) {
    if (props.ordersByConcern.length === 0) {
        return (<div>No orders to list!</div>);
    }

    return (
        <React.Fragment>
            {props.ordersByConcern.map((concern) => _buildConcernGroupJsx(concern, props.locationMap))}
        </React.Fragment>
    );
}

OrderList.propTypes = {
    ordersByConcern: PropTypes.array,
    locationMap: PropTypes.object.isRequired,
};

OrderList.defaultProps = {
    ordersByConcern: [],
};

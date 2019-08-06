import React from 'react';
import PropTypes from 'prop-types';
import format from 'date-fns/format';

export function OrderMeta(props) {
    const formattedShoppingDate = format(props.shoppingDate, 'MMM DD, YYYY');

    return (
        <div className={'orderMeta'}>
            <div>
                Shopping Date: { formattedShoppingDate }
            </div>
            <div>
                Status: { props.status }
            </div>
            <div>
                Location: { props.locationName }
            </div>
        </div>
    );
}

OrderMeta.propTypes = {
    shoppingDate: PropTypes.string.isRequired,
    status: PropTypes.string.isRequired,
    locationName: PropTypes.string,
};

OrderMeta.defaultProps = {
    locationName: '',
};

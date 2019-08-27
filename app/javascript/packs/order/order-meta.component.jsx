import React from 'react';
import PropTypes from 'prop-types';
import format from 'date-fns/format';

export function OrderMeta(props) {
    const formattedShoppingDate = format(new Date(props.shoppingDate), 'MMM dd, yyyy');

    return (
        <div className={'orderMeta'}>
            <div>
                Shopping Date: { formattedShoppingDate }
            </div>
            <div>
                Status: { props.status }
            </div>
            <div>
                Location:
                <a
                    className={'link'}
                    href={`/locations/${props.locationId}/edit`}
                >
                    { props.locationName }
                </a>
            </div>
        </div>
    );
}

OrderMeta.propTypes = {
    shoppingDate: PropTypes.string.isRequired,
    status: PropTypes.string.isRequired,
    locationId: PropTypes.number,
    locationName: PropTypes.string,
};

OrderMeta.defaultProps = {
    locationId: 1,
    locationName: '',
};

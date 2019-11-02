import React from 'react';
import PropTypes from 'prop-types';
import { extractLocationNameFromMapByLocationId } from './extractLocationNameFromMapByLocationId';

const LIMIT_INCREMENTOR = 5;

export class OrderSimple extends React.PureComponent {
    constructor(props) {
        super();

        this._onClickViewMoreHandler = this._onClickViewMore.bind(this);

        this.state = {
            limit: props.limit,
        };
    }

    componentWillUnmount() {
        this._onClickViewMoreHandler = null;
    }

    _buildListItemJsx(order, index) {
        // %b %m, %Y
        const completedDate = new Date(order.shopping_date).toLocaleDateString('en-US', {
            day: '2-digit',
            month: 'short',
            year: 'numeric',
        });
        const locationName = extractLocationNameFromMapByLocationId(order, this.props.locationMap);
        const statusMessage = `${order.status} - ${completedDate}`;

        return (
            <li
                key={`orderSimple-item-${index}`}
                className={'qa-orderSimple-item'}
            >
                <div>
                    <a
                        className={'link'}
                        href={`/orders/${order.id}`}
                    >
                        {locationName}
                    </a>
                </div>
                <div>
                    {statusMessage}
                </div>
            </li>
        );
    }

    _buildOrderListJsx() {
        const itemListJsx = [];
        const limit = this.state.limit >= this.props.orderList.length
            ? this.props.orderList.length
            : this.state.limit;

        for (let i = 0; i < limit; i++) {
            const order = this.props.orderList[i];

            itemListJsx.push(this._buildListItemJsx(order, i));
        }

        return itemListJsx;
    }

    _buildViewMoreLinkJsx() {
        if (this.state.limit >= this.props.orderList.length) {
            return null;
        }

        return (
            <div>
                <button
                    type={'button'}
                    className={'btn btn-wide mix-btn_inverse'}
                    onClick={this._onClickViewMoreHandler}
                >
                    View More
                </button>
            </div>
        );
    }

    render() {
        if (this.props.orderList.length === 0) {
            return (<div>No Items to display</div>);
        }

        return (
            <React.Fragment>
                <div className={'vr_2'}>
                    <ul className={'vlist'}>
                        {this._buildOrderListJsx()}
                    </ul>
                </div>
                {this._buildViewMoreLinkJsx()}
            </React.Fragment>
        );
    }

    _onClickViewMore(event) {
        event.preventDefault();

        this.setState((prevState) => {
            let limit = prevState.limit + LIMIT_INCREMENTOR;

            if (limit >= this.props.orderList.length) {
                limit = this.props.orderList.length;
            }

            return { limit };
        });
    }
}

OrderSimple.propTypes = {
    orderList: PropTypes.array.isRequired,
    limit: PropTypes.number,
    locationMap: PropTypes.object.isRequired,
};

OrderSimple.defaultProps = {
    limit: 5,
};

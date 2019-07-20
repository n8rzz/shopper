import React from 'react';
import PropTypes from 'prop-types'
import classnames from 'classnames';
import {noop} from 'lodash/noop';

export class OrderItem extends React.Component {
    constructor(props) {
        super(props);
    }

    _buildOrderItemClassnames() {
        const orderItemIdClassname = `js-orderItem-${this.props.orderItemId}`;

        return classnames({
            'orderItem': true,
            [orderItemIdClassname]: true,
            'mix-orderItem_isPicked': this.props.isPicked,
        });
    }

    _buildCheckboxJsx() {
        return (
            <div className="orderItem-action">
                <form>
                    <input
                        type="checkbox"
                        className="input-checkbox js-orderItem-action-value u-isVisuallyHidden"
                        name={this.props.orderItemId}
                        checked={this.props.isPicked}
                        onChange={() => noop}
                    />
                    <label
                        className="input-label_checkbox js-orderItem-action"
                        htmlFor={this.props.orderItemId}
                        onClick={this.props.onClickCheckboxHandler}
                    >
                        {this.props.isPicked}
                    </label>
                </form>
            </div>
        );
    }

    _buildItemTitleJsx() {
        return (
            <div className="orderItem-hd-content">
                <h3>
                    <a
                        href={this.props.editItemUrl}
                        className="orderItem-hd-link"
                    >
                        {this.props.itemName}
                    </a>
                </h3>
            </div>
        );
    }

    _buildQtyJsx() {
        if (this.props.qty < 2) {
            return null;
        }

        return (
            <div className="orderItem-hd-supplement">
                <h3>
                    <span className="txt-light">Qty:</span> {this.props.qty}
                </h3>
            </div>
        );
    }

    _buildRemoveItemButtonJsx() {
        return (
            <button
                type="submit"
                className="icon-btn js-orderItem-remove"
                onClick={this.props.onClickRemoveItemHandler}
            >
                <span className="icon icon-trashcan"></span>
            </button>
        );
    }

    _buildAssemblyTitleJsx() {
        if (this.props.assemblyName === '') {
            return null;
        }

        return (
            <div className="orderItem-bd">
                {this.props.assemblyName}
            </div>
        );
    }

    render() {
        return (
            <li className={this._buildOrderItemClassnames()}>
                {this._buildCheckboxJsx()}

                <div className="orderItem-content">
                    <div className="orderItem-hd">
                        {this._buildItemTitleJsx()}
                        {this._buildQtyJsx()}
                        {this._buildRemoveItemButtonJsx()}
                    </div>
                    {this._buildAssemblyTitleJsx()}
                    <div className="orderItem-ft">
                        {this.props.departmentName}
                    </div>
                </div>
            </li>
        );
    }
}

OrderItem.propTypes = {
    assemblyName: PropTypes.string.isRequired,
    departmentName: PropTypes.string.isRequired,
    editItemUrl: PropTypes.string.isRequired,
    isPicked: PropTypes.bool.isRequired,
    itemName: PropTypes.string.isRequired,
    orderItemId: PropTypes.number.isRequired,
    qty: PropTypes.number.isRequired,
    onClickCheckboxHandler: PropTypes.func.isRequired,
    onClickRemoveItemHandler: PropTypes.func.isRequired,
};

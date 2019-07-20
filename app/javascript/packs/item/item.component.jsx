import React from 'react';
import PropTypes from 'prop-types';
import {StepperContainer} from '../components/stepper/stepper.container';

export class Item extends React.Component {
    get editItemPath() {
        return `items/${this.props.itemId}/edit`;
    }

    constructor(props) {
        super(props);
    }

    render() {
        return (
            <li className="js-item">
                <div className="listItem mix-listItem_flex">
                    <div className="listItem-content">
                        <div className="listItem-hd">
                            <h2 className="hdg hdg_2">
                                < a href={ this.editItemPath }>
                                    {this.props.itemName}
                                </a>
                            </h2>
                        </div>
                        <div className="listItem-ft">
                            { this.props.departmentName }
                        </div>
                    </div>
                    <div className="listItem-action">
                        <StepperContainer
                            itemId={this.props.itemId}
                            itemName={this.props.itemName}
                            departmentId={this.props.departmentId}
                            csrf={this.props.csrf}
                        />
                    </div>
                </div>
            </li>
        );
    }
}

Item.propTypes = {
    csrf: PropTypes.string.isRequired,
    departmentId: PropTypes.number.isRequired,
    departmentName: PropTypes.string.isRequired,
    itemId: PropTypes.number.isRequired,
    itemName: PropTypes.string.isRequired,
}

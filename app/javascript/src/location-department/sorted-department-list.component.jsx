import React from 'react';
import PropTypes from 'prop-types';
import { SORT_DIRECTION_CHANGE } from './sort-direction-change.enum';

export class SortedDepartmentList extends React.Component {
    constructor(props) {
        super(props);

        this._onClickUpHandler = this._onClickUp.bind(this);
        this._onClickDownHandler = this._onClickDown.bind(this);
        this._onClickRemoveHandler = this._onClickRemove.bind(this);
    }

    componentWillUnmount() {
        this._onClickUpHandler = null;
        this._onClickDownHandler = null;
        this._onClickRemoveHandler = null;
    }

    _onClickUp(event, locationDepartment) {
        event.preventDefault();

        this.props.onClickChangeDirectionHandler(locationDepartment, SORT_DIRECTION_CHANGE.UP);
    }

    _onClickDown(event, locationDepartment) {
        event.preventDefault();

        this.props.onClickChangeDirectionHandler(locationDepartment, SORT_DIRECTION_CHANGE.DOWN);
    }

    _onClickRemove(event, locationDepartment) {
        event.preventDefault();

        this.props.onClickRemoveHandler(locationDepartment);
    }

    render() {
        const departmentsCount = this.props.locationDepartments.length - 1;
        const departmentListJsx = this.props.locationDepartments.map((locationDepartment, index) => {
            const isUpButtonDisabled = locationDepartment.sort_order === 0;
            const isDownButtonDisabled = index === departmentsCount;
            const department = this.props.departmentMap[locationDepartment.department_id];

            return (
                <li
                    className={'listItem'}
                    key={`sorted-department-${index}`}
                >
                    <div className={'listItem-hd'}>
                        <ul className={'stereo'}>
                            <li>
                                <a
                                    className={'link'}
                                    href={`/departments/${department.id}`}
                                >
                                    {department.name}
                                </a>
                            </li>
                            <li>
                                <button
                                    className={`icon-btn js-sortedDepartment-remove-${locationDepartment.id}`}
                                    type={'button'}
                                    onClick={(event) => this._onClickRemoveHandler(event, locationDepartment)}
                                >
                                    <span className={'icon icon-trashcan'} />
                                </button>
                            </li>
                        </ul>
                    </div>
                    <div className={'listItem-ft'}>
                        <ul className={'hlist'}>
                            <li>
                                <button
                                    className={`btn js-sortedDepartment-up-${locationDepartment.id}`}
                                    type={'button'}
                                    disabled={isUpButtonDisabled}
                                    onClick={(event) => this._onClickUpHandler(event, locationDepartment)}
                                >
                                    UP
                                </button>
                            </li>
                            <li>
                                <button
                                    className={`btn js-sortedDepartment-down-${locationDepartment.id}`}
                                    type={'button'}
                                    disabled={isDownButtonDisabled}
                                    onClick={(event) => this._onClickDownHandler(event, locationDepartment)}
                                >
                                    DOWN
                                </button>
                            </li>
                        </ul>
                    </div>
                </li>
            );
        });

        return (
            <React.Fragment>
                <div className={'vr_1'}>
                    <h3 className={'hdg hdg_3'}>Sort Order</h3>
                </div>
                <ul className={'vlist js-sortedDepartmentList'}>
                    { departmentListJsx }
                </ul>
            </React.Fragment>
        );
    }
}

SortedDepartmentList.propTypes = {
    departmentMap: PropTypes.object.isRequired,
    locationDepartments: PropTypes.array.isRequired,
    onClickChangeDirectionHandler: PropTypes.func.isRequired,
    onClickRemoveHandler: PropTypes.func.isRequired,
};

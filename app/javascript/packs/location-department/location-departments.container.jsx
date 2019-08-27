import React from 'react';
import PropTypes from 'prop-types';
import _keyBy from 'lodash/keyBy';
import ApiService from '../service/api.service';
import { SortedDepartmentList } from './sorted-department-list.component';
import { NonSortedDepartmentList } from './non-sorted-department-list.component';

export class LocationDepartmentsContainer extends React.Component {
    constructor(props) {
        super(props);

        this._departmentMap = _keyBy(props.departments, 'id');
        this._onClickChangeDirectionHandler = this._onClickChangeDirection.bind(this);
        this._onClickCreateLocationDepartmentHanlder = this._onClickCreateLocationDepartment.bind(this);
        this._onClickRemoveHandler = this._onClickRemove.bind(this);
        this._onUpdateSortOrderSuccessHandler = this._onUpdateSortOrderSuccess.bind(this);
        this._onCreateLocationDepartmentHandler = this._onCreateLocationDepartment.bind(this);
        this._onDestroyLocationDepartmentHandler = this._onDestroyLocationDepartment.bind(this);

        this.state = {
            unsortedDepartmentList: this._buildUnsortedDepartmentsList(props.departments, props.locationDepartments),
            sortedDepartmentList: props.locationDepartments,
        };
    }

    componentWillUnmount() {
        this._onClickChangeDirectionHandler = null;
        this._onClickCreateLocationDepartmentHanlder = null;
        this._onClickRemoveHandler = null;
        this._onUpdateSortOrderSuccessHandler = null;
        this._onCreateLocationDepartmentHandler = null;
        this._onDestroyLocationDepartmentHandler = null;
    }

    _buildUnsortedDepartmentsList(departments, locationDepartments) {
        return departments.reduce((sum, department) => {
            const foundDepartment = locationDepartments.filter(
                (locationDepartment) => locationDepartment.department_id === department.id,
            );

            if (foundDepartment.length > 0) {
                return sum;
            }

            return [
                ...sum,
                department,
            ];
        }, []);
    }

    _onClickChangeDirection(locationDepartment, changeDirection) {
        this._updateSortOrder(locationDepartment, changeDirection);
    }

    _onClickCreateLocationDepartment(event, department) {
        event.preventDefault();

        const url = '/location_departments.json';
        const locationDepartmentParams = {
            location_id: this.props.locationId,
            department_id: department.id,
        };

        ApiService.post(url, locationDepartmentParams, this.props.csrf)
            .then((response) => this._onCreateLocationDepartmentHandler(response.data))
            .catch((error) => { throw error; });
    }

    // FIXME: combine this with identical method
    _onCreateLocationDepartment(locationDepartments) {
        const unsortedDepartmentList = this._buildUnsortedDepartmentsList(this.props.departments, locationDepartments);

        this.setState({
            unsortedDepartmentList,
            sortedDepartmentList: locationDepartments,
        });
    }

    _onClickRemove(locationDepartment) {
        const url = `/location_departments/${locationDepartment.id}.json`;

        ApiService.delete(url, null, this.props.csrf)
            .then((response) => this._onDestroyLocationDepartmentHandler(response.data))
            .catch((error) => { throw error; });
    }

    // FIXME: combine this with identical method
    _onDestroyLocationDepartment(locationDepartments) {
        const unsortedDepartmentList = this._buildUnsortedDepartmentsList(this.props.departments, locationDepartments);

        this.setState({
            unsortedDepartmentList,
            sortedDepartmentList: locationDepartments,
        });
    }

    _updateSortOrder(locationDepartment, changeDirection) {
        const url = `/location_departments/${locationDepartment.id}/${changeDirection.toLowerCase()}.json`;

        ApiService.post(url, null, this.props.csrf)
            .then((response) => this._onUpdateSortOrderSuccessHandler(response.data))
            .catch((error) => { throw error; });
    }

    _onUpdateSortOrderSuccess(locationDepartments) {
        this.setState({ sortedDepartmentList: locationDepartments });
    }

    render() {
        return (
            <React.Fragment>
                <div className={'vr_3'}>
                    <SortedDepartmentList
                        departmentMap={this._departmentMap}
                        locationDepartments={this.state.sortedDepartmentList}
                        onClickChangeDirectionHandler={this._onClickChangeDirectionHandler}
                        onClickRemoveHandler={this._onClickRemoveHandler}
                    />
                </div>
                <div className={'vr_2'}>
                    <NonSortedDepartmentList
                        departments={this.state.unsortedDepartmentList}
                        onClickCreateLocationDepartmentHanlder={this._onClickCreateLocationDepartmentHanlder}
                    />
                </div>
            </React.Fragment>
        );
    }
}

LocationDepartmentsContainer.propTypes = {
    csrf: PropTypes.string.isRequired,
    departments: PropTypes.array.isRequired,
    locationDepartments: PropTypes.array.isRequired,
    locationId: PropTypes.number.isRequired,
};

import React from 'react';
import PropTypes from 'prop-types';
import { LocationDepartmentsContainer } from './location-departments.container';

export function LocationDepartmentsPage(props) {
    return (
        <LocationDepartmentsContainer
            csrf={props.csrf}
            departments={props.departments}
            locationDepartments={props.locationDepartments}
            locationId={props.locationId}
        />
    );
}

LocationDepartmentsPage.propTypes = {
    csrf: PropTypes.string.isRequired,
    departments: PropTypes.array.isRequired,
    locationDepartments: PropTypes.array.isRequired,
    locationId: PropTypes.number.isRequired,
};

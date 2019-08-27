import React from 'react';
import { shallow } from 'enzyme';
import { csrfMock } from '../../__mocks__/csrf.mock';
import { departmentListMock } from '../../__mocks__/department.mock';
import { locationDepartmentListMock } from '../../__mocks__/location-department.mock';
import { LocationDepartmentsContainer } from '../location-departments.container';

describe('LocationDepartmentsContainer', () => {
    let component = null;

    beforeEach(() => {
        component = shallow(<LocationDepartmentsContainer
            csrf={csrfMock}
            departments={departmentListMock}
            locationDepartments={locationDepartmentListMock}
            locationId={1}
        />);
    });

    afterEach(() => {
        component = null;
    });

    test('renders correctly with valid props', () => {
        expect(component).toMatchSnapshot();
    });
});

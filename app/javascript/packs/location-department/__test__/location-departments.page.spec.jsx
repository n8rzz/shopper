import React from 'react';
import { shallow } from 'enzyme';
import { csrfMock } from '../../__mocks__/csrf.mock';
import { departmentListMock } from '../../__mocks__/department.mock';
import { locationDepartmentListMock } from '../../__mocks__/location-department.mock';
import { LocationDepartmentsPage } from '../location-departments.page';

describe('LocationDepartmentsPage', () => {
    test('renders correctly with valid props', () => {
        const component = shallow(<LocationDepartmentsPage
            csrf={csrfMock}
            departments={departmentListMock}
            locationDepartments={locationDepartmentListMock}
            locationId={1}
        />);

        expect(component).toMatchSnapshot();
    });
});

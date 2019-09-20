import React from 'react';
import { shallow } from 'enzyme';
import { LocationDepartmentsPage } from '../location-departments.page';
import {
    csrfMock,
    departmentListMock,
    locationDepartmentListMock,
} from '../../__mocks__/mocks';

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

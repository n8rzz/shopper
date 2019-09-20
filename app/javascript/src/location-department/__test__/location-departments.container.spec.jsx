import React from 'react';
import { shallow } from 'enzyme';
import { LocationDepartmentsContainer } from '../location-departments.container';
import {
    csrfMock,
    departmentListMock,
    locationDepartmentListMock,
} from '../../__mocks__/mocks';

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

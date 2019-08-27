import React from 'react';
import sinon from 'sinon';
import { shallow } from 'enzyme';
import { departmentMapMock } from '../../__mocks__/department.mock';
import { locationDepartmentListMock } from '../../__mocks__/location-department.mock';
import { SortedDepartmentList } from '../sorted-department-list.component';

describe('SortedDepartmentList', () => {
    test('renders correctly with valid props', () => {
        const component = shallow(<SortedDepartmentList
            departmentMap={departmentMapMock}
            locationDepartments={locationDepartmentListMock}
            onClickChangeDirectionHandler={sinon.spy()}
            onClickRemoveHandler={sinon.spy()}
        />);

        expect(component).toMatchSnapshot();
    });
});

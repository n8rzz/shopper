import React from 'react';
import sinon from 'sinon';
import { shallow } from 'enzyme';
import { departmentListMock } from '../../__mocks__/department.mock';
import { NonSortedDepartmentList } from '../non-sorted-department-list.component';

describe('NonSortedDepartmentList', () => {
    test('renders correctly with valid props', () => {
        const component = shallow(<NonSortedDepartmentList
            departments={departmentListMock}
            onClickCreateLocationDepartmentHanlder={sinon.spy}
        />);

        expect(component).toMatchSnapshot();
    });
});

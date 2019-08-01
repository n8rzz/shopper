import React from 'react';
import { shallow } from 'enzyme';

import { GroupedItemList } from '../grouped-item-list.component';
import {
    departmentListMock,
    departmentMapMock,
} from '../../__mocks__/department.mock';
import { itemListMock } from '../../__mocks__/item.mock';
import { csrfMock } from '../../__mocks__/csrf.mock';


describe('GroupedItemList', () => {
    test('renders correctly with valid props', () => {
        const component = shallow(<GroupedItemList
            csrf={csrfMock}
            departments={departmentListMock}
            departmentMap={departmentMapMock}
            items={itemListMock}
        />);

        expect(component).toMatchSnapshot();
    });
});

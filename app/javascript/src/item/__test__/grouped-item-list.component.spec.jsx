import React from 'react';
import { shallow } from 'enzyme';

import { GroupedItemList } from '../grouped-item-list.component';
import {
    csrfMock,
    departmentListMock,
    departmentMapMock,
    itemListMock,
} from '../../__mocks__/mocks';

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

    test('returns `null` when passed no #items', () => {
        const component = shallow(<GroupedItemList
            csrf={csrfMock}
            departments={departmentListMock}
            departmentMap={departmentMapMock}
            items={[]}
        />);

        expect(component).toMatchSnapshot();
    });
});

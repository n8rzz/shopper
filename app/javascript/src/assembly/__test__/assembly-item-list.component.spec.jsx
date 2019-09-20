import React from 'react';
import { shallow } from 'enzyme';

import { AssemblyItemList } from '../assembly-item-list.component';
import {
    assemblyListMock,
    assemblyItemsGroupedByAssemblyIdMock,
    csrfMock,
    departmentMapMock,
    itemMapMock,
} from '../../__mocks__/mocks';

describe('AssemblyItemList', () => {
    test('renders correctly with valid props', () => {
        const component = shallow(<AssemblyItemList
            assemblies={assemblyListMock}
            assemblyItemsGroupedByAssemblyId={assemblyItemsGroupedByAssemblyIdMock}
            csrf={csrfMock}
            departmentIdMap={departmentMapMock}
            itemIdMap={itemMapMock}
        />);

        expect(component).toMatchSnapshot();
    });
});

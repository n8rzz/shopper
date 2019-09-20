import React from 'react';
import { shallow } from 'enzyme';

import { AssemblyItemContainer } from '../assembly-item.container';
import {
    assemblyMock,
    assemblyItemsGroupedByAssemblyIdMock,
    csrfMock,
    departmentMapMock,
    itemMapMock,
} from '../../__mocks__/mocks';

describe('AssemblyItemContainer', () => {
    test('renders correctly with valid props', () => {
        const component = shallow(<AssemblyItemContainer
            assembly={assemblyMock}
            assemblyItemsGroupedByAssemblyId={assemblyItemsGroupedByAssemblyIdMock}
            csrf={csrfMock}
            departmentIdMap={departmentMapMock}
            itemIdMap={itemMapMock}
        />);

        expect(component).toMatchSnapshot();
    });
});

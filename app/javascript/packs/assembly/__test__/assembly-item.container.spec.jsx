import React from 'react';
import { shallow } from 'enzyme';

import { AssemblyItemContainer } from '../assembly-item.container';
import { assemblyMock } from '../../__mocks__/assembly.mock';
import { assemblyItemsGroupedByAssemblyIdMock } from '../../__mocks__/assembly-item.mocks';
import { csrfMock } from '../../__mocks__/csrf.mock';
import { departmentMapMock } from '../../__mocks__/department.mock';
import { itemMapMock } from '../../__mocks__/item.mock';

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

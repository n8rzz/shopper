import React from 'react';
import sinon from 'sinon';
import { shallow } from 'enzyme';

import { AssemblyItem } from '../assembly-item.component';
import { assemblyMock } from '../../__mocks__/assembly.mock';
import { assemblyItemsGroupedByAssemblyIdMock } from '../../__mocks__/assembly-item.mocks';
import { departmentMapMock } from '../../__mocks__/department.mock';
import { itemMapMock } from '../../__mocks__/item.mock';

describe('AssemblyItem', () => {
    test('renders correctly with valid props', () => {
        const component = shallow(<AssemblyItem
            assembly={assemblyMock}
            assemblyItemsGroupedByAssemblyId={assemblyItemsGroupedByAssemblyIdMock}
            departmentIdMap={departmentMapMock}
            itemIdMap={itemMapMock}
            isOpen={false}
            onClickAccordionTriggerHandler={sinon.spy()}
            onClickAddAssemblyHandler={sinon.spy()}
            onClickAddAssemblyItemHandler={sinon.spy()}
        />);

        expect(component).toMatchSnapshot();
    });
});

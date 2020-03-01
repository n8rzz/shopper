import React from 'react';
import { shallow } from 'enzyme';

import { AssemblyPage } from '../assembly.page';
import {
    assemblyListMock,
    csrfMock,
    departmentListMock,
    itemListMock,
    recipeListMock,
} from '../../__mocks__/mocks';

describe('AssemblyPage', () => {
    test('renders correctly with valid props', () => {
        const component = shallow(<AssemblyPage
            assemblies={assemblyListMock}
            assemblyItems={[]}
            csrf={csrfMock}
            departments={departmentListMock}
            items={itemListMock}
            recipes={recipeListMock}
        />);

        expect(component).toMatchSnapshot();
    });
});

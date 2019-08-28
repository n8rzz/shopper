import React from 'react';
import { shallow } from 'enzyme';

import { AssemblyPage } from '../assembly.page';
import {
    assemblyListMock,
    csrfMock,
    departmentListMock,
    itemListMock,
} from '../../__mocks__/mocks';

describe('AssemblyPage', () => {
    test('renders correctly with valid props', () => {
        const component = shallow(<AssemblyPage
            assemblies={assemblyListMock}
            assemblyItems={[]}
            csrf={csrfMock}
            departments={departmentListMock}
            items={itemListMock}
        />);

        expect(component).toMatchSnapshot();
    });
});

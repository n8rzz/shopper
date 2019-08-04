import React from 'react';
import { shallow } from 'enzyme';

import { AssemblyPage } from '../assembly.page';
import { assemblyListMock } from '../../__mocks__/assembly.mock';
import { csrfMock } from '../../__mocks__/csrf.mock';
import { departmentListMock } from '../../__mocks__/department.mock';
import { itemListMock } from '../../__mocks__/item.mock';

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

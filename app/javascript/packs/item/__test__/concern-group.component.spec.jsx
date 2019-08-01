import React from 'react';
import { shallow } from 'enzyme';

import { ConcernGroup } from '../concern-group.component';
import { departmentMapMock } from '../../__mocks__/department.mock';
import { itemListMock } from '../../__mocks__/item.mock';

describe('ConcernGroup', () => {
    test('renders correctly with valid props', () => {
        const component = shallow(<ConcernGroup
            csrf={'3yIq75tyV791TFkzSZo/S4b+TVa/N5J3dI14PzMUPviGViEGeDSnGnvNix+MaB0RB0XuV7bpX8I3SmIEAr4/zQ=='}
            departmentMap={departmentMapMock}
            groupName={'Bakery'}
            itemList={itemListMock}
        />);

        expect(component).toMatchSnapshot();
    });
});

import React from 'react';
import { shallow } from 'enzyme';

import { ItemContainer } from '../item.container';

describe('Item', () => {
    test('renders correctly with valid props', () => {
        const component = shallow(<ItemContainer
            csrf={'3yIq75tyV791TFkzSZo/S4b+TVa/N5J3dI14PzMUPviGViEGeDSnGnvNix+MaB0RB0XuV7bpX8I3SmIEAr4/zQ=='}
            departmentId={32}
            departmentName={'meat'}
            itemId={11}
            itemName={'Red Face Tuna'}
        />);

        expect(component).toMatchSnapshot();
    });
});

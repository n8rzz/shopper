import React from 'react';
import {shallow} from 'enzyme';

import {ItemList} from '../item-list.component';
import {
    departmentMapMock,
    itemListMock
} from './__mock__/item.mocks';

describe('ItemList', () => {
    test('renders correctly with valid props', () => {
        const component = shallow(<ItemList
            csrf={'3yIq75tyV791TFkzSZo/S4b+TVa/N5J3dI14PzMUPviGViEGeDSnGnvNix+MaB0RB0XuV7bpX8I3SmIEAr4/zQ=='}
            departmentMap={departmentMapMock}
            itemList={itemListMock}
        />);

        expect(component).toMatchSnapshot();
    });

    describe('when passed no items', () => {
        test('returns `null`', () => {
            const component = shallow(<ItemList
                csrf={'3yIq75tyV791TFkzSZo/S4b+TVa/N5J3dI14PzMUPviGViEGeDSnGnvNix+MaB0RB0XuV7bpX8I3SmIEAr4/zQ=='}
                departmentMap={departmentMapMock}
                itemList={[]}
            />);

            expect(component).not.toBeUndefined();
        });
    })
});

import React from 'react';
import { shallow } from 'enzyme';

import { ItemListPage } from '../item-list.page';
import { GroupedItemList } from '../grouped-item-list.component';
import { ItemList } from '../item-list.component';
import { FILTER_CONCERN } from '../../constants/filter-concern';
import { departmentListMock, itemListMock } from '../../__mocks__/mocks';

describe('ItemListPage', () => {
    test('renders correctly with valid props', () => {
        const component = shallow(<ItemListPage
            csrf={'3yIq75tyV791TFkzSZo/S4b+TVa/N5J3dI14PzMUPviGViEGeDSnGnvNix+MaB0RB0XuV7bpX8I3SmIEAr4/zQ=='}
            departments={departmentListMock}
            items={itemListMock}
        />);

        expect(component).toMatchSnapshot();
    });

    describe('when `state.concern` equals `DEPARTMENT', () => {
        test('it renders a `GroupedItemList` component', () => {
            const component = shallow(<ItemListPage
                csrf={'3yIq75tyV791TFkzSZo/S4b+TVa/N5J3dI14PzMUPviGViEGeDSnGnvNix+MaB0RB0XuV7bpX8I3SmIEAr4/zQ=='}
                departments={departmentListMock}
                items={itemListMock}
            />);
            component.setState({ concern: FILTER_CONCERN.DEPARTMENT });

            expect(component.find(GroupedItemList).length).toBe(1);
        });
    });

    describe('when `state.concern` equals `ALPHA', () => {
        test('it renders an `ItemList` component', () => {
            const component = shallow(<ItemListPage
                csrf={'3yIq75tyV791TFkzSZo/S4b+TVa/N5J3dI14PzMUPviGViEGeDSnGnvNix+MaB0RB0XuV7bpX8I3SmIEAr4/zQ=='}
                departments={departmentListMock}
                items={itemListMock}
            />);
            component.setState({ concern: FILTER_CONCERN.ALPHA });

            expect(component.find(GroupedItemList).length).toBe(0);
            expect(component.find(ItemList).length).toBe(1);
        });
    });

    describe('when `state.concern` equals `FILTER', () => {
        let component;

        beforeEach(() => {
            component = shallow(<ItemListPage
                csrf={'3yIq75tyV791TFkzSZo/S4b+TVa/N5J3dI14PzMUPviGViEGeDSnGnvNix+MaB0RB0XuV7bpX8I3SmIEAr4/zQ=='}
                departments={departmentListMock}
                items={itemListMock}
            />);
            component.setState({ concern: FILTER_CONCERN.FILTER });
        });

        afterEach(() => {
            component = null;
        });

        test('it renders an `ItemList` component', () => {
            expect(component.find(ItemList).length).toBe(1);
        });

        test('it renders a `select` element', () => {
            expect(component.find('select').length).toBe(1);
        });
    });
});

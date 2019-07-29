import React from 'react';
import { shallow } from 'enzyme';
import { FilterBar } from '../filter-bar.component';

const filterBarItemListMock = [
    {
        text: 'Alpha',
        url: '/items',
    },
    {
        text: 'Department',
        url: '/items/?order=department',
    },
];

describe('FilterBar', () => {
    test('renders correctly with valid props', () => {
        const component = shallow(<FilterBar
            initialSelection={filterBarItemListMock[0].text}
            items={filterBarItemListMock}
        />);

        expect(component).toMatchSnapshot();
    });
});

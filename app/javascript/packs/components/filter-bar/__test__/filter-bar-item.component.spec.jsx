import React from 'react';
import {shallow} from 'enzyme';

import {FilterBarItem} from '../filter-bar-item.component';

const filterBarItemPropsMock = {
    text: 'Alpha',
    url: '/items',
};

describe('FilterBarItem', () => {
    test('renders correctly with valid props', () => {
        const component = shallow(<FilterBarItem
            text={filterBarItemPropsMock.text}
            url={filterBarItemPropsMock.url}
        />);

        expect(component).toMatchSnapshot();
    });
});

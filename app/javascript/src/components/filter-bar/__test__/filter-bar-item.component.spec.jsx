import React from 'react';
import { shallow } from 'enzyme';

import { FilterBarItem } from '../filter-bar-item.component';

const filterBarItemPropsMock = {
    text: 'Alpha',
    url: '/items',
};

describe('FilterBarItem', () => {
    describe('when #isActive is false', () => {
        test('renders correctly with valid props', () => {
            const component = shallow(<FilterBarItem
                isActive={false}
                text={filterBarItemPropsMock.text}
                url={filterBarItemPropsMock.url}
            />);

            expect(component).toMatchSnapshot();
        });
    });

    describe('when #isActive is true', () => {
        test('renders correctly with valid props', () => {
            const component = shallow(<FilterBarItem
                isActive={true}
                text={filterBarItemPropsMock.text}
                url={filterBarItemPropsMock.url}
            />);

            expect(component).toMatchSnapshot();
        });
    });
});

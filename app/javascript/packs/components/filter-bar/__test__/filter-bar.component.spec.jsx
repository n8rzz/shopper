import React from 'react';
import sinon from 'sinon';
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

    describe('.componentWillUnmount()', () => {
        test('unsets handlers', () => {
            const component = shallow(<FilterBar
                initialSelection={filterBarItemListMock[0].text}
                items={filterBarItemListMock}
            />);

            component.instance().componentWillUnmount();

            expect(component.instance()._onChangeFilterHandler).toBe(null);
        });
    });

    describe('._onChangeFilter()', () => {
        test('calls .props.onChangeFilterHandler() after `setState` is called', () => {
            const eventMock = {
                target: {
                    text: '$texas',
                },
            };
            const onChangeFilterHandlerSpy = sinon.spy();
            const component = shallow(<FilterBar
                initialSelection={filterBarItemListMock[0].text}
                items={filterBarItemListMock}
                onChangeFilterHandler={onChangeFilterHandlerSpy}
            />);
            component.instance()._onChangeFilter(eventMock);

            expect(onChangeFilterHandlerSpy.calledWithExactly(eventMock)).toBe(true);
        });
    });
});

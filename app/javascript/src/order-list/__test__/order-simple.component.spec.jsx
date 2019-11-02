import React from 'react';
import sinon from 'sinon';
import { shallow } from 'enzyme';

import { OrderSimple } from '../order-simple.component';
import {
    completeItemsMock,
    locationMapMock,
} from '../__mock__/order-mocks';

describe('OrderSimple', () => {
    describe('.componentWillUnmount', () => {
        test('resets handler methods', () => {
            const component = shallow(<OrderSimple
                orderList={[]}
                locationMap={locationMapMock}
            />);

            component.unmount();

            expect(typeof component._onClickViewMoreHandler).toBe('undefined');
        });
    });

    describe('when passed an empty `orderList`', () => {
        test('renders correctly with valid props', () => {
            const component = shallow(<OrderSimple
                orderList={[]}
                locationMap={locationMapMock}
            />);

            expect(component).toMatchSnapshot();
        });
    });

    describe('when passed a valid `orderList`', () => {
        let component = null;

        beforeEach(() => {
            component = shallow(<OrderSimple
                orderList={completeItemsMock}
                locationMap={locationMapMock}
            />);
        });

        afterEach(() => {
            component = null;
        });

        test('renders correctly with valid props', () => {
            expect(component).toMatchSnapshot();
        });

        test('renders the default number of items', () => {
            const listItems = component.find('.qa-orderSimple-item');

            expect(listItems.length).toBe(5);
        });
    });

    describe('when passed `limit` prop', () => {
        let component = null;

        beforeEach(() => {
            component = shallow(<OrderSimple
                orderList={completeItemsMock}
                limit={10}
                locationMap={locationMapMock}
            />);
        });

        afterEach(() => {
            component = null;
        });

        test('renders correctly', () => {
            expect(component).toMatchSnapshot();
        });

        test('renders the correct number of items', () => {
            const listItems = component.find('.qa-orderSimple-item');

            expect(listItems.length).toBe(completeItemsMock.length);
        });
    });

    describe('._onClickViewMore()', () => {
        let component = null;
        let eventStub = null;

        beforeEach(() => {
            eventStub = {
                preventDefault: sinon.spy(),
            };
            component = shallow(<OrderSimple
                orderList={completeItemsMock}
                limit={1}
                locationMap={locationMapMock}
            />);
        });

        afterEach(() => {
            component = null;
            eventStub = null;
        });

        test('calls event.preventDefault()', () => {
            const instance = component.instance();

            instance._onClickViewMore(eventStub);

            expect(eventStub.preventDefault.callCount).toBe(1);
        });

        describe('when #limit < props.orderItems.length', () => {
            test('should update #limit + LIMIT_INCREMENTOR', () => {
                const instance = component.instance();
                component.setState({ limit: 1 });

                instance._onClickViewMore(eventStub);

                expect(component.state('limit')).toBe(6);
            });
        });

        describe('when #limit > props.orderItems.length', () => {
            test('should set #limit to props.orderItems.length', () => {
                const instance = component.instance();
                component.setState({ limit: 10 });

                instance._onClickViewMore(eventStub);

                expect(component.state('limit')).toBe(completeItemsMock.length);
            });
        });
    });
});

import React from 'react';
import { shallow } from 'enzyme';

import { OrderList } from '../order-list.component';
import {
    ordersByConcernMock,
    locationMapMock,
} from '../__mock__/order-mocks';

describe('OrderList', () => {
    describe('when called with more than 0 `ordersByConcern`', () => {
        test('renders correctly with valid props', () => {
            const component = shallow(<OrderList
                ordersByConcern={ordersByConcernMock}
                locationMap={locationMapMock}
            />);

            expect(component).toMatchSnapshot();
        });
    });

    describe('when called with 0 `ordersByConcern`', () => {
        test('renders correctly with valid props', () => {
            const component = shallow(<OrderList
                ordersByConcern={[]}
                locationMap={locationMapMock}
            />);

            expect(component).toMatchSnapshot();
        });
    });
});

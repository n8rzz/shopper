import React from 'react';
import { shallow } from 'enzyme';

import { OrderSimple } from '../order-simple.component';
import {
    pendingItemsMock,
    locationMapMock,
} from '../__mock__/order-mocks';

describe('OrderSimple', () => {
    describe('when passed a valid `orderList`', () => {
        test('renders correctly with valid props', () => {
            const component = shallow(<OrderSimple
                orderList={pendingItemsMock}
                locationMap={locationMapMock}
            />);

            expect(component).toMatchSnapshot();
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
});

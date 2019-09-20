import React from 'react';
import { shallow } from 'enzyme';
import { OrderCard } from '../order-card.component';
import {
    locationMapMock,
    pendingItemsMock,
} from '../__mock__/order-mocks';

describe('OrderCard', () => {
    describe('when passed a valid `orderList`', () => {
        test('renders correctly with valid props', () => {
            const component = shallow(<OrderCard
                orderList={pendingItemsMock}
                locationMap={locationMapMock}
            />);

            expect(component).toMatchSnapshot();
        });
    });

    describe('when passed an empty `orderList`', () => {
        test('renders correctly with valid props', () => {
            const component = shallow(<OrderCard
                orderList={[]}
                locationMap={locationMapMock}
            />);

            expect(component).toMatchSnapshot();
        });
    });
});

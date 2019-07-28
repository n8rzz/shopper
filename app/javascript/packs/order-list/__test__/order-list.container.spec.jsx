import React from 'react';
import { shallow } from 'enzyme';

import { OrderListContainer } from '../order-list.container';
import {
    ordersByConcernMock,
    locationsMock,
} from '../__mock__/order-mocks';

describe('OrderListContainer', () => {
    test('renders correctly with valid props', () => {
        const component = shallow(<OrderListContainer
            ordersByConcern={ordersByConcernMock}
            locations={locationsMock}
        />);

        expect(component).toMatchSnapshot();
    });
});

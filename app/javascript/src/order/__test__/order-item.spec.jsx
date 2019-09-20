import React from 'react';
import { shallow } from 'enzyme';

import { OrderItem } from '../order-item.component';

describe('OrderItem', () => {
    let onClickIsPickedHandlerSpy;
    let onClickRemoveItemHandlerSpy;

    beforeEach(() => {
        onClickIsPickedHandlerSpy = jest.fn();
        onClickRemoveItemHandlerSpy = jest.fn();
    });

    afterEach(() => {
        onClickIsPickedHandlerSpy = null;
        onClickRemoveItemHandlerSpy = null;
    });

    describe('when passed an empty `#assemblyName`', () => {
        test('renders correctly with valid props', () => {
            const component = shallow(<OrderItem
                assemblyName={''}
                departmentId={32}
                departmentName={'meat'}
                editItemUrl={'http://localhost:3000/orders/21/edit'}
                isPicked={false}
                itemName={'Red Face Tuna'}
                orderItemId={11}
                qty={1}
                onClickIsPickedHandler={onClickIsPickedHandlerSpy}
                onClickRemoveItemHandler={onClickRemoveItemHandlerSpy}
            />);

            expect(component).toMatchSnapshot();
        });
    });

    describe('when passed a non-empty `#assemblyName`', () => {
        test('renders correctly with valid props', () => {
            const component = shallow(<OrderItem
                assemblyName={'sushi'}
                departmentId={32}
                departmentName={'meat'}
                editItemUrl={'http://localhost:3000/orders/21/edit'}
                isPicked={false}
                itemName={'Red Face Tuna'}
                orderItemId={11}
                qty={1}
                onClickIsPickedHandler={onClickIsPickedHandlerSpy}
                onClickRemoveItemHandler={onClickRemoveItemHandlerSpy}
            />);

            expect(component).toMatchSnapshot();
        });
    });
});

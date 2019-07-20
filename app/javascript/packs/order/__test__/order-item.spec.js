import React from 'react';
import {shallow} from 'enzyme';

import { OrderItem } from '../order-item';

describe('OrderItem', () => {
    let onClickCheckboxHandlerSpy;
    let onClickRemoveItemHandlerSpy;

    beforeEach(() => {
        onClickCheckboxHandlerSpy = jest.fn();
        onClickRemoveItemHandlerSpy = jest.fn();
    });

    afterEach(() => {
        onClickCheckboxHandlerSpy = null;
        onClickRemoveItemHandlerSpy = null;
    });

    describe('when passed an empty `#assemblyName`', () => {
        test('renders correctly with valid props without ', () => {
            const component = shallow(<OrderItem
                assemblyName={''}
                csrf={'3yIq75tyV791TFkzSZo/S4b+TVa/N5J3dI14PzMUPviGViEGeDSnGnvNix+MaB0RB0XuV7bpX8I3SmIEAr4/zQ=='}
                departmentId={32}
                departmentName={'meat'}
                editItemUrl={'http://localhost:3000/orders/21/edit'}
                isPicked={false}
                itemName={'$texas'}
                itemName={'Red Face Tuna'}
                orderItemId={11}
                qty={1}
                onClickCheckboxHandler={onClickCheckboxHandlerSpy}
                onClickRemoveItemHandler={onClickRemoveItemHandlerSpy}
            />);

            expect(component).toMatchSnapshot();
        });
    });

    describe('when passed a non-empty `#assemblyName`', () => {
        test('renders correctly with valid props without ', () => {
            const component = shallow(<OrderItem
                assemblyName={'sushi'}
                csrf={'3yIq75tyV791TFkzSZo/S4b+TVa/N5J3dI14PzMUPviGViEGeDSnGnvNix+MaB0RB0XuV7bpX8I3SmIEAr4/zQ=='}
                departmentId={32}
                departmentName={'meat'}
                editItemUrl={'http://localhost:3000/orders/21/edit'}
                isPicked={false}
                itemName={'$texas'}
                itemName={'Red Face Tuna'}
                orderItemId={11}
                qty={1}
                onClickCheckboxHandler={onClickCheckboxHandlerSpy}
                onClickRemoveItemHandler={onClickRemoveItemHandlerSpy}
            />);

            expect(component).toMatchSnapshot();
        });
    });
});

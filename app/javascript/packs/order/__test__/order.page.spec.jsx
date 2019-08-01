import React from 'react';
import { mount, shallow } from 'enzyme';
import { OrderPage } from '../order.page';
import { FILTER_CONCERN } from '../../constants/filter-concern';
import { assemblyListMock } from '../../__mocks__/assembly.mock';
import { csrfMock } from '../../__mocks__/csrf.mock';
import { departmentListMock } from '../../__mocks__/department.mock';
import { orderItemListMock } from '../../__mocks__/order-item.mock';
import { itemListMock } from '../../__mocks__/item.mock';

describe('OrderPage', () => {
    describe('when passed more than 0 `orderItems`', () => {
        test('renders correctly with valid props', () => {
            const component = shallow(<OrderPage
                assemblies={assemblyListMock}
                csrf={csrfMock}
                departments={departmentListMock}
                items={itemListMock}
                orderItems={orderItemListMock}
            />);

            expect(component).toMatchSnapshot();
        });
    });

    describe('when passed 0 `orderItems`', () => {
        test('renders correctly with valid props', () => {
            const component = mount(<OrderPage
                assemblies={assemblyListMock}
                csrf={csrfMock}
                departments={departmentListMock}
                items={itemListMock}
                orderItems={[]}
            />);
            component.setState({ concern: FILTER_CONCERN.MEAL });

            expect(component).toMatchSnapshot();
        });
    });
});

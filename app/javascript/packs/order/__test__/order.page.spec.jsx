import React from 'react';
import { mount, shallow } from 'enzyme';
import { OrderPage } from '../order.page';
import { FILTER_CONCERN } from '../../constants/filter-concern';
import { assemblyListMock } from '../../__mocks__/assembly.mock';
import { csrfMock } from '../../__mocks__/csrf.mock';
import { departmentListMock } from '../../__mocks__/department.mock';
import { orderMock, orderLocationNameMock } from '../../__mocks__/order.mock';
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
                order={orderMock}
                orderLocationName={orderLocationNameMock}
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
                order={orderMock}
                orderLocationName={orderLocationNameMock}
            />);
            component.setState({ concern: FILTER_CONCERN.MEAL });

            expect(component).toMatchSnapshot();
        });
    });

    describe('`stickyHeader`', () => {
        let component = null;

        beforeEach(() => {
            component = mount(<OrderPage
                assemblies={assemblyListMock}
                csrf={csrfMock}
                departments={departmentListMock}
                items={itemListMock}
                orderItems={[]}
                order={orderMock}
                orderLocationName={orderLocationNameMock}
            />);
        });

        afterEach(() => {
            component = null;
        });

        describe('when `stickyHeader` is not sticky', () => {
            test('._onStickyStateChange() returns correct classnames', () => {
                const stickyEventMock = { status: 0 };

                component.instance()._onStickyStateChange(stickyEventMock);
                component.update();

                expect(component.find('.stickyHeader').hasClass('mix-stickyHeader_isSticky')).toBe(false);
            });
        });

        describe('when `stickyHeader` is sticky', () => {
            test('._onStickyStateChange() returns correct classnames', () => {
                const stickyEventMock = { status: 2 };

                component.instance()._onStickyStateChange(stickyEventMock);
                component.update();

                expect(component.find('.stickyHeader').hasClass('mix-stickyHeader_isSticky')).toBe(true);
            });
        });
    });
});

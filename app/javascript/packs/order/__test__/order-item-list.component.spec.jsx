import React from 'react';
import sinon from 'sinon';
import { shallow } from 'enzyme';
import { OrderItemList } from '../order-item-list.component';
import { assemblyMapMock } from '../../__mocks__/assembly.mock';
import { csrfMock } from '../../__mocks__/csrf.mock';
import { departmentMapMock } from '../../__mocks__/department.mock';
import { orderItemListMock } from '../../__mocks__/order-item.mock';
import { itemMapMock } from '../../__mocks__/item.mock';

describe('OrderItemList', () => {
    test('renders correctly with valid props', () => {
        const component = shallow(<OrderItemList
            assemblyMap={assemblyMapMock}
            csrf={csrfMock}
            departmentMap={departmentMapMock}
            itemMap={itemMapMock}
            orderItems={orderItemListMock}
            onClickIsPickedHandler={sinon.spy()}
            onClickRemoveItemHandler={sinon.spy()}
        />);

        expect(component).toMatchSnapshot();
    });
});

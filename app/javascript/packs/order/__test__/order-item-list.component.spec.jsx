import React from 'react';
import sinon from 'sinon';
import { shallow } from 'enzyme';
import { OrderItemList } from '../order-item-list.component';
import {
    assemblyMapMock,
    csrfMock,
    departmentMapMock,
    orderItemListMock,
    itemMapMock,
} from '../../__mocks__/mocks';

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

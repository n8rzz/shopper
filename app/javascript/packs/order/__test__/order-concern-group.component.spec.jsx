import React from 'react';
import sinon from 'sinon';
import { shallow } from 'enzyme';
import { OrderConcernGroup } from '../order-concern-group.component';
// TODO: implement tests for all states of the filter
import { FILTER_CONCERN } from '../../constants/filter-concern';
import { assemblyListMock, assemblyMapMock } from '../../__mocks__/assembly.mock';
import { csrfMock } from '../../__mocks__/csrf.mock';
import { departmentListMock, departmentMapMock } from '../../__mocks__/department.mock';
import { orderItemListMock } from '../../__mocks__/order-item.mock';
import { itemListMock, itemMapMock } from '../../__mocks__/item.mock';

describe('OrderConcernGroup', () => {
    test('renders correctly with valid props', () => {
        const component = shallow(<OrderConcernGroup
            assemblies={assemblyListMock}
            assemblyMap={assemblyMapMock}
            concern={FILTER_CONCERN.ITEM}
            csrf={csrfMock}
            departmentMap={departmentMapMock}
            departments={departmentListMock}
            itemMap={itemMapMock}
            items={itemListMock}
            orderItems={orderItemListMock}
            onClickIsPickedHandler={sinon.spy()}
            onClickRemoveItemHandler={sinon.spy()}
        />);

        expect(component).toMatchSnapshot();
    });
});

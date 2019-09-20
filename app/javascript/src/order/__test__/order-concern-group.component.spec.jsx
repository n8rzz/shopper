import React from 'react';
import sinon from 'sinon';
import { shallow } from 'enzyme';
import { OrderConcernGroup } from '../order-concern-group.component';
// TODO: implement tests for all states of the filter
import { FILTER_CONCERN } from '../../constants/filter-concern';
import {
    assemblyListMock,
    assemblyMapMock,
    csrfMock,
    departmentListMock,
    departmentMapMock,
    locationDepartmentListMock,
    orderItemListMock,
    itemListMock,
    itemMapMock,
} from '../../__mocks__/mocks';

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
            locationDepartments={locationDepartmentListMock}
            orderItems={orderItemListMock}
            onClickIsPickedHandler={sinon.spy()}
            onClickRemoveItemHandler={sinon.spy()}
        />);

        expect(component).toMatchSnapshot();
    });
});

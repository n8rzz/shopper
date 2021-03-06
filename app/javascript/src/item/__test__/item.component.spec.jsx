import React from 'react';
import sinon from 'sinon';
import { shallow } from 'enzyme';
import { Item } from '../item.component';
import { csrfMock, itemMock } from '../../__mocks__/mocks';

describe('Item', () => {
    test('renders correctly with valid props', () => {
        const component = shallow(<Item
            csrf={csrfMock}
            departmentId={itemMock.department_id}
            departmentName={'meat'}
            itemId={itemMock.id}
            itemName={itemMock.name}
            isSubmitting={false}
            isSubmitSuccess={false}
            onSubmitHandler={sinon.spy()}
        />);

        expect(component).toMatchSnapshot();
    });
});

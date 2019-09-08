import React from 'react';
import sinon from 'sinon';
import { shallow } from 'enzyme';
import { ScheduleItem } from '../schedule-item.component';
import {
    assemblyMock,
    itemMock,
    mealScheduleItemMock,
} from '../../__mocks__/mocks';

describe('ScheduleItem', () => {
    describe('when passed an assembly', () => {
        test('renders correctly with valid props', () => {
            const component = shallow(<ScheduleItem
                mealScheduleId={mealScheduleItemMock.id}
                scheduleItem={assemblyMock}
                onClickRemoveHandler={sinon.spy()}
            />);

            expect(component).toMatchSnapshot();
        });
    });

    describe('when passed an item', () => {
        test('renders correctly with valid props', () => {
            const component = shallow(<ScheduleItem
                mealScheduleId={mealScheduleItemMock.id}
                scheduleItem={itemMock}
                onClickRemoveHandler={sinon.spy()}
            />);

            expect(component).toMatchSnapshot();
        });
    });
});

import React from 'react';
import sinon from 'sinon';
import { shallow } from 'enzyme';
import { DayScheduleList } from '../day-schedule-list.component';
import {
    assemblyMapMock,
    itemMapMock,
    mealScheduleMapMock,
} from '../../__mocks__/mocks';

const dayScheduleMock = '2019-09-10T00:00:00.000Z';

describe('DayScheduleList', () => {
    test('renders correctly with valid props', () => {
        const component = shallow(<DayScheduleList
            assemblies={assemblyMapMock}
            daySchedule={dayScheduleMock}
            items={itemMapMock}
            mealScheduleMap={mealScheduleMapMock}
            onClickRemoveHandler={sinon.spy()}
        />);

        expect(component).toMatchSnapshot();
    });
});

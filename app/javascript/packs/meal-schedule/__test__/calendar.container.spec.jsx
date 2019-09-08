import React from 'react';
import moment from 'moment';
import sinon from 'sinon';
import { shallow } from 'enzyme';
import { CalendarContainer } from '../calendar-container';
import {
    currentDateMock,
    mealScheduleListMock,
} from '../../__mocks__/mocks';

const currentDateFixture = moment(currentDateMock);

describe('CalendarContainer', () => {
    test('renders correctly with valid props', () => {
        const component = shallow(<CalendarContainer
            currentDate={currentDateFixture}
            mealSchedules={mealScheduleListMock}
            onClickPreviousMonthHandler={sinon.spy()}
            onClickNextMonthHandler={sinon.spy()}
            onClickDayHandler={sinon.spy()}
        />);

        expect(component).toMatchSnapshot();
    });
});

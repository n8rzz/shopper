import React from 'react';
import sinon from 'sinon';
import { shallow } from 'enzyme';
import { CalendarDay } from '../calendar-day.component';
import { mealScheduleListMock } from '../../__mocks__/mocks';

const dayNumberMock = 4;

describe('CalendarDay', () => {
    test('renders correctly with valid props', () => {
        const component = shallow(<CalendarDay
            dayNumber={dayNumberMock}
            onClickDayHandler={sinon.spy()}
        />);

        expect(component).toMatchSnapshot();
    });

    test('renders correctly when passed #mealSchedules prop', () => {
        const component = shallow(<CalendarDay
            dayNumber={dayNumberMock}
            mealSchedules={mealScheduleListMock}
            onClickDayHandler={sinon.spy()}
        />);

        expect(component).toMatchSnapshot();
    });
});

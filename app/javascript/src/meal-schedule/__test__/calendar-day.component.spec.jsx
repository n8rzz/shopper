import React from 'react';
import sinon from 'sinon';
import { mount, shallow } from 'enzyme';
import { CalendarDay } from '../calendar-day.component';
import { mealScheduleListMock } from '../../__mocks__/mocks';

const dayNumberMock = 4;

describe('CalendarDay', () => {
    test('renders correctly with valid props', () => {
        const component = shallow(<CalendarDay
            dayNumber={dayNumberMock}
            isToday={false}
            onClickDayHandler={sinon.spy()}
        />);

        expect(component).toMatchSnapshot();
    });

    test('renders correctly when passed #mealSchedules prop', () => {
        const component = shallow(<CalendarDay
            dayNumber={dayNumberMock}
            isToday={false}
            mealSchedules={mealScheduleListMock}
            onClickDayHandler={sinon.spy()}
        />);

        expect(component).toMatchSnapshot();
    });

    describe('#isToday prop', () => {
        test('when passed as true', () => {
            const wrapper = mount(
                <table>
                    <tbody>
                        <tr>
                            <CalendarDay
                                dayNumber={dayNumberMock}
                                isToday={true}
                                mealSchedules={mealScheduleListMock}
                                onClickDayHandler={sinon.spy()}
                            />
                        </tr>
                    </tbody>
                </table>,
            );
            const element = wrapper.find('.calendarTable-td-cell');

            expect(element.hasClass('mix-calendarTable-td-cell_isToday')).toEqual(true);
        });

        test('when passed as false', () => {
            const wrapper = mount(
                <table>
                    <tbody>
                        <tr>
                            <CalendarDay
                                dayNumber={dayNumberMock}
                                isToday={false}
                                mealSchedules={mealScheduleListMock}
                                onClickDayHandler={sinon.spy()}
                            />
                        </tr>
                    </tbody>
                </table>,
            );
            const element = wrapper.find('.calendarTable-td');

            expect(element.hasClass('mix-calendarTable-td-cell_isToday')).toEqual(false);
        });
    });
});

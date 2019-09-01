import React from 'react';
import sinon from 'sinon';
import { shallow } from 'enzyme';
import { MealSchedulePage } from '../meal-schedule.page';
import {
    assemblyMapMock,
    csrfMock,
    currentDateMock,
    itemMapMock,
    mealScheduleListMock,
} from '../../__mocks__/mocks';

describe('MealSchedulePage', () => {
    test('renders correctly with valid props', () => {
        const component = shallow(<MealSchedulePage
            assemblies={assemblyMapMock}
            csrf={csrfMock}
            currentDate={currentDateMock}
            items={itemMapMock}
            mealSchedules={mealScheduleListMock}
            onClickRemoveHandler={sinon.spy()}
        />);

        expect(component).toMatchSnapshot();
    });
});

import React from 'react';
import moment from 'moment';
import sinon from 'sinon';
import { shallow } from 'enzyme';
import { EventListContainer } from '../event-list.container';
import {
    assemblyMapMock,
    currentDateMock,
    itemMapMock,
    mealScheduleListMock,
} from '../../__mocks__/mocks';

const currentDateFixture = moment(currentDateMock);

describe('EventListContainer', () => {
    test('renders correctly with valid props', () => {
        const component = shallow(<EventListContainer
            assemblies={assemblyMapMock}
            currentDate={currentDateFixture}
            items={itemMapMock}
            mealSchedules={mealScheduleListMock}
            onClickRemoveHandler={sinon.spy()}
        />);

        expect(component).toMatchSnapshot();
    });
});

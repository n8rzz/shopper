import React from 'react';
import sinon from 'sinon';
import { shallow } from 'enzyme';
import { SortedDepartmentList } from '../sorted-department-list.component';
import { departmentMapMock, locationDepartmentListMock } from '../../__mocks__/mocks';

describe('SortedDepartmentList', () => {
    let component = null;
    let eventMock = null;
    let onClickChangeDirectionHandlerSpy = null;
    let onClickRemoveHandlerSpy = null;

    beforeEach(() => {
        onClickChangeDirectionHandlerSpy = sinon.spy();
        onClickRemoveHandlerSpy = sinon.spy();
        eventMock = {
            preventDefault: sinon.spy,
        };
        component = shallow(<SortedDepartmentList
            departmentMap={departmentMapMock}
            locationDepartments={locationDepartmentListMock}
            onClickChangeDirectionHandler={onClickChangeDirectionHandlerSpy}
            onClickRemoveHandler={onClickRemoveHandlerSpy}
        />);
    });

    afterEach(() => {
        component = null;
        eventMock = null;
        onClickChangeDirectionHandlerSpy = null;
        onClickRemoveHandlerSpy = null;
    });

    test('renders correctly with valid props', () => {
        expect(component).toMatchSnapshot();
    });

    describe('.componentWillUnmount()', () => {
        test('unsets handlers', () => {
            component.instance().componentWillUnmount();

            expect(component.instance()._onClickUpHandler).toBe(null);
            expect(component.instance()._onClickDownHandler).toBe(null);
            expect(component.instance()._onClickRemoveHandler).toBe(null);
        });
    });

    describe('._onClickUp()', () => {
        test('calls .props.onClickChangeDirectionHandler() with correct args', () => {
            component.instance()._onClickUp(eventMock, locationDepartmentListMock[0]);

            expect(onClickChangeDirectionHandlerSpy.calledWithExactly(locationDepartmentListMock[0], 'UP')).toBe(true);
        });
    });

    describe('._onClickDown()', () => {
        test('calls .props.onClickChangeDirectionHandler() with correct args', () => {
            component.instance()._onClickDown(eventMock, locationDepartmentListMock[0]);

            expect(
                onClickChangeDirectionHandlerSpy.calledWithExactly(locationDepartmentListMock[0], 'DOWN'),
            ).toBe(true);
        });
    });

    describe('._onClickRemove()', () => {
        test('calls .props.onClickChangeDirectionHandler() with correct args', () => {
            component.instance()._onClickRemove(eventMock, locationDepartmentListMock[0]);

            expect(onClickRemoveHandlerSpy.calledWithExactly(locationDepartmentListMock[0])).toBe(true);
        });
    });
});

import React from 'react';
import sinon from 'sinon';
import { mount, shallow } from 'enzyme';

import { StepperContainer } from '../stepper.container';
import { csrfMock, itemMock } from '../../../__mocks__/mocks';

describe('StepperContainer', () => {
    let component = null;
    let onSubmitHandlerSpy = null;

    beforeEach(() => {
        onSubmitHandlerSpy = sinon.spy();
        component = mount(<StepperContainer
            csrf={csrfMock}
            departmentId={itemMock.department_id}
            itemId={itemMock.id}
            itemName={itemMock.name}
            isSubmitting={false}
            isSubmitSuccess={false}
            onSubmitHandler={onSubmitHandlerSpy}
        />);
    });

    afterEach(() => {
        onSubmitHandlerSpy = null;
        component = null;
    });

    test('renders correctly with valid props', () => {
        const shallowComponent = shallow(<StepperContainer
            csrf={csrfMock}
            departmentId={itemMock.department_id}
            itemId={itemMock.id}
            itemName={itemMock.name}
            isSubmitting={false}
            isSubmitSuccess={false}
            onSubmitHandler={sinon.spy()}
        />);

        expect(shallowComponent).toMatchSnapshot();
    });

    describe('decrease btn element', () => {
        test('contains decrease btn element', () => {
            const decreaseBtn = component.find('.js-stepper-btn-decrease');

            expect(decreaseBtn.length).toBe(1);
        });

        test('responds to click', () => {
            const instance = component.instance();
            component.setState({ qty: 2 });

            instance._onClickDecrease();

            expect(component.state('qty')).toBe(1);
        });

        test('does not decrease passed 1', () => {
            const instance = component.instance();
            component.setState({ qty: 1 });

            instance._onClickDecrease();

            expect(component.state('qty')).toBe(1);
        });
    });

    describe('increase btn element', () => {
        test('contains increase btn element', () => {
            const increaseBtn = component.find('.js-stepper-btn-increase');

            expect(increaseBtn.length).toBe(1);
        });

        test('responds to click', () => {
            const instance = component.instance();

            instance._onClickIncrease();

            expect(component.state('qty')).toBe(2);
        });
    });

    describe('submit element', () => {
        test('contains submit btn element', () => {
            const submitBtn = component.find('.stepper-ft-submit');

            expect(submitBtn.length).toBe(1);
        });

        test('responds to click', () => {
            const eventMock = {
                stopPropagation: sinon.spy(),
                preventDefault: sinon.spy(),
            };
            const instance = component.instance();

            instance._onClickSubmit(eventMock);

            expect(onSubmitHandlerSpy.calledWith(component.state('qty'))).toBe(true);
        });

        test('returns early if #qty is < 1', () => {
            const eventMock = {
                stopPropagation: sinon.spy(),
                preventDefault: sinon.spy(),
            };
            const instance = component.instance();

            component.setState({ qty: 0 });
            instance._onClickSubmit(eventMock);

            expect(onSubmitHandlerSpy.callCount).toBe(0);
        });

        test('resets #qty to 1 after submit', () => {
            const eventMock = {
                stopPropagation: sinon.spy(),
                preventDefault: sinon.spy(),
            };
            const instance = component.instance();

            component.setState({ qty: 3 });
            instance._onClickSubmit(eventMock);

            expect(component.state('qty')).toBe(1);
        });
    });
});

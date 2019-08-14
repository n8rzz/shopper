import React from 'react';
import sinon from 'sinon';
import { mount, shallow } from 'enzyme';

import { StepperContainer } from '../stepper.container';
import { Stepper } from '../stepper';
import { csrfMock } from '../../../__mocks__/csrf.mock';
import { itemMock } from '../../../__mocks__/item.mock';

describe('StepperContainer', () => {
    let component = null;

    beforeEach(() => {
        component = mount(<StepperContainer
            csrf={csrfMock}
            departmentId={itemMock.department_id}
            itemId={itemMock.id}
            itemName={itemMock.name}
            isSubmitting={false}
            isSubmitSuccess={false}
            onSubmitHandler={sinon.spy()}
        />);
    });

    afterEach(() => {
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
            const onClickDecreaseHandlerSpy = sinon.spy();

            component.props.onClickDecreaseHandler = onClickDecreaseHandlerSpy;
            const stepperChild = component.find(Stepper);

            stepperChild.props.onClickDecreaseHandler();

            expect(onClickDecreaseHandlerSpy.callCount).toBe(1);
        });
    });

    describe('increase btn element', () => {
        test('contains increase btn element', () => {
            const increaseBtn = component.find('.js-stepper-btn-increase');

            expect(increaseBtn.length).toBe(1);
        });

        test('responds to click', () => {
            const onClickIncreaseHandlerSpy = sinon.spy();

            component.props.onClickIncreaseHandler = onClickIncreaseHandlerSpy;
            const stepperChild = component.find(Stepper);

            stepperChild.props.onClickIncreaseHandler();

            expect(onClickIncreaseHandlerSpy.callCount).toBe(1);
        });
    });
});

import React from 'react';
import sinon from 'sinon';
import {mount, shallow} from 'enzyme';

import {StepperContainer} from '../stepper.container';
import { Stepper } from '../stepper';

describe('StepperContainer', () => {
    test('renders correctly with valid props', () => {
        const component = shallow(<StepperContainer
            itemId={42}
            itemName={"$texas"}
            departmentId={32}
            csrf={"3yIq75tyV791TFkzSZo/S4b+TVa/N5J3dI14PzMUPviGViEGeDSnGnvNix+MaB0RB0XuV7bpX8I3SmIEAr4/zQ=="}
        />);

        expect(component).toMatchSnapshot();
    });

    describe('decrease btn element', () => {
        let component;

        beforeEach(() => {
            component = mount(<StepperContainer
                itemId={42}
                itemName={"$texas"}
                departmentId={32}
                csrf={"3yIq75tyV791TFkzSZo/S4b+TVa/N5J3dI14PzMUPviGViEGeDSnGnvNix+MaB0RB0XuV7bpX8I3SmIEAr4/zQ=="}
            />);
        });

        afterEach(() => {
            component = null;
        });

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
        let component;

        beforeEach(() => {
            component = mount(<StepperContainer
                itemId={42}
                itemName={"$texas"}
                departmentId={32}
                csrf={"3yIq75tyV791TFkzSZo/S4b+TVa/N5J3dI14PzMUPviGViEGeDSnGnvNix+MaB0RB0XuV7bpX8I3SmIEAr4/zQ=="}
            />);
        });

        afterEach(() => {
            component = null;
        });

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

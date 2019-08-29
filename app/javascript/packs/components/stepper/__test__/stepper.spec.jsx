import React from 'react';
import { mount, shallow } from 'enzyme';
import { Stepper } from '../stepper';

describe('Stepper', () => {
    let component;

    beforeEach(() => {
        component = shallow(<Stepper
            itemId={42}
            qty={3}
            isSubmitting={false}
            isSubmitSuccess={false}
            onClickDecreaseHandler={jest.fn()}
            onClickIncreaseHandler={jest.fn()}
            onClickSubmitHandler={jest.fn()}
        />);
    });

    afterEach(() => {
        component = null;
    });

    test('renders correctly with valid props', () => {
        const mountedComponent = mount(<Stepper
            itemId={42}
            qty={3}
            isSubmitting={false}
            isSubmitSuccess={false}
            onClickDecreaseHandler={jest.fn()}
            onClickIncreaseHandler={jest.fn()}
            onClickSubmitHandler={jest.fn()}
        />);

        expect(mountedComponent).toMatchSnapshot();
        mountedComponent.unmount();
    });

    test('contains decrease btn element', () => {
        const decreaseBtn = component.find('.js-stepper-btn-decrease');

        expect(decreaseBtn.length).toBe(1);
    });

    test('contains increase btn element', () => {
        const increaseBtn = component.find('.js-stepper-btn-increase');

        expect(increaseBtn.length).toBe(1);
    });

    test('contains add to order btn element', () => {
        const submitBtn = component.find('.stepper-ft-submit');

        expect(submitBtn.length).toBe(1);
    });

    describe('when #isSubmitting is true', () => {
        let isSubmittingComponent;

        beforeEach(() => {
            isSubmittingComponent = shallow(<Stepper
                itemId={42}
                qty={3}
                isSubmitting={true}
                isSubmitSuccess={false}
                onClickDecreaseHandler={jest.fn()}
                onClickIncreaseHandler={jest.fn()}
                onClickSubmitHandler={jest.fn()}
            />);
        });

        afterEach(() => {
            isSubmittingComponent = null;
        });

        test('it should add correct className to btn', () => {
            const submitBtn = isSubmittingComponent.find('.mix-btn_isLoading');

            expect(submitBtn.length).toBe(1);
        });

        test('it should render correct btn value', () => {
            const submitBtn = isSubmittingComponent.find('.stepper-ft-submit');

            expect(submitBtn.props().value).toBe('Adding...');
        });
    });

    describe('when #isSubmitSuccess is true', () => {
        let isSubmitSucessComponent;

        beforeEach(() => {
            isSubmitSucessComponent = shallow(<Stepper
                itemId={42}
                qty={3}
                isSubmitting={false}
                isSubmitSuccess={true}
                onClickDecreaseHandler={jest.fn()}
                onClickIncreaseHandler={jest.fn()}
                onClickSubmitHandler={jest.fn()}
            />);
        });

        afterEach(() => {
            isSubmitSucessComponent = null;
        });

        test('it should add correct className to btn', () => {
            const submitBtn = isSubmitSucessComponent.find('.mix-btn_isSuccess');

            expect(submitBtn.length).toBe(1);
        });

        test('it should render correct btn value', () => {
            const submitBtn = isSubmitSucessComponent.find('.stepper-ft-submit');

            expect(submitBtn.props().value).toBe('Success!');
        });
    });
});

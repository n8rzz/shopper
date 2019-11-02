import React from 'react';
import { mount, shallow } from 'enzyme';

import { NoticeContainer } from '../notice.container';

const messageMock = 'this is a notice!';

describe('NoticeContainer', () => {
    describe('when called with an empty #mesage prop', () => {
        test('renders correctly', () => {
            let component = shallow(<NoticeContainer
                message={''}
            />);

            expect(component).toMatchSnapshot();

            component = shallow(<NoticeContainer
                message={null}
            />);

            expect(component).toMatchSnapshot();
        });
    });

    describe('when called with #message', () => {
        let component = null;

        beforeEach(() => {
            component = shallow(<NoticeContainer
                message={messageMock}
            />);
        });

        afterEach(() => {
            component = null;
        });

        test('renders correctly with valid props', () => {
            expect(component).toMatchSnapshot();
        });

        test('#_timer should not equal -1', () => {
            expect(component.instance()._time).not.toBe(-1);
        });
    });

    describe('`stickyHeader`', () => {
        let component = null;

        beforeEach(() => {
            component = mount(<NoticeContainer
                message={messageMock}
            />);
        });

        afterEach(() => {
            component = null;
        });

        describe('when `stickyHeader` is not sticky', () => {
            test('._onStickyStateChange() returns correct classnames', () => {
                const stickyEventMock = { status: 0 };

                component.instance()._onStickyStateChange(stickyEventMock);
                component.update();

                expect(component.find('.js-notice').hasClass('mix-stickyHeader_isSticky')).toBe(false);
            });
        });

        describe('when `stickyHeader` is sticky', () => {
            test('._onStickyStateChange() returns correct classnames', () => {
                const stickyEventMock = { status: 2 };

                component.instance()._onStickyStateChange(stickyEventMock);
                component.update();

                expect(component.find('.js-notice').hasClass('mix-stickyHeader_isSticky')).toBe(true);
            });
        });
    });
});

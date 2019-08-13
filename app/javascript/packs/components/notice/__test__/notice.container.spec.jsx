import React from 'react';
import { mount, shallow } from 'enzyme';

import { NoticeContainer } from '../notice.container';

const messageMock = 'this is a notice!';

describe('NoticeContainer', () => {
    describe('renders correctly with valid props', () => {
        test('when called with a non-empty #mesage prop', () => {
            const component = shallow(<NoticeContainer
                message={messageMock}
            />);

            expect(component).toMatchSnapshot();
        });

        test('when called with an empty #mesage prop', () => {
            const component = shallow(<NoticeContainer
                message={''}
            />);

            expect(component).toMatchSnapshot();
        });

        test('when called with a null #mesage prop', () => {
            const component = shallow(<NoticeContainer
                message={null}
            />);

            expect(component).toMatchSnapshot();
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

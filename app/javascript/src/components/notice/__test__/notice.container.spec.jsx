import React from 'react';
import sinon from 'sinon';
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

    describe('when called with an empty #alert prop', () => {
        test('renders correctly', () => {
            let component = shallow(<NoticeContainer
                alert={''}
            />);

            expect(component).toMatchSnapshot();

            component = shallow(<NoticeContainer
                alert={null}
            />);

            expect(component).toMatchSnapshot();
        });
    });

    describe('when called with #alert', () => {
        let component = null;

        beforeEach(() => {
            component = shallow(<NoticeContainer
                alert={messageMock}
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

        test('should render iwth correct classnames', () => {
            expect(component.hasClass('mix-notice_isAlert')).not.toBe(true);
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

    describe('._onTriggerImmediateRemoval()', () => {
        describe('when #_timer is null', () => {
            test('._updateNoticeVisibility() is not called', () => {
                const component = mount(<NoticeContainer
                    message={null}
                />);
                const instance = component.instance();
                const _updateNoticeVisibilitySpy = sinon.spy(instance, '_updateNoticeVisibility');

                instance._onTriggerImmediateRemoval();

                expect(_updateNoticeVisibilitySpy.callCount).toBe(0);

                _updateNoticeVisibilitySpy.restore();
            });
        });

        describe('when #_timer is not null', () => {
            test('._updateNoticeVisibility() is called', () => {
                const component = mount(<NoticeContainer
                    message={messageMock}
                />);
                const instance = component.instance();
                const _updateNoticeVisibilitySpy = sinon.spy(instance, '_updateNoticeVisibility');
                instance._timer = 10;

                instance._onTriggerImmediateRemoval();

                expect(_updateNoticeVisibilitySpy.callCount).toBe(1);

                _updateNoticeVisibilitySpy.restore();
            });

            test('resets #_timer to -1', () => {
                const component = mount(<NoticeContainer
                    message={messageMock}
                />);
                const instance = component.instance();
                instance._timer = 10;

                instance._onTriggerImmediateRemoval();

                expect(instance._timer).toBe(-1);
            });
        });
    });
});

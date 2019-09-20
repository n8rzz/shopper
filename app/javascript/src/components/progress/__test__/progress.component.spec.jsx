import React from 'react';
import { shallow } from 'enzyme';
import { Progress } from '../progress.component';

describe('Progress', () => {
    describe('when `currentCount` < `totalCount`', () => {
        test('renders correctly with valid props', () => {
            const component = shallow(<Progress
                currentCount={10}
                totalCount={13}
            />);

            expect(component).toMatchSnapshot();
        });
    });

    describe('when `currentCount` === `totalCount`', () => {
        test('renders correctly with correct css classnames', () => {
            const component = shallow(<Progress
                currentCount={13}
                totalCount={13}
            />);

            expect(component.find('.progress-bar-fill').hasClass('mix-progress-bar-fill_isComplete')).toBe(true);
        });
    });
});

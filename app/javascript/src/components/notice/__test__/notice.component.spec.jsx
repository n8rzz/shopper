import React from 'react';
import { shallow } from 'enzyme';

import { Notice } from '../notice.component';

const messageMock = 'this is a notice!';

describe('Notice', () => {
    test('renders correctly when passed a #message', () => {
        const component = shallow(<Notice
            message={messageMock}
            isAlert={false}
            isVisible={true}
        />);

        expect(component).toMatchSnapshot();
    });

    test('renders correctly when passed an #alert', () => {
        const component = shallow(<Notice
            message={messageMock}
            isAlert={true}
            isVisible={true}
        />);

        expect(component).toMatchSnapshot();
    });

    test('renders with correct classnames when passed an #alert', () => {
        const component = shallow(<Notice
            message={messageMock}
            isAlert={true}
            isVisible={true}
        />);

        expect(component.hasClass('mix-notice_isAlert')).toBe(true);
    });
});

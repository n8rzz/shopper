import React from 'react';
import { shallow } from 'enzyme';

import { Notice } from '../notice.component';

const messageMock = 'this is a notice!';

describe('Notice', () => {
    test('renders correctly with valid props', () => {
        const component = shallow(<Notice
            message={messageMock}
            isVisible={true}
        />);

        expect(component).toMatchSnapshot();
    });
});

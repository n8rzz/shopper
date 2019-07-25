import React from 'react';
import {shallow} from 'enzyme';

import { NoticeContainer } from '../notice.container';

const messageMock = 'this is a notice!'

describe('NoticeContainer', () => {
    test('renders correctly with valid props', () => {
        const component = shallow(<NoticeContainer
            message={messageMock}
        />);

        expect(component).toMatchSnapshot();
    });
});

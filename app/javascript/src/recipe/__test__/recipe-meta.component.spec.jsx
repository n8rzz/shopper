import React from 'react';
import { shallow } from 'enzyme';
import { recipeMock } from '../../__mocks__/mocks';
import { RecipeMetaComponent } from '../recipe-meta.component';

describe('RecipeMetaComponent', () => {
    test('renders correctly with valid props', () => {
        const component = shallow(<RecipeMetaComponent
            description={recipeMock.description}
            prepTime={recipeMock.prep_time}
            cookTime={recipeMock.cook_time}
            yieldValue={recipeMock.yield_value}
            yieldUnit={recipeMock.yield_unit}
        />);

        expect(component).toMatchSnapshot();
    });
});

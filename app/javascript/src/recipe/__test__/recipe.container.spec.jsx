import React from 'react';
import { shallow } from 'enzyme';
import {
    recipeIngredientMock,
    recipeInstructionMock,
    recipeMock,
} from '../../__mocks__/mocks';
import { RecipeContainer } from '../recipe.container';

describe('RecipeContainer', () => {
    test('renders correctly with valid props', () => {
        const component = shallow(<RecipeContainer
            recipe={recipeMock}
            ingredients={[recipeIngredientMock]}
            instructions={[recipeInstructionMock]}
            itemsById={{}}
        />);

        expect(component).toMatchSnapshot();
    });
});

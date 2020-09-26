import React from 'react';
import { shallow } from 'enzyme';
import {
    recipeIngredientMock,
    recipeInstructionMock,
    recipeMock,
} from '../../__mocks__/mocks';
import { RecipeFormContainer } from '../recipe-form.container';

describe('RecipeFormContainer', () => {
    test('renders correctly with valid props', () => {
        const component = shallow(<RecipeFormContainer
            recipe={recipeMock}
            ingredients={[recipeIngredientMock]}
            instructions={[recipeInstructionMock]}
            itemsById={{}}
        />);

        expect(component).toMatchSnapshot();
    });
});

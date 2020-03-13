import React from 'react';
import { mount, shallow } from 'enzyme';
import {
    itemMapMock,
    recipeIngredientMock,
} from '../../__mocks__/mocks';
import { RecipeIngredientsComponent } from '../recipe-ingredients.component';

describe('RecipeIngredientsComponent', () => {
    describe('when called without `#ingredients`', () => {
        test('renders correctly with valid props', () => {
            const component = mount(<RecipeIngredientsComponent
                ingredients={[]}
                itemsById={itemMapMock}
            />);

            expect(component.exists('.island')).toEqual(false);
        });
    });

    describe('when called with `#ingredients`', () => {
        test('renders correctly with valid props', () => {
            const component = shallow(<RecipeIngredientsComponent
                ingredients={[recipeIngredientMock]}
                itemsById={itemMapMock}
            />);

            expect(component).toMatchSnapshot();
        });
    });
});

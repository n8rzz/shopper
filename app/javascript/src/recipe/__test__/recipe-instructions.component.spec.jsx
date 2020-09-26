import React from 'react';
import { mount, shallow } from 'enzyme';
import { recipeInstructionMock } from '../../__mocks__/mocks';
import { RecipeInstructionsComponent } from '../recipe-instructions.component';

describe('RecipeInstructionsComponent', () => {
    describe('when called without `#instructions`', () => {
        test('renders correctly with valid props', () => {
            const component = mount(<RecipeInstructionsComponent
                instructions={[]}
            />);

            expect(component.exists('.island')).toEqual(false);
        });
    });

    describe('when called with `#instructions`', () => {
        test('renders correctly with valid props', () => {
            const component = shallow(<RecipeInstructionsComponent
                instructions={[recipeInstructionMock]}
            />);

            expect(component).toMatchSnapshot();
        });
    });
});

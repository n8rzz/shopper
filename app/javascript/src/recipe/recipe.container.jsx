import React from 'react';
import PropTypes from 'prop-types';
import { RecipeIngredientsComponent } from './recipe-ingredients.component';
import { RecipeInstructionsComponent } from './recipe-instructions.component';
import { RecipeMetaComponent } from './recipe-meta.component';

export function RecipeContainer(props) {
    // TODO: maybe .vlist instead of .vr?
    return (
        <ul className={'vlist'}>
            <li>
                <RecipeMetaComponent
                    description={props.recipe.description}
                    prepTime={props.recipe.prep_time}
                    cookTime={props.recipe.cook_time}
                    yieldValue={props.recipe.yield_value}
                    yieldUnit={props.recipe.yield_unit}
                />
            </li>
            <li>
                <RecipeIngredientsComponent
                    ingredients={props.ingredients}
                    itemsById={props.itemsById}
                />
            </li>
            <li>
                <RecipeInstructionsComponent instructions={props.instructions} />
            </li>
        </ul>
    );
}

RecipeContainer.propTypes = {
    recipe: PropTypes.object.isRequired,
    ingredients: PropTypes.array.isRequired,
    instructions: PropTypes.array.isRequired,
    itemsById: PropTypes.object.isRequired,
};

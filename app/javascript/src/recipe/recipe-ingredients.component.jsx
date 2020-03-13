import React from 'react';
import PropTypes from 'prop-types';

export function RecipeIngredientsComponent(props) {
    const _buildRecipeIngredientsJsx = () => props.ingredients.map((ingredient, index) => {
        const itemName = ingredient.name || props.itemsById[ingredient.item_id].name;

        return (
            <li
                key={`ingredient-${index}`}
                className={'recipeIngredients-list-item'}
            >
                <ul className={'hlist'}>
                    <li>{ ingredient.qty_value } <span>{ ingredient.qty_unit }</span></li>
                    <li>{ itemName }</li>
                </ul>
            </li>
        );
    });

    if (props.ingredients.length === 0) {
        return null;
    }

    return (
        <div className={'recipeIngredients'}>
            <ul className={'recipeIngredients-list'}>
                { _buildRecipeIngredientsJsx() }
            </ul>
        </div>
    );
}

RecipeIngredientsComponent.propTypes = {
    ingredients: PropTypes.array.isRequired,
    itemsById: PropTypes.object.isRequired,
};

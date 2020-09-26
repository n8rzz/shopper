import React from 'react';
import PropTypes from 'prop-types';

export function RecipeInstructionsComponent(props) {
    if (props.instructions.length === 0) {
        return null;
    }

    return (
        <div className={'recipeInstructions'}>
            <ol className={'recipeInstructions-list'}>
                {props.instructions.map((instruction, index) => (
                    <li
                        key={`instruction-${index}`}
                        className={'recipeInstructions-list-item'}
                    >
                        {instruction.text}
                    </li>
                ))}
            </ol>
        </div>
    );
}

RecipeInstructionsComponent.propTypes = {
    instructions: PropTypes.array.isRequired,
};

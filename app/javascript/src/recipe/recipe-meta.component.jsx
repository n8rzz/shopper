import React from 'react';
import PropTypes from 'prop-types';

export function RecipeMetaComponent(props) {
    const _buildRecipeMetaJsx = () => (
        <ul className={'recipeMeta-list'}>
            <li className={'recipeMeta-list-item'}>
                <div>Prep</div>
                <div>{ props.prepTime } minutes</div>
            </li>
            <li className={'recipeMeta-list-item'}>
                <div>Cook</div>
                <div>{ props.cookTime } minutes</div>
            </li>
            <li className={'recipeMeta-list-item'}>
                <div>Serves</div>
                <div>{`${props.yieldValue} ${props.yieldUnit}`}</div>
            </li>
        </ul>
    );

    return (
        <div className={'recipeMeta'}>
            <div className={'vr_4'}>
                { props.description }
            </div>
            { _buildRecipeMetaJsx() }
        </div>
    );
}

RecipeMetaComponent.propTypes = {
    description: PropTypes.string.isRequired,
    prepTime: PropTypes.number.isRequired,
    cookTime: PropTypes.number.isRequired,
    yieldValue: PropTypes.number.isRequired,
    yieldUnit: PropTypes.string.isRequired,
};

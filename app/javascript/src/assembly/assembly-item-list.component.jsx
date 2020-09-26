import React from 'react';
import PropTypes from 'prop-types';
import { AssemblyItemContainer } from './assembly-item.container';

export function AssemblyItemList(props) {
    return (
        <ul className={'vlist mix-vlist_isClickable js-accordionList'}>
            {props.assemblies.map((assembly) => {
                const foundRecipe = props.recipes.filter((recipe) => recipe.assembly_id === assembly.id)[0];

                return (
                    <AssemblyItemContainer
                        key={`assemblyItemContainer-${assembly.name}`}
                        assembly={assembly}
                        assemblyItemsGroupedByAssemblyId={props.assemblyItemsGroupedByAssemblyId}
                        csrf={props.csrf}
                        departmentIdMap={props.departmentIdMap}
                        itemIdMap={props.itemIdMap}
                        recipe={foundRecipe}
                    />
                );
            })}
        </ul>
    );
}

AssemblyItemList.propTypes = {
    assemblies: PropTypes.array.isRequired,
    assemblyItemsGroupedByAssemblyId: PropTypes.object.isRequired,
    csrf: PropTypes.string.isRequired,
    departmentIdMap: PropTypes.object.isRequired,
    itemIdMap: PropTypes.object.isRequired,
    recipes: PropTypes.array.isRequired,
};

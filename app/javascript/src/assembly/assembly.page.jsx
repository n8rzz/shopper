import React from 'react';
import PropTypes from 'prop-types';
import groupBy from 'lodash/groupBy';
import keyBy from 'lodash/keyBy';
import { AssemblyItemList } from './assembly-item-list.component';

export function AssemblyPage(props) {
    const assemblyItemsGroupedByAssemblyId = groupBy(props.assemblyItems, 'assembly_id');
    const departmentIdMap = keyBy(props.departments, 'id');
    const itemIdMap = keyBy(props.items, 'id');

    return (
        <AssemblyItemList
            assemblies={props.assemblies}
            assemblyItemsGroupedByAssemblyId={assemblyItemsGroupedByAssemblyId}
            csrf={props.csrf}
            departmentIdMap={departmentIdMap}
            itemIdMap={itemIdMap}
            recipes={props.recipes}
        />
    );
}

AssemblyPage.propTypes = {
    assemblies: PropTypes.array.isRequired,
    assemblyItems: PropTypes.array.isRequired,
    csrf: PropTypes.string.isRequired,
    departments: PropTypes.array.isRequired,
    items: PropTypes.array.isRequired,
    recipes: PropTypes.array.isRequired,
};

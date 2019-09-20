import React from 'react';
import PropTypes from 'prop-types';
import { AssemblyItemContainer } from './assembly-item.container';

export function AssemblyItemList(props) {
    return (
        <ul className={'vlist mix-vlist_isClickable js-accordionList'}>
            {props.assemblies.map((assembly, index) => (
                <AssemblyItemContainer
                    key={`assemblyItemContainer-${index}`}
                    assembly={assembly}
                    assemblyItemsGroupedByAssemblyId={props.assemblyItemsGroupedByAssemblyId}
                    csrf={props.csrf}
                    departmentIdMap={props.departmentIdMap}
                    itemIdMap={props.itemIdMap}
                />
            ))}
        </ul>
    );
}

AssemblyItemList.propTypes = {
    assemblies: PropTypes.array.isRequired,
    assemblyItemsGroupedByAssemblyId: PropTypes.object.isRequired,
    csrf: PropTypes.string.isRequired,
    departmentIdMap: PropTypes.object.isRequired,
    itemIdMap: PropTypes.object.isRequired,
};

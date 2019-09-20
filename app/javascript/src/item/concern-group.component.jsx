import React from 'react';
import PropTypes from 'prop-types';
import { ItemList } from './item-list.component';

export function ConcernGroup(props) {
    return (
        <div
            className={'concernGroup'}
            key={`concernGroup-${props.groupName}`}
        >
            <div className={'concernGroup-hd'}>
                <h2>{props.groupName}</h2>
            </div>
            <ItemList
                csrf={props.csrf}
                departmentMap={props.departmentMap}
                itemList={props.itemList}
            />
        </div>
    );
}

ConcernGroup.propTypes = {
    csrf: PropTypes.string.isRequired,
    departmentMap: PropTypes.object.isRequired,
    groupName: PropTypes.string.isRequired,
    itemList: PropTypes.array.isRequired,
};

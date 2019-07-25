import React from 'react';
import PropTypes from 'prop-types';
import { Item } from './item.component';

export function ItemList(props) {
    if (props.itemList.length === 0) {
        return null;
    }

    return (
        <ul className={'vlist'}>
            {props.itemList.map((item, index) => (
                <Item
                    csrf={props.csrf}
                    departmentId={item.department_id}
                    departmentName={props.departmentMap[item.department_id].name}
                    itemId={item.id}
                    itemName={item.name}
                    key={`item-${index}`}
                />
            ))}
        </ul>
    );
}

ItemList.propTypes = {
    csrf: PropTypes.string.isRequired,
    departmentMap: PropTypes.object.isRequired,
    itemList: PropTypes.array.isRequired,
};

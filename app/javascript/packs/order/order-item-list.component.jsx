import React from 'react';
import PropTypes from 'prop-types';
import _get from 'lodash/get';
import { OrderItemContainer } from './order-item.container';

export function OrderItemList(props) {
    return (
        <ul className={'vlist'}>
            {props.orderItems.map((orderItem, index) => {
                const assembly = props.assemblyMap[orderItem.assembly_id];
                const assemblyName = _get(assembly, 'name', '');
                const departmentName = props.departmentMap[orderItem.department_id].name;
                const itemName = props.itemMap[orderItem.item_id].name;
                const editItemUrl = `/item/${orderItem.item_id}/edit`;

                return (
                    <OrderItemContainer
                        key={`orderItemContainer-${index}`}
                        csrf={props.csrf}
                        orderItemId={orderItem.id}
                        qty={orderItem.qty}
                        itemName={itemName}
                        editItemUrl={editItemUrl}
                        departmentName={departmentName}
                        assemblyName={assemblyName}
                        isPicked={orderItem.picked}
                    />
                );
            })}
        </ul>
    );
}

OrderItemList.propTypes = {
    assemblyMap: PropTypes.object.isRequired,
    csrf: PropTypes.string.isRequired,
    departmentMap: PropTypes.object.isRequired,
    itemMap: PropTypes.object.isRequired,
    orderItems: PropTypes.array.isRequired,
};

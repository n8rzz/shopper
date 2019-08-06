import React from 'react';
import PropTypes from 'prop-types';
import _get from 'lodash/get';
import { OrderItem } from './order-item.component';

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
                    <OrderItem
                        assemblyName={assemblyName}
                        csrf={props.csrf}
                        departmentName={departmentName}
                        editItemUrl={editItemUrl}
                        isPicked={orderItem.picked}
                        itemName={itemName}
                        key={`orderItem-${index}`}
                        orderItemId={orderItem.id}
                        onClickIsPickedHandler={props.onClickIsPickedHandler}
                        onClickRemoveItemHandler={props.onClickRemoveItemHandler}
                        qty={orderItem.qty}
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
    onClickIsPickedHandler: PropTypes.func.isRequired,
    onClickRemoveItemHandler: PropTypes.func.isRequired,
};

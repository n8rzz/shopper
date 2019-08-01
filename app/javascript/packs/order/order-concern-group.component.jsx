import React from 'react';
import PropTypes from 'prop-types';
import _get from 'lodash/get';
import _groupBy from 'lodash/groupBy';
import _sortBy from 'lodash/sortBy';
import { FILTER_CONCERN } from '../constants/filter-concern';
import { OrderItemContainer } from './order-item.container';

export class OrderConcernGroup extends React.Component {
    constructor(props) {
        super(props);

        this._sortedDepartmentNameList = _sortBy(this.props.departments, 'name');
        this._groupedByDepartmentOrderItemList = _groupBy(this.props.orderItems, 'department_id');
        this._sortedAssemblyNameList = _sortBy(this.props.assemblies, 'name');
        this._groupedByAssemblyOrderItemList = _groupBy(this.props.orderItems, 'assembly_id');
    }

    _buildOrderItemListForConcernGroupJsx(orderItems) {
        const orderItemListJsx = orderItems.map((orderItem, index) => {
            const assembly = this.props.assemblyMap[orderItem.assembly_id];
            const assemblyName = _get(assembly, 'name', '');
            const departmentName = this.props.departmentMap[orderItem.department_id].name;
            const itemName = this.props.itemMap[orderItem.item_id].name;
            const editItemUrl = `/item/${orderItem.item_id}/edit`;

            return (
                <OrderItemContainer
                    key={`orderItemContainer-${index}`}
                    csrf={this.props.csrf}
                    orderItemId={orderItem.id}
                    qty={orderItem.qty}
                    itemName={itemName}
                    editItemUrl={editItemUrl}
                    departmentName={departmentName}
                    assemblyName={assemblyName}
                    isPicked={orderItem.picked}
                />
            );
        });

        return (
            <ul className={'vlist'}>
                {orderItemListJsx}
            </ul>
        );
    }

    _buildConcernGroupJsx(name, index, itemList = []) {
        if (itemList.length === 0) {
            return null;
        }

        return (
            <div
                key={`orderItem-concern-${name}-${index}`}
                className={'concernGroup'}
            >
                <div className={'concernGroup-hd'}>
                    <h2>{name}</h2>
                </div>
                <div className={'concernGroup-bd'}>
                    {this._buildOrderItemListForConcernGroupJsx(itemList)}
                </div>
            </div>
        );
    }

    _buildOrderItemListForDepartmentConcernGroupJsx() {
        return this._sortedDepartmentNameList.reduce((sum, department, index) => {
            const itemsForDepartmentId = this._groupedByDepartmentOrderItemList[department.id];

            if (typeof itemsForDepartmentId === 'undefined') {
                return sum;
            }

            const orderItemConcernGroupJsx = this._buildConcernGroupJsx(department.name, index, itemsForDepartmentId);

            sum.push(orderItemConcernGroupJsx);

            return sum;
        }, []);
    }

    _buildOrderItemListForAssemblyConcernGroupJsx() {
        const assemblyItemsJsx = this._sortedAssemblyNameList.reduce((sum, assembly, index) => {
            const itemsForAssemblyId = this._groupedByAssemblyOrderItemList[assembly.id];

            if (typeof itemsForAssemblyId === 'undefined') {
                return sum;
            }

            const orderItemConcernGroupJsx = this._buildConcernGroupJsx(assembly.name, index, itemsForAssemblyId);

            sum.push(orderItemConcernGroupJsx);

            return sum;
        }, []);

        const nextIndexForNonGroupedItems = assemblyItemsJsx.length + 1;
        const itemsWithoutAssemblyJsx = this._buildConcernGroupJsx(
            'Not Grouped',
            nextIndexForNonGroupedItems,
            this._groupedByAssemblyOrderItemList.null,
        );

        assemblyItemsJsx.push(itemsWithoutAssemblyJsx);

        return assemblyItemsJsx;
    }

    render() {
        // TODO: rename this var
        let jsx = null;

        if (this.props.concern === FILTER_CONCERN.DEPARTMENT) {
            jsx = this._buildOrderItemListForDepartmentConcernGroupJsx();
        }

        if (this.props.concern === FILTER_CONCERN.MEAL) {
            jsx = this._buildOrderItemListForAssemblyConcernGroupJsx();
        }

        return jsx;
    }
}

OrderConcernGroup.propTypes = {
    csrf: PropTypes.string.isRequired,
    orderItems: PropTypes.array.isRequired,
    departmentMap: PropTypes.object.isRequired,
    assemblyMap: PropTypes.object.isRequired,
    itemMap: PropTypes.object.isRequired,
    concern: PropTypes.string.isRequired,
    departments: PropTypes.array.isRequired,
    assemblies: PropTypes.array.isRequired,
};

import React from 'react';
import PropTypes from 'prop-types';
import _get from 'lodash/get';
import _groupBy from 'lodash/groupBy';
import _sortBy from 'lodash/sortBy';
import _uniqBy from 'lodash/uniqBy';
import { OrderItem } from './order-item.component';
import { FILTER_CONCERN } from '../constants/filter-concern';

export class OrderConcernGroup extends React.Component {
    constructor(props) {
        super(props);

        this._sortedAssemblyNameList = _sortBy(props.assemblies, 'name');
        this._sortedDepartmentNameList = this._buildSortedDepartmentList();
        this._groupedByAssemblyOrderItemList = _groupBy(props.orderItems, 'assembly_id');
        this._groupedByDepartmentOrderItemList = _groupBy(props.orderItems, 'department_id');
    }

    componentWillUpdate(nextProps) {
        this._groupedByAssemblyOrderItemList = _groupBy(nextProps.orderItems, 'assembly_id');
        this._groupedByDepartmentOrderItemList = _groupBy(nextProps.orderItems, 'department_id');
    }

    _buildSortedDepartmentList() {
        if (this.props.locationDepartments.length > 0) {
            return this._buildSortedDepartmentListWithSortOrder();
        }

        return this._buildSortedByNameDepartmentList();
    }

    _buildSortedDepartmentListWithSortOrder() {
        const departmentListBySortOrder = this.props.locationDepartments.map(
            (locationDepartment) => this.props.departmentMap[locationDepartment.department_id],
        );

        return _uniqBy([
            ...departmentListBySortOrder,
            ...this._buildSortedByNameDepartmentList(),
        ], 'id');
    }

    _buildSortedByNameDepartmentList() {
        return _sortBy(this.props.departments, 'name');
    }

    _buildOrderItemListForConcernGroupJsx(orderItems) {
        const orderItemListJsx = orderItems.map((orderItem, index) => {
            const assembly = this.props.assemblyMap[orderItem.assembly_id];
            const assemblyName = _get(assembly, 'name', '');
            const departmentName = this.props.departmentMap[orderItem.department_id].name;
            const itemName = this.props.itemMap[orderItem.item_id].name;
            const editItemUrl = `/item/${orderItem.item_id}/edit`;

            return (
                <OrderItem
                    assemblyName={assemblyName}
                    csrf={this.props.csrf}
                    departmentName={departmentName}
                    editItemUrl={editItemUrl}
                    isPicked={orderItem.picked}
                    itemName={itemName}
                    key={`orderItem-${index}`}
                    orderItemId={orderItem.id}
                    onClickIsPickedHandler={this.props.onClickIsPickedHandler}
                    onClickRemoveItemHandler={this.props.onClickRemoveItemHandler}
                    qty={orderItem.qty}
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
    assemblies: PropTypes.array.isRequired,
    assemblyMap: PropTypes.object.isRequired,
    concern: PropTypes.string.isRequired,
    csrf: PropTypes.string.isRequired,
    departmentMap: PropTypes.object.isRequired,
    departments: PropTypes.array.isRequired,
    itemMap: PropTypes.object.isRequired,
    locationDepartments: PropTypes.array.isRequired,
    orderItems: PropTypes.array.isRequired,
    onClickIsPickedHandler: PropTypes.func.isRequired,
    onClickRemoveItemHandler: PropTypes.func.isRequired,
};

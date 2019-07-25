import React from 'react';
import PropTypes from 'prop-types';
import _groupBy from 'lodash/groupBy';
import _sortBy from 'lodash/sortBy';
import { ConcernGroup } from './concern-group.component';

export class GroupedItemList extends React.PureComponent {
    constructor(props) {
        super(props);

        this._sortedDepartmentList = _sortBy(this.props.departments, 'name');
        this._groupedItemList = _groupBy(this.props.items, 'department_id');
    }

    render() {
        const groupListJsx = this._sortedDepartmentList.map((department, index) => {
            const itemsForDepartmentId = this._groupedItemList[department.id];

            if (typeof itemsForDepartmentId === 'undefined') {
                return null;
            }

            return (
                <ConcernGroup
                    csrf={this.props.csrf}
                    departmentMap={this.props.departmentMap}
                    groupName={department.name}
                    key={`ConcernGroup-${index}`}
                    itemList={itemsForDepartmentId}
                />
            );
        });

        return (
            <React.Fragment>
                {groupListJsx}
            </React.Fragment>
        );
    }
}

GroupedItemList.propTypes = {
    csrf: PropTypes.string.isRequired,
    departments: PropTypes.array.isRequired,
    departmentMap: PropTypes.object.isRequired,
    items: PropTypes.array.isRequired,
};

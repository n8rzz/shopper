import React from 'react';
import PropTypes from 'prop-types';
import classnames from 'classnames';

export class AssemblyItem extends React.Component {
    _buildAssemblyGroupHeaderJsx() {
        const assemblyItemList = this.props.assemblyItemsGroupedByAssemblyId[this.props.assembly.id];

        return (
            <div className={'listItem'}>
                <div className={'listItem-hd'}>
                    <h2
                        className={'hdg hdg_2'}
                        onClick={this.props.onClickAccordionTriggerHandler}
                    >
                        {this.props.assembly.name}
                    </h2>
                    <div>
                        <button
                            type={'button'}
                            data-assembly-id={this.props.assembly.id}
                            onClick={this.props.onClickAddAssemblyHandler}
                        >
                            Add to order
                        </button>
                    </div>
                </div>
                <div className={'listItem-ft'}>
                    <ul className={'stereo'}>
                        <li>
                            Items:
                            {assemblyItemList.length}
                        </li>
                        <li>
                            <a
                                className={'link'}
                                href={'/assemblies/'}
                            >
                                Edit Assembly
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        );
    }

    _buildAssemblyItemList() {
        const assemblyItemList = this.props.assemblyItemsGroupedByAssemblyId[this.props.assembly.id];
        const assemblyItemListJsx = assemblyItemList.map((assemblyItem, index) => {
            const item = this.props.itemIdMap[assemblyItem.item_id];
            const departmentName = this.props.departmentIdMap[item.department_id].name;

            return (
                <li
                    key={`assemblyItem-${index}`}
                    className={'listItem listItem-child'}
                >
                    <div className={'listItem-hd'}>
                        <h3 className={'hdg'}>
                            {item.name}
                        </h3>
                    </div>
                    <div className={'listItem-ft'}>
                        <ul className={'stereo'}>
                            <li>
                                {departmentName}
                            </li>
                            <li>
                                <form>
                                    <button
                                        type={'submit'}
                                        data-department-id={item.department_id}
                                        data-assembly-item-id={assemblyItem.id}
                                        onClick={this.props.onClickAddAssemblyItemHandler}
                                    >
                                        Add Item to order
                                    </button>
                                </form>
                            </li>
                        </ul>
                    </div>
                </li>
            );
        });

        return assemblyItemListJsx;
    }

    _buildAccordionListClassnames() {
        return classnames({
            vlist: true,
            'vlist-short': true,
            'u-isVisuallyHidden': !this.props.isOpen,
        });
    }

    render() {
        return (
            <li key={`assembly-${this.props.assembly.name}`}>
                {this._buildAssemblyGroupHeaderJsx()}
                <ul className={this._buildAccordionListClassnames()}>
                    {this._buildAssemblyItemList()}
                </ul>
            </li>
        );
    }
}

AssemblyItem.propTypes = {
    assembly: PropTypes.object.isRequired,
    assemblyItemsGroupedByAssemblyId: PropTypes.object.isRequired,
    itemIdMap: PropTypes.object.isRequired,
    departmentIdMap: PropTypes.object.isRequired,
    isOpen: PropTypes.bool.isRequired,
    onClickAccordionTriggerHandler: PropTypes.func.isRequired,
    onClickAddAssemblyHandler: PropTypes.func.isRequired,
    onClickAddAssemblyItemHandler: PropTypes.func.isRequired,
};
